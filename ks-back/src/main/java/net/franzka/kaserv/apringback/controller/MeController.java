package net.franzka.kaserv.apringback.controller;

import lombok.extern.slf4j.Slf4j;
import net.franzka.kaserv.apringback.domain.dto.MeDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class MeController {

    @GetMapping("/me")
    public ResponseEntity<MeDto> me() {
        MeDto result = new MeDto();
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof JwtAuthenticationToken) {
            Jwt jwt = (Jwt) authentication.getPrincipal();
            result.setName(jwt.getClaimAsString("preferred_username"));
            result.setEmail((String) jwt.getClaims().get("email"));
            return new ResponseEntity<>(result, HttpStatus.OK);
        }
        return new ResponseEntity<>(result, HttpStatus.UNAUTHORIZED);
    }

}
