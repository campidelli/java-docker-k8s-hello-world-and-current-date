package com.github.campidelli.helloworld;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @Autowired
    private HelloClient helloClient;
    
    @RequestMapping("/hello-world")
    public String index() {
        Date today = helloClient.getCurrentDate();
        return String.format("Hello World, today is %tD", today);
    }
}
