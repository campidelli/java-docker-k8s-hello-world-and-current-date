package com.github.campidelli.helloworld;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {
    
    @RequestMapping("/hello-world")
    public String index() {
        return "Hello World\n";
    }
}
