package net.franzka.kaserv.ka_mailer.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.franzka.kaserv.ka_mailer.dto.MailRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class MailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String defaultFromAddress;

    public void sendMail(MailRequest request) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom(defaultFromAddress);
        helper.setTo(request.getTo());
        helper.setSubject(request.getSubject());

        if (request.getHtml() != null) {
            helper.setText(request.getHtml(), true); // true = HTML
        } else {
            helper.setText(request.getText(), false);
        }

        log.info("Sending mail from {} to {} with subject {}", defaultFromAddress, request.getTo(), request.getSubject());
        mailSender.send(message);
    }

}
