package com.etiir.mdm.util;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.io.File;

/**
 * Created by jsonhua on 2019/5/7.
 */
public class HTTPUtils {
    /**
     * 创建公共请求Entity
     * @return
     */
    public static HttpEntity<String> makeRequestEntity() {
        HttpHeaders header = new HttpHeaders();
        header.add("Accept", "application/json");
        HttpEntity<String> requestEntity = new HttpEntity<String>(null, header);
        return requestEntity;
    }

    /**
     * 创建rest接口返回值
     * @param responseEntity
     * @param expectHttpStatus
     * @return
     */
    public static Object makeResult(ResponseEntity responseEntity, HttpStatus expectHttpStatus) {
        if(responseEntity.getStatusCodeValue() == expectHttpStatus.value() ) {
            return responseEntity.getBody();
        } else {
            throw new HttpClientErrorException(responseEntity.getStatusCode(), responseEntity.getBody().toString());
        }
    }

    public static ResponseEntity upload(RestTemplate rest,File file,String uploadUrl) {
        FileSystemResource resource = new FileSystemResource(file);
        MultiValueMap<String, Object> param = new LinkedMultiValueMap<>();
        param.add("file", resource);
        HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<MultiValueMap<String, Object>>(param);
        return rest.exchange(uploadUrl, HttpMethod.POST, httpEntity, String.class);
    }
}
