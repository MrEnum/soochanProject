package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InserStaffSkillDto {
    private int staffNo;
    private String staffName;
    private List<String> skillCode;

    public InserStaffSkillDto(String staffName, List<String> skillCode){
        this.staffName = staffName;
        this.skillCode = skillCode;
    }
    public InserStaffSkillDto(int staffNo, List<String> skillCode ){
        this.staffNo = staffNo;
        this.skillCode = skillCode;
    }
}
