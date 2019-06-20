package com.etiir.mdm.controller;

import com.etiir.mdm.util.HTTPUtils;
import com.pig4cloud.pigx.common.core.util.R;
import io.swagger.annotations.ApiOperation;
import org.jumpmind.symmetric.io.data.transform.TransformColumn;
import org.jumpmind.symmetric.service.impl.TransformService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

/**
 * Created by jsonhua on 2019/5/16.
 */
@RestController
@RequestMapping("/api")
public class TransformManageController extends BaseController {

    @Autowired
    @Qualifier(value = "remoteRestTemplate")
    RestTemplate restTemplate;

    @Value("${symmetricDS.api.url}")
    private String symmetricDSApiUrl;


    @ApiOperation(value = "Read transforms value")
    @RequestMapping(value = "engine/transform/{transformId}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final TransformService.TransformTableNodeGroupLink getTransform(@PathVariable("transformId") String transformId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/transform/" + transformId, HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return (TransformService.TransformTableNodeGroupLink) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Read transforms value for the specified engine")
    @RequestMapping(value = "engine/{engine}/transform/{transformId}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final TransformService.TransformTableNodeGroupLink getTransform(@PathVariable("engine") String engineName, @PathVariable("transformId") String transformId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/transform/" + transformId, HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return (TransformService.TransformTableNodeGroupLink) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Read transforms value")
    @RequestMapping(value = "engine/transforms", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public R getTransforms() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/transforms", HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
//        return (List<TransformService.TransformTableNodeGroupLink>) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
        return new R<>(responseEntity.getBody());
    }

    /**
     * Delete a transform for the single engine
     */
    @ApiOperation(value = "Delete a transform for the single engine")
    @RequestMapping(value = "/engine/deletetransform", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postDeleteTransform(@RequestParam(value = "transformId") String transformId) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/deletetransform?transformId=" + transformId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Delete specified transform for the specified engine
     */
    @ApiOperation(value = "Delete specified transform for the specified engine")
    @RequestMapping(value = "/engine/{engine}/deletetransform", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postDeleteTransformByEngine(@RequestParam(value = "transformId") String transformId,
                                                  @PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/deletetransform?transformId=" + transformId, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    @ApiOperation(value = "Save the specified Transform for the single engine")
    @RequestMapping(value = "/engine/savetransform", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final TransformService.TransformTableNodeGroupLink postSaveTransform(
            @RequestParam(value = "transformId") String transformId,
            @RequestParam(value = "sourceNodeGroupId") String sourceNodeGroupId,
            @RequestParam(value = "targetNodeGroupId") String targetNodeGroupId,
            @RequestParam(value = "transformPoint") String transformPoint,
            @RequestParam(value = "columnPolicy") String columnPolicy,
            @RequestParam(value = "sourceCatalogName") String sourceCatalogName,
            @RequestParam(value = "sourceSchemaName") String sourceSchemaName,
            @RequestParam(value = "sourceTableName") String sourceTableName,
            @RequestParam(value = "targetCatalogName") String targetCatalogName,
            @RequestParam(value = "targetSchemaName") String targetSchemaName,
            @RequestParam(value = "targetTableName") String targetTableName,
            @RequestParam(value = "saveTransformColumns") String saveTransformColumns,
            @RequestBody List<TransformColumn> transformColumns) {
        HttpHeaders header = new HttpHeaders();
        header.set("Content-Type", "application/json");
        HttpEntity<List<TransformColumn>> requestEntity = new HttpEntity<List<TransformColumn>>(transformColumns, header);
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/savetransform?transformId=" + transformId +"&sourceNodeGroupId="+sourceNodeGroupId+"&targetNodeGroupId="+targetNodeGroupId+"&transformPoint="+transformPoint+"&columnPolicy="+columnPolicy+"&sourceCatalogName="+sourceCatalogName+"&sourceSchemaName="+sourceSchemaName+"&sourceTableName="+sourceTableName+"&targetCatalogName="+targetCatalogName+"&targetSchemaName="+targetSchemaName+"&targetTableName="+targetTableName+"&saveTransformColumns="+saveTransformColumns, HttpMethod.POST, requestEntity, Object.class);
        return (TransformService.TransformTableNodeGroupLink)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Save the specified Transform for the specified engine")
    @RequestMapping(value = "/engine/{engine}/savetransform", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final TransformService.TransformTableNodeGroupLink postSaveTransform(@PathVariable("engine") String engineName,
                                                               @RequestParam(value = "transformId") String transformId,
                                                               @RequestParam(value = "sourceNodeGroupId") String sourceNodeGroupId,
                                                               @RequestParam(value = "targetNodeGroupId") String targetNodeGroupId,
                                                               @RequestParam(value = "transformPoint") String transformPoint,
                                                               @RequestParam(value = "columnPolicy") String columnPolicy,
                                                               @RequestParam(value = "sourceCatalogName") String sourceCatalogName,
                                                               @RequestParam(value = "sourceSchemaName") String sourceSchemaName,
                                                               @RequestParam(value = "sourceTableName") String sourceTableName,
                                                               @RequestParam(value = "targetCatalogName") String targetCatalogName,
                                                               @RequestParam(value = "targetSchemaName") String targetSchemaName,
                                                               @RequestParam(value = "targetTableName") String targetTableName,
                                                               @RequestParam(value = "saveTransformColumns") String saveTransformColumns,
                                                               @RequestBody List<TransformColumn> transformColumns) {
        HttpHeaders header = new HttpHeaders();
        header.add("Accept", "application/json");
        HttpEntity<List<TransformColumn>> requestEntity = new HttpEntity<List<TransformColumn>>(transformColumns, header);
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/savetransform?transformId=" + transformId +"&sourceNodeGroupId="+sourceNodeGroupId+"&targetNodeGroupId="+targetNodeGroupId+"&transformPoint="+transformPoint+"&columnPolicy="+columnPolicy+"&sourceCatalogName="+sourceCatalogName+"&sourceSchemaName="+sourceSchemaName+"&sourceTableName="+sourceTableName+"&targetCatalogName="+targetCatalogName+"&targetSchemaName="+targetSchemaName+"&targetTableName="+targetTableName+"&saveTransformColumns="+saveTransformColumns, HttpMethod.POST, requestEntity, Object.class);
        return (TransformService.TransformTableNodeGroupLink)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

}
