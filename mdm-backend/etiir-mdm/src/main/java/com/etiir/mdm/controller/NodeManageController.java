package com.etiir.mdm.controller;

import com.etiir.mdm.common.Const;
import com.etiir.mdm.entity.MRouter;
import com.etiir.mdm.mapper.symmetric.NodeGroupLinkMapper;
import com.etiir.mdm.mapper.symmetric.NodeGroupMapper;
import com.etiir.mdm.service.symmetricDS.RouterService;
import com.etiir.mdm.util.HTTPUtils;
import com.pig4cloud.pigx.common.core.constant.CommonConstants;
import com.pig4cloud.pigx.common.core.util.R;
import io.swagger.annotations.ApiOperation;
import org.jumpmind.symmetric.model.NodeGroup;
import org.jumpmind.symmetric.model.NodeGroupLink;
import org.jumpmind.symmetric.model.NodeGroupLinkAction;
import org.jumpmind.symmetric.web.rest.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by jsonhua on 2019/5/7.
 */
@RestController
@RequestMapping("/api")
public class NodeManageController  extends BaseController {

    @Autowired
    @Qualifier(value = "remoteRestTemplate")
    RestTemplate restTemplate;

    @Value("${symmetricDS.api.url}")
    private String symmetricDSApiUrl;

    @Value("${symmetricDS.registration.url}")
    private String symmetricRegistrationUrl;

    @Autowired
    private NodeGroupLinkMapper groupLinkMapper;

    @Autowired
    private NodeGroupMapper groupMapper;

    @Autowired
    private RouterService routerService;

