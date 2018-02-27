package com.github.campidelli.helloworld;

import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Component
public class HelloClient {

    @Value("${current-date.endpoint}")
    private String endpoint;

    private RestTemplate restTemplate = new RestTemplate();

    public Date getCurrentDate() {
        return restTemplate.getForObject(endpoint, Date.class);
    }
}
