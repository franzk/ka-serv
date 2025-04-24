package net.franzka.kaserv.apringback.domain.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
@Builder
public class SomethingDto {
    Date date;
    String message;
}
