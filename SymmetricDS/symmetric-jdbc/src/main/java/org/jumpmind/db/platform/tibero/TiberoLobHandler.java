package org.jumpmind.db.platform.tibero;

import org.jumpmind.db.sql.SymmetricLobHandler;
import org.springframework.jdbc.support.lob.DefaultLobHandler;

import java.sql.ResultSet;
import java.sql.SQLException;

@SuppressWarnings("deprecation")
public class TiberoLobHandler extends SymmetricLobHandler {

    DefaultLobHandler longHandler = new DefaultLobHandler();

    public TiberoLobHandler() {
        super();
    }

    @Override
    public String getClobAsString(ResultSet rs, int columnIndex, int jdbcTypeCode,
            String jdbcTypeName) throws SQLException {
        if ("LONG".equalsIgnoreCase(jdbcTypeName)) {
            /**
             * Ironically, the Oracle Lob Handler doesn't handle the Oracle
             * specific data type of Long. We should probably swap out the
             * Oracle Lob Handler altogether but I haven't been able to get it
             * to insert Empty Clob Values appropriately yet.
             */
            return longHandler.getClobAsString(rs, columnIndex);
        } else {
            return super.getClobAsString(rs, columnIndex, jdbcTypeCode, jdbcTypeName);
        }
    }

}
