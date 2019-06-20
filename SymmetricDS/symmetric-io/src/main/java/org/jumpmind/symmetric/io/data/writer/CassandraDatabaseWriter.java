package org.jumpmind.symmetric.io.data.writer;

import java.math.BigDecimal;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.jumpmind.db.model.Column;
import org.jumpmind.db.model.Table;
import org.jumpmind.db.model.TypeMap;
import org.jumpmind.db.platform.IDatabasePlatform;
import org.jumpmind.db.platform.cassandra.CassandraPlatform;
import org.jumpmind.symmetric.io.data.CsvData;
import org.jumpmind.symmetric.io.data.DataEventType;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.DataType;
import com.datastax.driver.core.LocalDate;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.Session;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class CassandraDatabaseWriter extends DynamicDefaultDatabaseWriter {

	protected Session session;

	Map<String, Map<String, Table>> metaData = new HashMap<String, Map<String, Table>>();

	PreparedStatement pstmt;

	SimpleDateFormat tsFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
	
	public CassandraDatabaseWriter(IDatabasePlatform symmetricPlatform, 
			IDatabasePlatform targetPlatform,String prefix, 
            IDatabaseWriterConflictResolver conflictResolver, DatabaseWriterSettings settings) {
		
		super(symmetricPlatform, targetPlatform, prefix, conflictResolver, settings);
		this.metaData = ((CassandraPlatform) targetPlatform).getMetaData();
		this.session = ((CassandraPlatform) targetPlatform).getSession();
	}

	@Override
	protected void prepare() {
		if (isSymmetricTable(this.targetTable != null ? this.targetTable.getName() : "")) {
			super.prepare();
		} else {
			pstmt = session.prepare(currentDmlStatement.getSql());
		}
	}
	
	@Override
	protected void prepare(String sql, CsvData data) {
		if (isSymmetricTable(this.targetTable != null ? this.targetTable.getName() : "") && !isUserSendSql(sql, data)) {
			super.prepare(sql, data);
		} else {
			pstmt = session.prepare(sql);
		}
	}
	
	/*
	 * Checks if a send sql event type was for the sym_node table.  If it is the send sql shoudl run against Cassandra tables otherwise it is an internal Symmetric
	 * send sql.
	 */
	protected boolean isUserSendSql(String sql, CsvData data) {
		return data.getDataEventType().equals(DataEventType.SQL) 
				&& this.targetTable.getNameLowerCase().equals(this.getTablePrefix().toLowerCase() + "_node")
				&& !sql.toLowerCase().contains("from " + this.getTablePrefix().toLowerCase() + "_node");
	}
	
	@Override
	public int prepareAndExecute(String sql, CsvData data) {
		if (isUserSendSql(sql, data)) {
			return session.execute(sql).wasApplied() ? 1 : 0;
		}
		else {
			return super.prepareAndExecute(sql, data);
		}
	}

	@Override
	protected int execute(CsvData data, String[] values) {
		if (isSymmetricTable(this.targetTable != null ? this.targetTable.getName() : "")) {
			return super.execute(data, values);
		} 
		BoundStatement bstmt = pstmt.bind();
		currentDmlValues = getPlatform().getObjectValues(batch.getBinaryEncoding(), values,
				currentDmlStatement.getMetaData(), false, writerSettings.isFitToColumn());
		if (log.isDebugEnabled()) {
			log.debug("Submitting data [{}] with types [{}]",
					dmlValuesToString(currentDmlValues, this.currentDmlStatement.getTypes()),
					TypeMap.getJdbcTypeDescriptions(this.currentDmlStatement.getTypes()));
		}

		bindVariables(bstmt, this.currentDmlStatement.getColumns(), this.currentDmlStatement.getTypes(), values);
		return session.execute(bstmt).wasApplied() ? 1 : 0;
	}

	@Override
	protected Table lookupTableAtTarget(Table sourceTable) {
		if (sourceTable != null && isSymmetricTable(sourceTable.getName())) {
			return super.lookupTableAtTarget(sourceTable);
		}
		String keyspace = sourceTable.getCatalog() == null ? sourceTable.getSchema() : sourceTable.getCatalog();
		Map<String, Table> tables = metaData.get(keyspace);
		Table returnTable = tables == null ? sourceTable : tables.get(sourceTable.getName());
		
		// ADD target table param is missing do not error
		if (returnTable == null) {
			throw new RuntimeException("Unable to find Cassandra target table " + sourceTable.getName() + " in keyspace " + keyspace);
		}
		return returnTable;
	}

	@Override
	protected boolean create(CsvData data) {
		return false;
	}

	@Override
	protected void logFailureDetails(Throwable e, CsvData data, boolean logLastDmlDetails) {
	}

	@Override
	protected void allowInsertIntoAutoIncrementColumns(boolean value, Table table) {
	}
	
	protected void bindVariables(BoundStatement bstmt, Column[] columns, int[] types, String[] values) {
		// TODO data time mappings

		int i = 0;
		for (int type : types) {
			if (Types.INTEGER == type) {
				bstmt.setInt(i, Integer.parseInt(values[i]));
			} else if (Types.VARCHAR == type) {
				bstmt.setString(i, values[i]);
			} else if (Types.JAVA_OBJECT == type) {
				bstmt.setUUID(i, UUID.fromString(values[i]));
			} else if (Types.TIMESTAMP == type) {
				try {
					bstmt.setTimestamp(i, tsFormat.parse(values[i]));
				} catch (ParseException e) {
					throw new RuntimeException("Unable to bind timestamp column " + columns[i].getName() + " with value " + values[i]);
				}
			} else if (Types.DATE == type) {
				try {
					bstmt.setDate(i, LocalDate.fromMillisSinceEpoch(dateFormat.parse(values[i]).getTime()));
				} catch (ParseException e) {
					throw new RuntimeException("Unable to bind date column " + columns[i].getName() + " with value " + values[i]);
				}
			} else if (Types.TIME == type) {
				try 	{
					bstmt.setTime(i, LocalTime.parse(values[i], timeFormat).toNanoOfDay());
				} catch (DateTimeParseException e) {
					throw new RuntimeException("Unable to bind time column " + columns[i].getName() + " with value " + values[i]);
				}
			} else if (Types.BOOLEAN == type) {
				bstmt.setBool(i, Boolean.parseBoolean(values[i]));
			} else if (Types.DECIMAL == type) {
				bstmt.setDecimal(i, new BigDecimal(values[i]));
			} else if (Types.DOUBLE == type) {
				bstmt.setDouble(i, Double.parseDouble(values[i]));
			} else if (Types.FLOAT == type) {
				bstmt.setFloat(i, Float.parseFloat(values[i]));
			} else if (Types.STRUCT == type) {
				bstmt.setList(i, parseList(columns[i], values[i]));
			} else if (Types.REF == type) {
				bstmt.setSet(i, parseSet(columns[i], values[i]));
			} else if (Types.OTHER == type) {
				bstmt.setMap(i, parseMap(columns[i], values[i]));
			}

			i++;
		}
	}

	protected List<Object> parseList(Column c, String val) {
		try {
			if (c.getDescription() != null) {
				if (c.getDescription().toLowerCase().equals("text") || c.getDescription().toLowerCase().equals("varchar")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<String>>(){});
				} else if (c.getDescription().toLowerCase().equals("int")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("bigint")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("smallint")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("tinyint")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("double")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Double>>(){});
				} else if (c.getDescription().toLowerCase().equals("decimal")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<BigDecimal>>(){});
				} else if (c.getDescription().toLowerCase().equals("float")) {
					return new ObjectMapper().readValue(val, new TypeReference<List<Float>>(){});
				}
			}
			return new ObjectMapper().readValue(val, new TypeReference<List<Object>>(){});
			
		} catch (Exception e) {
			throw new RuntimeException("Unable to convert value to list, value=" + val,e);
		}
	}

	protected Set<Object> parseSet(Column c, String val) {
		try {
			if (c.getDescription() != null) {
				if (c.getDescription().toLowerCase().equals("text") || c.getDescription().toLowerCase().equals("varchar")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<String>>(){});
				} else if (c.getDescription().toLowerCase().equals("int")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("bigint")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("smallint")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("tinyint")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Integer>>(){});
				} else if (c.getDescription().toLowerCase().equals("double")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Double>>(){});
				} else if (c.getDescription().toLowerCase().equals("decimal")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<BigDecimal>>(){});
				} else if (c.getDescription().toLowerCase().equals("float")) {
					return new ObjectMapper().readValue(val, new TypeReference<Set<Float>>(){});
				}
			}
			return new ObjectMapper().readValue(val, new TypeReference<Set<Object>>(){});
			
		} catch (Exception e) {
			throw new RuntimeException("Unable to convert value to set, value=" + val,e);
		}
	}

	protected Map<Object, Object> parseMap(Column c, String val) {
		try {
			if (c.getDescription() != null) {
				// TODO find dynamic way to create map types based on column types
				String[] parts = c.getDescription().split(",");
				if (parts[0].equals(DataType.Name.INT.name()) && 
						(parts[1].equals(DataType.Name.TEXT.name()) || parts[1].equals(DataType.Name.VARCHAR.name()))) {
					return new ObjectMapper().readValue(val, new TypeReference<Map<Integer, String>>(){});
				} else if ((parts[0].equals(DataType.Name.TEXT.name()) || parts[0].equals(DataType.Name.VARCHAR.name())) && 
						(parts[1].equals(DataType.Name.TEXT.name()) || parts[1].equals(DataType.Name.VARCHAR.name()))) {
					return new ObjectMapper().readValue(val, new TypeReference<Map<String, String>>(){});
				}
			}
			return new ObjectMapper().readValue(val, new TypeReference<Map<Object, Object>>(){});
		} catch (Exception e) {
			throw new RuntimeException("Unable to convert value to map, expecting JSON, value=" + val,e);
		}
	}
}
