package org.jumpmind.db.platform.generic;

import org.jumpmind.db.alter.ColumnAutoIncrementChange;
import org.jumpmind.db.alter.TableChange;
import org.jumpmind.db.model.Column;
import org.jumpmind.db.model.Database;
import org.jumpmind.db.model.Table;
import org.jumpmind.db.platform.AbstractDdlBuilder;
import org.jumpmind.db.platform.IDatabasePlatform;
import org.jumpmind.db.sql.JdbcSqlTemplate;
import org.jumpmind.db.sql.SqlException;

import javax.sql.DataSource;
import java.sql.*;
import java.util.Iterator;
import java.util.List;

import static org.apache.commons.lang.StringUtils.isNotBlank;

public class GenericJdbcDdlBuilder extends AbstractDdlBuilder {

    public GenericJdbcDdlBuilder(String databaseName, IDatabasePlatform platform) {
        super(databaseName);

        databaseInfo.setTriggersSupported(false);
        databaseInfo.setForeignKeysSupported(false);
        databaseInfo.setNullAsDefaultValueRequired(true);
        databaseInfo.setHasNullDefault(Types.TIMESTAMP, true);
        databaseInfo.setHasNullDefault(Types.DATE, true);
        databaseInfo.setHasNullDefault(Types.TIME, true);
        databaseInfo.setRequiresAutoCommitForDdl(true);
        
        DataSource ds = platform.getDataSource();
        Connection c = null;
        try {
            c = ds.getConnection();
            DatabaseMetaData meta = c.getMetaData();
            String quoteString = null;
            try {
            		meta.getIdentifierQuoteString();
            } catch (Exception e) {
            		// Do nothing just leave blank if meta data is not supported
            }
            
            if (isNotBlank(quoteString)) {
                databaseInfo.setDelimiterToken(quoteString);
            } else {
                databaseInfo.setDelimitedIdentifiersSupported(false);
                databaseInfo.setDelimiterToken("");
            }
            
            if (!setNativeMapping(Types.LONGVARCHAR, meta, Types.LONGVARCHAR)) {
                if (!setNativeMapping(Types.LONGVARCHAR, meta, Types.CLOB)) {
                    setNativeMapping(Types.LONGVARCHAR, meta, Types.VARCHAR);
                }
            }
            
        } catch (SQLException ex) {
            throw new SqlException(ex);
        } finally {
            JdbcSqlTemplate.close(c);
        }
    }
    
    @Override
    protected void writeColumnAutoIncrementStmt(Table table, Column column, StringBuilder ddl) {
        /**
         *  Auto increment isn't supported for generic platforms
         */        
    }
    
    protected boolean setNativeMapping(int targetJdbcType, DatabaseMetaData meta, int acceptableType) throws SQLException {
        ResultSet rs = null;
        try {
            rs = meta.getTypeInfo();
            while (rs.next()) {
                String name = rs.getString("TYPE_NAME");
                int type = rs.getInt("DATA_TYPE");
                if (type == acceptableType) {
                    databaseInfo.addNativeTypeMapping(targetJdbcType, name, acceptableType);
                    return true;
                }
            }
        } catch (Exception e) {
        		// Do nothing if meta data not supported
        } finally {
            JdbcSqlTemplate.close(rs);
        }
        return false;
    }
    
    protected void processTableStructureChanges(Database currentModel, Database desiredModel,
            Table sourceTable, Table targetTable, List<TableChange> changes, StringBuilder ddl) {
        for (Iterator<TableChange> changeIt = changes.iterator(); changeIt.hasNext();) {
            TableChange change = changeIt.next();
            if (change instanceof ColumnAutoIncrementChange) {
                /**
                 *  Auto increment isn't supported for generic platforms
                 */
                 changeIt.remove();
            }
        }
    }

}
