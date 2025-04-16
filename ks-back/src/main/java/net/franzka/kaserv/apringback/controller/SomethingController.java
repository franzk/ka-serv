package net.franzka.kaserv.apringback.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SomethingController {

    @GetMapping("/something")
    @PreAuthorize("hasRole('user')")
    public String something() {
        return "something";
    }

}
