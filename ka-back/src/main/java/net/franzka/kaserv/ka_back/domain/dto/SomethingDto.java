package net.franzka.kaserv.ka_back.domain.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
@Builder
public class SomethingDto {
    Date date;
    String message;
}
