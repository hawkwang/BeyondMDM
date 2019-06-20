package com.etiir.mdm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.HttpClientErrorException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.annotation.Annotation;

/**
 * @author 廖明祥
 * @packageName com.etiir.mdm.common
 * @description
 * @data 2019/4/9 15:23
 */
public class BaseController {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected HttpServletRequest request;

    protected HttpServletResponse response;

    protected HttpSession session;

    @ModelAttribute
    public void setReqAndRes(HttpServletRequest request, HttpServletResponse response){
        this.request = request;
        this.response = response;
        this.session = request.getSession();
    }

    /**
     *  The presence of this handler makes sure we return HTTP 406 when the rest API is disabled or 500 for general errors.
     * @param ex
     * @return
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<String> handleException(Exception ex) {
        logger.error(ex.getMessage(), ex);
        int httpErrorCode = 500;
        Annotation annotation = ex.getClass().getAnnotation(ResponseStatus.class);
        if (annotation != null) {
            httpErrorCode = ((ResponseStatus) annotation).value().value();
        }
        if(ex instanceof HttpClientErrorException) {
            httpErrorCode = ((HttpClientErrorException) ex).getStatusCode().value();
        }

        HttpHeaders headers = new HttpHeaders();
        if (httpErrorCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
            logger.warn("Internal server error during rest service call.", ex);
        } else {
            logger.debug("Exception during rest services http=" + httpErrorCode, ex);
        }
        return new ResponseEntity<String>("SymmetricDS API Invocation failed. " + ex.getMessage(), headers, HttpStatus.valueOf(httpErrorCode));
    }

}