    /**
     * Returns an overall status for the single engine of the node.
     *
     * @return {@link NodeStatus}
     *
     *         <pre>
     * Example xml reponse is as follows:<br><br>
     *   {@code
     * <nodestatus>
     * <batchInErrorCount>0</batchInErrorCount>
     * <batchToSendCount>0</batchToSendCount>
     * <databaseType>Microsoft SQL Server</databaseType>
     * <databaseVersion>9.0</databaseVersion>
     * <deploymentType>professional</deploymentType>
     *  <externalId>root</externalId>
     *  <initialLoaded>true</initialLoaded>
     *  <lastHeartbeat>2012-11-17 14:52:19.267</lastHeartbeat>
     * <nodeGroupId>RootSugarDB</nodeGroupId>
     * <nodeId>root</nodeId>
     * <registered>true</registered>
     * <registrationServer>false</registrationServer>
     * <started>true</started>
     * <symmetricVersion>3.1.10</symmetricVersion>
     * <syncEnabled>true</syncEnabled>
     * <syncUrl>http://my-machine-name:31415/sync/RootSugarDB-root</syncUrl>
     * </nodestatus>
     *   }
     * <br>
     * Example json response is as follows:<br><br>
     * {"started":true,"registered":true,"registrationServer":false,"initialLoaded":true,
     * "nodeId":"root","nodeGroupId":"RootSugarDB","externalId":"root",
     * "syncUrl":"http://my-machine-name:31415/sync/RootSugarDB-root","databaseType":"Microsoft SQL Server",
     * "databaseVersion":"9.0","syncEnabled":true,"createdAtNodeId":null,"batchToSendCount":0,
     * "batchInErrorCount":0,"deploymentType":"professional","symmetricVersion":"3.1.10",
     * "lastHeartbeat":"2012-11-17 15:15:00.033","hearbeatInterval":null}
     * </pre>
     */
    @ApiOperation(value = "Obtain the status of the single engine")
    @RequestMapping(value = "/engine/status", method = RequestMethod.GET)
    @ResponseBody
    public final NodeStatus getStatus() {
        ResponseEntity<NodeStatus> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/status", HttpMethod.GET, HTTPUtils.makeRequestEntity(), NodeStatus.class);
        return (NodeStatus)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Returns an overall status for the specified engine of the node.
     *
     * @return {@link NodeStatus}
     */
    @ApiOperation(value = "Obtain the status of the specified engine")
    @RequestMapping(value = "/engine/{engine}/status", method = RequestMethod.GET)
    @ResponseBody
    public final NodeStatus getStatusByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<NodeStatus> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/status", HttpMethod.GET, HTTPUtils.makeRequestEntity(), NodeStatus.class);
        return (NodeStatus)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Provides a list of {@link Engine} that are configured on the node.
     *
     * @return {@link EngineList} - Engines configured on the node <br>
     *
     *         <pre>
     * Example xml reponse is as follows:<br><br>
     *   {@code
     *   <enginelist>
     *      <engines>
     *         <name>RootSugarDB-root</name>
     *      </engines>
     *   </enginelist>
     *   }
     * <br>
     * Example json response is as follows:<br><br>
     *   {"engines":[{"name":"RootSugarDB-root"}]}
     * </pre>
     */
    @ApiOperation(value = "Obtain a list of configured Engines")
    @RequestMapping(value = "/enginelist", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final R getEngineList() {
        ResponseEntity<EngineList> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/enginelist", HttpMethod.GET, HTTPUtils.makeRequestEntity(), EngineList.class);
        List<HashMap<String,Object>> nodeList = new ArrayList<>();
        for(Engine engine:responseEntity.getBody().getEngines()){
            HashMap<String,Object> obj = new HashMap<>();
            obj.put("name",engine.getName());
            //前段传值为id，此处engin只有一个name字段，赋给id
            obj.put("id",engine.getName());
            obj.put("parentId",-1);
            nodeList.add(obj);
        }
        return new R<>(nodeList);
    }

    /**
     * Provides Node information for the single engine
     *
     * return {@link Node}<br>
     *
     * <pre>
     * Example xml reponse is as follows:<br><br>
     *   {@code
     *   <node>
     *      <batchInErrorCount>0</batchInErrorCount>
     *      <batchToSendCount>0</batchToSendCount>
     *      <externalId>server01</externalId>
     *      <initialLoaded>true</initialLoaded>
     *      <lastHeartbeat>2012-12-20T09:26:02-05:00</lastHeartbeat>
     *      <name>server01</name>
     *      <registered>true</registered>
     *      <registrationServer>true</registrationServer>
     *      <reverseInitialLoaded>false</reverseInitialLoaded>
     *      <syncUrl>http://machine-name:31415/sync/RootSugarDB-root </syncUrl>
     *    </node>
     *   }
     * <br>
     * Example json response is as follows:<br><br>
     * {"name":"server01","externalId":"server01","registrationServer":true,"syncUrl":"http://machine-name:31415/sync/RootSugarDB-root","batchToSendCount":0,"batchInErrorCount":0,"lastHeartbeat":1356013562000,"registered":true,"initialLoaded":true,"reverseInitialLoaded":false}
     * </pre>
     */
    @ApiOperation(value = "Obtain node information for the single engine")
    @RequestMapping(value = "engine/node", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final Node getNode() {
        ResponseEntity<Node> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/node", HttpMethod.GET, HTTPUtils.makeRequestEntity(), Node.class);

        return (Node)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Provides Node information for the specified engine
     */
    @ApiOperation(value = "Obtain node information for he specified engine")
    @RequestMapping(value = "engine/{engine}/node", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final R getNode(@PathVariable("engine") String engineName) {
        ResponseEntity<Node> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/node", HttpMethod.GET, HTTPUtils.makeRequestEntity(), Node.class);
        return new R<>(responseEntity.getBody());
    }

    /**
     * Provides a list of children that are registered with this engine.
     *
     * return {@link Node}<br>
     *
     * <pre>
     * Example xml reponse is as follows:<br><br>
     *   {@code
     *   <nodelist>
     *      <nodes>
     *         <batchInErrorCount>0</batchInErrorCount>
     *         <batchToSendCount>0</batchToSendCount>
     *         <externalId>client01</externalId>
     *         <initialLoaded>true</initialLoaded>
     *         <name>client01</name>
     *         <registered>true</registered>
     *         <registrationServer>false</registrationServer>
     *         <reverseInitialLoaded>false</reverseInitialLoaded>
     *         <syncUrl>http://machine-name:31418/sync/ClientSugarDB-client01</syncUrl>
     *      </nodes>
     *   </nodelist>
     *   }
     * <br>
     * Example json response is as follows:<br><br>
     * {"nodes":[{"name":"client01","externalId":"client01","registrationServer":false,"syncUrl":"http://gwilmer-laptop:31418/sync/ClientSugarDB-client01","batchToSendCount":0,"batchInErrorCount":0,"lastHeartbeat":null,"registered":true,"initialLoaded":true,"reverseInitialLoaded":false}]}
     * </pre>
     */
    @ApiOperation(value = "Obtain list of children for the single engine")
    @RequestMapping(value = "engine/children", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final NodeList getChildren() {
        ResponseEntity<NodeList> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/children", HttpMethod.GET, HTTPUtils.makeRequestEntity(), NodeList.class);
        return (NodeList)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Provides a list of children {@link Node} that are registered with this
     * engine.
     */
    @ApiOperation(value = "Obtain list of children for the specified engine")
    @RequestMapping(value = "engine/{engine}/children", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final NodeList getChildrenByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<NodeList> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/children", HttpMethod.GET, HTTPUtils.makeRequestEntity(), NodeList.class);
        return (NodeList)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Register the specified node for the single engine")
    @RequestMapping(value = "/engine/registernode", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final RegistrationInfo postRegisterNode(
            @RequestParam(value = "externalId") String externalId,
            @RequestParam(value = "nodeGroupId") String nodeGroupId,
            @RequestParam(value = "databaseType") String databaseType,
            @RequestParam(value = "databaseVersion") String databaseVersion,
            @RequestParam(value = "hostName") String hostName) {
        ResponseEntity<RegistrationInfo> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/registernode?externalId="+externalId+"&nodeGroupId="+nodeGroupId+"&databaseType="+databaseType+"&databaseVersion="+databaseVersion+"&hostName="+hostName+"", HttpMethod.POST, HTTPUtils.makeRequestEntity(), RegistrationInfo.class);
        return (RegistrationInfo)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }
//符合前端格式的节点添加
    @ApiOperation(value = "Register the specified node for the single engine")
    @RequestMapping(value = "/engine/registerNodeMap", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final R postRegisterNodeMap(@RequestBody HashMap<String,Object> hashMap) {
        ResponseEntity<RegistrationInfo> responseEntity = restTemplate.exchange(
                symmetricDSApiUrl + "/api/engine/registernode?externalId="+
                        hashMap.get("externalId")+"&nodeGroupId="+
//                        默认设定为client组
// hashMap.get("nodeGroupId")+"&databaseType="+
                        "client"+"&databaseType="+
                        hashMap.get("databaseType")+"&databaseVersion="+
                        hashMap.get("databaseVersion")+"&hostName="+
                        hashMap.get("hostName"), HttpMethod.POST, HTTPUtils.makeRequestEntity(),
                RegistrationInfo.class);
        return new R(responseEntity);
    }

    @ApiOperation(value = "Register the specified node for the specified engine")
    @RequestMapping(value = "/engine/{engine}/registernode", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final RegistrationInfo postRegisterNode(@PathVariable("engine") String engineName,
                                                   @RequestParam(value = "externalId") String externalId,
                                                   @RequestParam(value = "nodeGroupId") String nodeGroupId,
                                                   @RequestParam(value = "databaseType") String databaseType,
                                                   @RequestParam(value = "databaseVersion") String databaseVersion,
                                                   @RequestParam(value = "hostName") String hostName) {
        ResponseEntity<RegistrationInfo> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/registernode?externalId="+externalId+"&nodeGroupId="+nodeGroupId+"&databaseType="+databaseType+"&databaseVersion="+databaseVersion+"&hostName="+hostName, HttpMethod.POST, HTTPUtils.makeRequestEntity(), RegistrationInfo.class);
        return (RegistrationInfo)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Removes (unregisters and cleans up) a node for the single engine
     */
    @ApiOperation(value = "Remove specified node (unregister and clean up) for the single engine")
    @RequestMapping(value = "/engine/removenode", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postRemoveNode(@RequestParam(value = "nodeId") String nodeId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/removenode?nodeId=" + nodeId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("删除成功").build();
    }

    /**
     * Removes (unregisters and cleans up) a node for the single engine
     */
    @ApiOperation(value = "Remove specified node (unregister and clean up) for the specified engine")
    @RequestMapping(value = "/engine/{engine}/removenode", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postRemoveNodeByEngine(@RequestParam(value = "nodeId") String nodeId,
                                             @PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/" + engineName + "/removenode?nodeId=" + nodeId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * @Author liaomingxiang
     * @Description 注册节点，模拟文件上传
     * @Date 16:59 2019/6/5
     * @Param
     * @return
     */
    @ApiOperation(value = "安装节点")
    @RequestMapping(value = "/engine/confInstall", method = RequestMethod.POST)
    @ResponseBody
    public R installNode(@RequestParam(value = "externalId") String externalId,
                         @RequestParam(value = "nodeGroupId") String nodeGroupId,
                         @RequestParam(value = "databaseDriver") String databaseDriver,
                         @RequestParam(value = "databaseUrl") String databaseUrl,
                         @RequestParam(value = "dbPassword") String dbPassword,
                         @RequestParam(value = "dbUser") String dbUser){
        //准备工作：（没有则）添加group，并添加groupLink
        NodeGroup nodeGroup = groupMapper.selectByGroupId(nodeGroupId);
        if(nodeGroup == null){
//            添加该组和server组的组连接信息
//            sym_node_group group_link sym_node_group_link
            NodeGroup group = new NodeGroup();
            group.setNodeGroupId(nodeGroupId);
            group.setDescription("");
            groupMapper.insert(group);
            NodeGroupLink serverLink = new NodeGroupLink(Const.SERVER_GROUP,nodeGroupId,NodeGroupLinkAction.W);
            NodeGroupLink clientLink = new NodeGroupLink(nodeGroupId,Const.SERVER_GROUP, NodeGroupLinkAction.P);
            groupLinkMapper.insert(serverLink);
            groupLinkMapper.insert(clientLink);
//            添加router
            MRouter Srouter = routerService.createDefault(Const.SERVER_GROUP,nodeGroupId);
            Srouter.setRouterId(Const.SERVER_GROUP+" waits for pull from "+nodeGroupId);
            routerService.insert(Srouter);
            MRouter Crouter = routerService.createDefault(nodeGroupId,Const.SERVER_GROUP);
            Crouter.setRouterId(nodeGroupId+" pushes to "+Const.SERVER_GROUP);
            routerService.insert(Crouter);
        }
        //生成一个propetities文件，上传至symmetricDS接口
        try {
            String fileName = nodeGroupId+"-"+externalId+".properties";
            File propertyFile = new File(fileName);
            BufferedWriter  fw = new BufferedWriter(new FileWriter(propertyFile));
//            写入节点配置内容
            fw.write("engine.name="+nodeGroupId+"-"+externalId);
            fw.newLine();
            fw.write("db.driver="+databaseDriver);
            fw.newLine();
            fw.write("db.url="+databaseUrl);
            fw.newLine();
            fw.write("db.user="+dbUser);
            fw.newLine();
            fw.write("db.password="+dbPassword);
            fw.newLine();
            fw.write("registration.url="+symmetricRegistrationUrl);
            fw.newLine();
            fw.write("sync.url=");
            fw.newLine();
            fw.write("group.id="+nodeGroupId);
            fw.newLine();
            fw.write("external.id="+externalId);
            fw.newLine();
            fw.write("job.routing.period.time.ms=5000");
            fw.newLine();
            fw.write("rest.api.enable=true");
            fw.newLine();
            fw.write("job.push.period.time.ms=10000");
            fw.newLine();
            fw.write("job.pull.period.time.ms=10000");
            fw.newLine();
            fw.close();
//            模拟上传至symmetricDS安装节点接口
//            postInstall(new MockMultipartFile(fileName,new FileInputStream(propertyFile)));
            ResponseEntity<String> response = HTTPUtils.upload(restTemplate,propertyFile,symmetricDSApiUrl+"/api/engine/install");
            logger.info(response.getBody());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("节点添加成功").build();
    }

    /**
     * Starts the single engine on the node
     */
    @ApiOperation(value = "Start the single engine")
    @RequestMapping(value = "engine/start", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postStart() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/start", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return new R(responseEntity.getBody());
    }

    /**
     * Starts the specified engine on the node
     */
    @ApiOperation(value = "Start the specified engine")
    @RequestMapping(value = "engine/{engine}/start", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postStartByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/start", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Stops the single engine on the node
     */
    @ApiOperation(value = "Stop the single engine")
    @RequestMapping(value = "engine/stop", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postStop() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/stop", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return new R(responseEntity.getBody());
    }

    /**
     * Stops the specified engine on the node
     */
    @ApiOperation(value = "Stop the specified engine")
    @RequestMapping(value = "engine/{engine}/stop", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postStopByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/stop", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }


    /**
     * Reinitializes the given node (database) for the single engine on the node
     */
    @ApiOperation(value = "Reinitiailize SymmetricDS on the single engine")
    @RequestMapping(value = "engine/reinitialize", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postReinitialize() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/reinitialize", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Reinitializes the given node (database) for the specified engine on the
     * node
     *
     */
    @ApiOperation(value = "Reinitiailize SymmetricDS on the specified engine")
    @RequestMapping(value = "engine/{engine}/reinitialize", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postReinitializeByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/reinitialize", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Refreshes cache for the single engine on the node
     */
    @ApiOperation(value = "Refresh caches on the single engine")
    @RequestMapping(value = "engine/refreshcache", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postClearCaches() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/refreshcache", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Refreshes cache for the specified engine on the node node
     *
     */
    @ApiOperation(value = "Refresh caches on the specified engine")
    @RequestMapping(value = "engine/{engine}/refreshcache", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postClearCachesByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/refreshcache", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Requests an initial load from the server for the node id provided. The
     * initial load requst directs the server to queue up initial load data for
     * the client node. Data is obtained for the initial load by the client
     * calling the pull method.
     *
     * @param nodeId
     */
    @ApiOperation(value = "Request an initial load for the specified node for the single engine")
    @RequestMapping(value = "/engine/requestinitialload", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postRequestInitialLoad(@RequestParam(value = "nodeId") String nodeId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/requestinitialload?nodeId="+nodeId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Requests an initial load from the server for the node id provided. The
     * initial load requst directs the server to queue up initial load data for
     * the client node. Data is obtained for the initial load by the client
     * calling the pull method.
     *
     * @param nodeId
     */
    @ApiOperation(value = "Request an initial load for the specified node for the specified engine")
    @RequestMapping(value = "/engine/{engine}/requestinitialload", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postRequestInitialLoad(@PathVariable("engine") String engineName,
                                             @RequestParam(value = "nodeId") String nodeId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/requestinitialload?nodeId="+nodeId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Installs and starts a new node
     *
     * @param file
     *            A file stream that contains the node's properties.
     */
    @ApiOperation(value = "Load a configuration file to the single engine")
    @RequestMapping(value = "engine/install", method = RequestMethod.POST)
    @ResponseBody
    public final void postInstall(@RequestParam MultipartFile file) {
      try {
          MultiValueMap<String, Object> parts = new LinkedMultiValueMap<String, Object>();
          ByteArrayResource arrayResource = new ByteArrayResource(file.getBytes());
          parts.add("importFile", arrayResource);
          HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<MultiValueMap<String, Object>>(parts);
          ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/install", HttpMethod.POST, httpEntity, Object.class);
          HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
      }catch(Exception ex) {
          throw new RuntimeException(ex);
      }
    }

    /**
     * Uninstalls all SymmetricDS objects from the given node (database) for the
     * single engine on the node
     */
    @ApiOperation(value = "Uninstall SymmetricDS on the single engine")
    @RequestMapping(value = "engine/uninstall", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postUninstall() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/uninstall", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Uninstalls all SymmetricDS objects from the given node (database) for the
     * specified engine on the node
     *
     */
    @ApiOperation(value = "Uninstall SymmetricDS on the specified engine")
    @RequestMapping(value = "engine/{engine}/uninstall", method = RequestMethod.POST)
    @ResponseBody
    public final R postUninstallByEngine(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/uninstall", HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return R.builder().code(CommonConstants.SUCCESS)
                .msg("删除成功").build();
    }

}
