package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

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
