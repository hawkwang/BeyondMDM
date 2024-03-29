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
package org.jumpmind.symmetric.db.hsqldb;

import org.jumpmind.symmetric.db.EmbeddedDbFunctions;

import java.util.HashMap;
import java.util.Map;

/**
 * 
 */
public class HsqlDbFunctions extends EmbeddedDbFunctions {

    private static Map<String, ThreadLocal<String>> sessionVariables = new HashMap<String, ThreadLocal<String>>();

    public static void setSession(String key, String value) {
        ThreadLocal<String> local = sessionVariables.get(key);
        if (local == null) {
            local = new ThreadLocal<String>();
            sessionVariables.put(key, local);
        }
        if (value != null) {
            local.set(value);
        } else {
            local.remove();
        }
    }

    public static String getSession(String key) {
        ThreadLocal<String> local = sessionVariables.get(key);
        if (local != null) {
            return local.get();
        } else {
            return null;
        }
    }

}