package org.jumpmind.symmetric.load;

import org.jumpmind.extension.IExtensionPoint;
import org.jumpmind.symmetric.model.Node;
import org.jumpmind.symmetric.model.TriggerHistory;

import java.util.List;

public interface IReloadGenerator extends IExtensionPoint {
    
    List<TriggerHistory> getActiveTriggerHistories(Node targetNode);
}
