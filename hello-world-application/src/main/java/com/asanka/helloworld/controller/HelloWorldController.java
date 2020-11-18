package com.asanka.helloworld.controller;

import com.asanka.helloworld.service.HelloWorldService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class HelloWorldController {


    @Autowired
    HelloWorldService helloWorldService;

    @RequestMapping(method = RequestMethod.GET,value = "/")
    public String hello(@Value("${spring.hello.path}")String path) {
        log.info(" Start hello controller ");
        String name =helloWorldService.testResource(path);
        if(name!=null){
            return "hello "+name;
        }
        return "hello world!";
    }
}
