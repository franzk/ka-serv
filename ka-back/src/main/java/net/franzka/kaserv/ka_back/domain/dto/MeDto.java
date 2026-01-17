package net.franzka.kaserv.ka_back.domain.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MeDto {
    String name;
    String email;
}
