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
package org.jumpmind.symmetric.job;

import org.jumpmind.symmetric.ISymmetricEngine;
import org.jumpmind.symmetric.service.ClusterConstants;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

/*
 * Background job that checks if cached objects should be refreshed
 */
public class RefreshCacheJob extends AbstractJob {

    public RefreshCacheJob(ISymmetricEngine engine, ThreadPoolTaskScheduler taskScheduler) {
        super(ClusterConstants.REFRESH_CACHE, engine, taskScheduler);
    }
    
    @Override
    public JobDefaults getDefaults() {
        return new JobDefaults()
                .schedule("0/30 * * * * *")
                .description("Refresh configuration cache");
    } 
    
    @Override
    public void doJob(boolean force) throws Exception {
        engine.getParameterService().refreshFromDatabase();
        engine.getTriggerRouterService().refreshFromDatabase();
        engine.getGroupletService().refreshFromDatabase();
        engine.getConfigurationService().refreshFromDatabase();
        engine.getTransformService().refreshFromDatabase();
        engine.getDataLoaderService().refreshFromDatabase();
        engine.getLoadFilterService().refreshFromDatabase();
        engine.getFileSyncService().refreshFromDatabase();
    }

}
