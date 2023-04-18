package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchRequestDto {
    private String staffName;       //like
    private String departmentCode;  //where
    private List<String> schoolCode;      //where
    private List<String> skillCode; //like in
    private String startGraduateDay;
    private String endGraduateDay;	//where
    private String skills;
    private String schoolCodes;

}
