package net.franzka.kaserv.ka_mailer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

@EnableMethodSecurity
@SpringBootApplication
public class KaMailerApplication {

	public static void main(String[] args) {
		SpringApplication.run(KaMailerApplication.class, args);
	}

}
