package com.github.campidelli.helloworld;

import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Component
public class HelloClient {

    private RestTemplate restTemplate = new RestTemplate();

    public Date getCurrentDate() {
        String endpoint = "http://current-date-service/current-date";
        return restTemplate.getForObject(endpoint, Date.class);
    }
}
