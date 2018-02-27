package com.github.campidelli.currentdate;

import java.util.Date;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class CurrentDateController {
    
    @RequestMapping("/current-date")
    public Date index() {
        return new Date();
    }
}
