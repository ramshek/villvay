package com.asanka.helloworld.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

@Slf4j
@Service
public class HelloWorldService {

    public String testResource(String path) {
        Resource resource =new FileSystemResource(path);
        String text = null;
        try {
            InputStream inputStream = resource.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            while (true) {
                text = reader.readLine();
                if (text != null)
                    break;
                reader.close();
            }

        } catch (IOException e) {
            log.info("Error reading resource "+e);
        }
        return text;
    }
}
