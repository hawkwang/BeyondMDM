package com.etiir.mdm.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

/**
 * Created by jsonhua on 2019/5/8.
 */
@Configuration
public class RestTemplateConfig {

    @Bean(name="remoteRestTemplate")
    public RestTemplate RestTemplate(ClientHttpRequestFactory factory) {
        return new RestTemplate(factory);
    }

    @Bean
    public ClientHttpRequestFactory simpleClientHttpRequestFactory() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setReadTimeout(15000);//单位为ms
        factory.setConnectTimeout(15000);//单位为ms
        return factory;
    }
}
