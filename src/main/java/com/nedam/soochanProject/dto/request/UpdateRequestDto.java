package com.nedam.soochanProject.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
public class UpdateRequestDto {
    int staffNo;
    String staffName;
    String juminNo;
    String schoolCode;
    String departmentCode;
    String  graduateDay;
}
