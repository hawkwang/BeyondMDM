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
package org.jumpmind.symmetric.load;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jumpmind.db.platform.IDatabasePlatform;
import org.jumpmind.db.sql.ISqlTransaction;
import org.jumpmind.extension.IBuiltInExtensionPoint;
import org.jumpmind.symmetric.common.ParameterConstants;
import org.jumpmind.symmetric.db.ISymmetricDialect;
import org.jumpmind.symmetric.io.data.IDataWriter;
import org.jumpmind.symmetric.io.data.writer.CassandraDatabaseWriter;
import org.jumpmind.symmetric.io.data.writer.Conflict;
import org.jumpmind.symmetric.io.data.writer.Conflict.PingBack;
import org.jumpmind.symmetric.io.data.writer.DatabaseWriterSettings;
import org.jumpmind.symmetric.io.data.writer.DefaultTransformWriterConflictResolver;
import org.jumpmind.symmetric.io.data.writer.DynamicDefaultDatabaseWriter;
import org.jumpmind.symmetric.io.data.writer.IDatabaseWriterErrorHandler;
import org.jumpmind.symmetric.io.data.writer.IDatabaseWriterFilter;
import org.jumpmind.symmetric.io.data.writer.KafkaWriter;
import org.jumpmind.symmetric.io.data.writer.ResolvedData;
import org.jumpmind.symmetric.io.data.writer.TransformWriter;
import org.jumpmind.symmetric.service.IParameterService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DefaultDataLoaderFactory extends AbstractDataLoaderFactory implements IDataLoaderFactory, IBuiltInExtensionPoint {

    protected final Logger log = LoggerFactory.getLogger(getClass());

    public DefaultDataLoaderFactory() {
    }

    public DefaultDataLoaderFactory(IParameterService parameterService) {
        this.parameterService = parameterService;
    }

    public String getTypeName() {
        return "default";
    }

    public IDataWriter getDataWriter(final String sourceNodeId, final ISymmetricDialect symmetricDialect,
            TransformWriter transformWriter, List<IDatabaseWriterFilter> filters,
            List<IDatabaseWriterErrorHandler> errorHandlers, List<? extends Conflict> conflictSettings,
            List<ResolvedData> resolvedData) {

        if (symmetricDialect.getTargetPlatform().getClass().getSimpleName().equals("CassandraPlatform")) {
            try {
                // TODO: Evalaute if ConflictResolver will work for Cassandra and if so remove duplicate code.
                return new CassandraDatabaseWriter(symmetricDialect.getPlatform(), symmetricDialect.getTargetPlatform(),
                        symmetricDialect.getTablePrefix(), new DefaultTransformWriterConflictResolver(transformWriter),
                        buildDatabaseWriterSettings(filters, errorHandlers, conflictSettings, resolvedData));

            } catch (Exception e) {
                log.warn(
                        "Failed to create the cassandra database writer.  Check to see if all of the required jars have been added",
                        e);
                if (e instanceof RuntimeException) {
                    throw (RuntimeException) e;
                } else {
                    throw new RuntimeException(e);
                }
            }
        }

        if (symmetricDialect.getTargetPlatform().getClass().getSimpleName().equals("KafkaPlatform")) {
            try {
                if (filters == null) {
                    filters = new ArrayList<IDatabaseWriterFilter>();
                }
                filters.add(new KafkaWriterFilter(this.parameterService));

                return new KafkaWriter(symmetricDialect.getPlatform(), symmetricDialect.getTargetPlatform(),
                        symmetricDialect.getTablePrefix(), new DefaultTransformWriterConflictResolver(transformWriter),
                        buildDatabaseWriterSettings(filters, errorHandlers, conflictSettings, resolvedData));

            } catch (Exception e) {
                log.warn("Failed to create the kafka writer.", e);
                if (e instanceof RuntimeException) {
                    throw (RuntimeException) e;
                } else {
                    throw new RuntimeException(e);
                }
            }
        }

        DynamicDefaultDatabaseWriter writer = new DynamicDefaultDatabaseWriter(symmetricDialect.getPlatform(),
                symmetricDialect.getTargetPlatform(), symmetricDialect.getTablePrefix(),
                new DefaultTransformWriterConflictResolver(transformWriter) {
                    @Override
                    protected void beforeResolutionAttempt(Conflict conflict) {
                        if (conflict.getPingBack() != PingBack.OFF) {
                            DynamicDefaultDatabaseWriter writer = transformWriter
                                    .getNestedWriterOfType(DynamicDefaultDatabaseWriter.class);
                            ISqlTransaction transaction = writer.getTransaction();
                            if (transaction != null) {
                                symmetricDialect.enableSyncTriggers(transaction);
                            }
                        }
                    }

                    @Override
                    protected void afterResolutionAttempt(Conflict conflict) {
                        if (conflict.getPingBack() == PingBack.SINGLE_ROW) {
                            DynamicDefaultDatabaseWriter writer = transformWriter
                                    .getNestedWriterOfType(DynamicDefaultDatabaseWriter.class);
                            ISqlTransaction transaction = writer.getTransaction();
                            if (transaction != null) {
                                symmetricDialect.disableSyncTriggers(transaction, sourceNodeId);
                            }
                        }
                    }
                }, buildDatabaseWriterSettings(filters, errorHandlers, conflictSettings, resolvedData));

        return writer;
    }

    public boolean isPlatformSupported(IDatabasePlatform platform) {
        return true;
    }

    protected DatabaseWriterSettings buildDatabaseWriterSettings(List<IDatabaseWriterFilter> filters,
            List<IDatabaseWriterErrorHandler> errorHandlers, List<? extends Conflict> conflictSettings,
            List<ResolvedData> resolvedDatas) {
        DatabaseWriterSettings settings = buildParameterDatabaseWritterSettings();
        settings.setDatabaseWriterFilters(filters);
        settings.setDatabaseWriterErrorHandlers(errorHandlers);
        
        
        Map<String, Conflict> byChannel = new HashMap<String, Conflict>();
        Map<String, Conflict> byTable = new HashMap<String, Conflict>();
        boolean multipleDefaultSettingsFound = false;
        if (conflictSettings != null) {
            for (Conflict conflictSetting : conflictSettings) {
                String qualifiedTableName = conflictSetting.toQualifiedTableName();
                if (StringUtils.isNotBlank(qualifiedTableName)) {
                    byTable.put(qualifiedTableName, conflictSetting);
                } else if (StringUtils.isNotBlank(conflictSetting.getTargetChannelId())) {
                    byChannel.put(conflictSetting.getTargetChannelId(), conflictSetting);
                } else {
                    if (settings.getDefaultConflictSetting() != null) {
                        multipleDefaultSettingsFound = true;
                    }
                    settings.setDefaultConflictSetting(conflictSetting);
                }
            }
        }

        if (multipleDefaultSettingsFound) {
            log.warn("There were multiple default conflict settings found.  Using '{}' as the default",
                    settings.getDefaultConflictSetting().getConflictId());
        }
        settings.setConflictSettingsByChannel(byChannel);
        settings.setConflictSettingsByTable(byTable);
        settings.setResolvedData(resolvedDatas);
        return settings;
    }
}
