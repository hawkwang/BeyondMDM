package com.etiir.mdm.controller;

import com.etiir.mdm.util.HTTPUtils;
import com.pig4cloud.pigx.common.core.util.R;
import io.swagger.annotations.ApiOperation;
import org.jumpmind.symmetric.job.IJob;
import org.jumpmind.symmetric.model.JobDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

/**
 * Created by jsonhua on 2019/5/16.
 */
@RestController
@RequestMapping("/api")
public class JobManageController extends BaseController {

    @Autowired
    @Qualifier(value = "remoteRestTemplate")
    RestTemplate restTemplate;

    @Value("${symmetricDS.api.url}")
    private String symmetricDSApiUrl;

    @ApiOperation(value = "Read jobs value")
    @RequestMapping(value = "engine/jobs", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public R getJobs() {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/jobs", HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return new R<>(responseEntity.getBody());
    }

    @ApiOperation(value = "Read jobs value for the specified engine")
    @RequestMapping(value = "engine/{engine}/jobs", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final List<IJob> getJobs(@PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/jobs", HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return (List<IJob>) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Read job value")
    @RequestMapping(value = "engine/job/{name}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final IJob getJob(@PathVariable("name") String name) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/job/" + name, HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return (IJob) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    @ApiOperation(value = "Read job value for the specified engine")
    @RequestMapping(value = "engine/{engine}/job/{name}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final IJob getJob(@PathVariable("engine") String engineName, @PathVariable("name") String name) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/job/" + name, HttpMethod.GET, HTTPUtils.makeRequestEntity(), Object.class);
        return (IJob) HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Removes (unregisters and cleans up) a node for the single engine
     */
    @ApiOperation(value = "Remove specified job (unregister and clean up) for the single engine")
    @RequestMapping(value = "/engine/removejob", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postRemoveJob(@RequestParam(value = "name") String name) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/removejob" + name, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return new R(responseEntity.getBody());
    }

    /**
     * Removes (unregisters and cleans up) a node for the single engine
     */
    @ApiOperation(value = "Remove specified job (unregister and clean up) for the specified engine")
    @RequestMapping(value = "/engine/{engine}/removejob", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postRemoveJobByEngine(@RequestParam(value = "name") String name,
                                            @PathVariable("engine") String engineName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/removejob" + name, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    @ApiOperation(value = "Save the specified job for the single engine")
    @RequestMapping(value = "/engine/savejob", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public R postSaveJob(
            @RequestParam(value = "jobName") String jobName,
            @RequestParam(value = "description") String description,
            @RequestParam(value = "jobType") String jobType,
            @RequestParam(value = "nodeGroupId") String nodeGroupId,
            @RequestParam(value = "automaticStartup") String automaticStartup,
            @RequestParam(value = "schedule") String schedule,
            @RequestParam(value = "jobExpression") String jobExpression) {
//        nodeGroupId默认为client
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/savejob?jobName=" + jobName +"&description="+description+"&jobType="+jobType+"&nodeGroupId="+"client"+"&automaticStartup="+automaticStartup+"&schedule="+schedule+"&jobExpression="+jobExpression, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        return new R(responseEntity.getBody());
    }

    @ApiOperation(value = "Save the specified job for the specified engine")
    @RequestMapping(value = "/engine/{engine}/savejob", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public final JobDefinition postSaveJob(@PathVariable("engine") String engineName,
                                           @RequestParam(value = "jobName") String jobName,
                                           @RequestParam(value = "description") String description,
                                           @RequestParam(value = "jobType") String jobType,
                                           @RequestParam(value = "nodeGroupId") String nodeGroupId,
                                           @RequestParam(value = "automaticStartup") String automaticStartup,
                                           @RequestParam(value = "schedule") String schedule,
                                           @RequestParam(value = "jobExpression") String jobExpression) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/savejob?jobName=" + jobName +"&description="+description+"&jobType="+jobType+"&nodeGroupId="+nodeGroupId+"&automaticStartup="+automaticStartup+"&schedule="+schedule+"&jobExpression="+jobExpression, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        return (JobDefinition)HTTPUtils.makeResult(responseEntity, HttpStatus.OK);
    }

    /**
     * Starts the single engine on the node
     */
    @ApiOperation(value = "Start the single job")
    @RequestMapping(value = "engine/startjob", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postStartJob(@RequestParam(value = "jobName") String jobName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/startjob?jobName=" + jobName, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return new R(responseEntity.getBody());
    }

    /**
     * Starts the specified engine on the node
     */
    @ApiOperation(value = "Start the specified job by engine")
    @RequestMapping(value = "engine/{engine}/startjob", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postStartJobByEngine(@PathVariable("engine") String engineName, @RequestParam(value = "jobName") String jobName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/startjob?jobName=" + jobName, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

    /**
     * Stops the single engine on the node
     */
    @ApiOperation(value = "Stop the single job")
    @RequestMapping(value = "engine/stopjob", method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public R postStopJob(@RequestParam(value = "jobName") String jobName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/stopjob?jobName=" + jobName, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
//        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
        return new R(responseEntity.getBody());
    }

    /**
     * Stops the specified engine on the node
     */
    @ApiOperation(value = "Stop the specified job by engine")
    @RequestMapping(value = "engine/{engine}/stopjob", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @ResponseBody
    public final void postStopJobByEngine(@PathVariable("engine") String engineName, @RequestParam(value = "jobName") String jobName) {
        ResponseEntity<Object> responseEntity = restTemplate.exchange(symmetricDSApiUrl + "/api/engine/"+engineName+"/stopjob?jobName=" + jobName, HttpMethod.POST, HTTPUtils.makeRequestEntity(), Object.class);
        HTTPUtils.makeResult(responseEntity, HttpStatus.NO_CONTENT);
    }

}
