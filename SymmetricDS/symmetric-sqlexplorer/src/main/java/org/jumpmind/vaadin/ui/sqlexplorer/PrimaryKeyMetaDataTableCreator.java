/**
 * Licensed to JumpMind Inc under one or more contributor
 * license agreements.  See the NOTICE file distributed
 * with this work for additional information regarding
 * copyright ownership.  JumpMind Inc licenses this file
 * to you under the GNU General Public License, version 3.0 (GPLv3)
 * (the "License"); you may not use this file except in compliance
 * with the License.
 *
 * You should have received a copy of the GNU General Public License,
 * version 3.0 (GPLv3) along with this library; if not, see
 * <http://www.gnu.org/licenses/>.
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.jumpmind.vaadin.ui.sqlexplorer;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jumpmind.db.model.Table;
import org.jumpmind.db.sql.JdbcSqlTemplate;

public class PrimaryKeyMetaDataTableCreator extends AbstractMetaDataTableCreator {

    public PrimaryKeyMetaDataTableCreator(JdbcSqlTemplate sqlTemplate, Table table, Settings settings) {
        super(sqlTemplate, table, settings);
    }

    @Override
    protected ResultSet getMetaDataResultSet(DatabaseMetaData metadata) throws SQLException {
        return metadata.getPrimaryKeys(table.getCatalog(), table.getSchema(),
                table.getName());
    }

    @Override
    protected String[] getColumnsToExclude() {
        return TABLE_NAME_METADATA_COLUMNS;
    }
}
