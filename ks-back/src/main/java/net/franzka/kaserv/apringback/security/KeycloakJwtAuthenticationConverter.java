package net.franzka.kaserv.apringback.security;

import org.springframework.core.convert.converter.Converter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

public class KeycloakJwtAuthenticationConverter implements Converter<Jwt, JwtAuthenticationToken> {

    private final RealmRoleConverter realmRoleConverter;
    private final String principalClaimName = "preferred_username";
    private final String emailClaimName = "email";

    public KeycloakJwtAuthenticationConverter() {
        this.realmRoleConverter = new RealmRoleConverter();
    }

    @Override
    public JwtAuthenticationToken convert(Jwt jwt) {
        String username = jwt.getClaimAsString(this.principalClaimName);
        Collection<GrantedAuthority> authorities = this.realmRoleConverter.convert(jwt);

        // Include the email as an additional attribute
        Map<String, Object> claims = new java.util.HashMap<>(jwt.getClaims());
        Object email = claims.get(this.emailClaimName);
        if (email != null) {
            claims.put("email", email);
        }

        return new JwtAuthenticationToken(jwt, authorities, username);
    }

    private static class RealmRoleConverter implements Converter<Jwt, Collection<GrantedAuthority>> {
        @Override
        public Collection<GrantedAuthority> convert(Jwt jwt) {
            return extractRoles(jwt).stream()
                    .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                    .collect(Collectors.toList());
        }

        public List<String> extractRoles(Jwt jwt) {
            Map<String, Object> realmAccess = jwt.getClaim("realm_access");
            if (realmAccess == null || !realmAccess.containsKey("roles")) {
                return List.of();
            }
            return (List<String>) realmAccess.get("roles");
        }
    }
}