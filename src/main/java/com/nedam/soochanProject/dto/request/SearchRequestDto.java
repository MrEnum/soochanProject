package com.nedam.soochanProject.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchRequestDto {
    private String staffName;       //like
    private String gender;
    private String departmentCode;  //where
    private List<String> schoolCode;      //where
    private List<String> skillCode; //like in
    private String startGraduateDay;
    private String endGraduateDay;	//where
    private String skills;
    private String schoolCodes;
    private String andOr;


    public SearchRequestDto(String staffName,String gender, String departmentCode, List<String> schoolCode, List<String> skillCode, String startGraduateDay, String endGraduateDay,String skills, String schoolCodes){
        this.staffName = staffName;
        this.gender = gender;
        this.departmentCode = departmentCode;
        this.schoolCode = schoolCode;
        this.skillCode = skillCode;
        this.startGraduateDay = startGraduateDay;
        this.endGraduateDay = endGraduateDay;
        this.skills = skills;
        this.schoolCodes = schoolCodes;

    }
}
