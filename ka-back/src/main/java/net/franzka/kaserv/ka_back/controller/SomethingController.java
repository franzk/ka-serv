package net.franzka.kaserv.ka_back.controller;

import lombok.extern.slf4j.Slf4j;
import net.franzka.kaserv.ka_back.domain.dto.SomethingDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@Slf4j
public class SomethingController {

    @GetMapping("/something")
    @PreAuthorize("hasRole('user')")
    public ResponseEntity<SomethingDto> something() {
        SomethingDto somethingDto = SomethingDto.builder()
                .date(new Date())
                .message("Hello from backend")
                .build();
        log.info("something : {}", somethingDto);
        return new ResponseEntity<>(somethingDto, HttpStatus.OK);
    }

}
