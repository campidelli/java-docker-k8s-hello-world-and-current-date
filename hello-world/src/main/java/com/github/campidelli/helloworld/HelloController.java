package com.github.campidelli.helloworld;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @Value("${your.name}")
    private String name;

    @Value("${your.surname}")
    private String surname;

    @Autowired
    private HelloClient helloClient;
    
    @RequestMapping("/hello-world")
    public String index() {
        Date today = helloClient.getCurrentDate();
        return String.format("Hello %s, %s. Today is %tD", surname, name, today);
    }
}
