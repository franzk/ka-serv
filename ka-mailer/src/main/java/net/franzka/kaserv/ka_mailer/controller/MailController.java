package net.franzka.kaserv.ka_mailer.controller;

import jakarta.mail.MessagingException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import net.franzka.kaserv.ka_mailer.dto.MailRequest;
import net.franzka.kaserv.ka_mailer.service.MailService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/mail")
@RequiredArgsConstructor
public class MailController {

    private final MailService mailService;

    @PostMapping
    @PreAuthorize("hasAuthority('ROLE_mailer:send')")
    public ResponseEntity<String> sendMail(@RequestBody @Valid MailRequest mailRequest) throws MessagingException {
        mailService.sendMail(mailRequest);
        return ResponseEntity.ok("Mail sent");
    }
}
