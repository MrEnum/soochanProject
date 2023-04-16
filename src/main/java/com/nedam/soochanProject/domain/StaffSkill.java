package com.nedam.soochanProject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class StaffSkill {
    private int staffSkillCode;
    private String staffNo;
    private String skillCode;

    public StaffSkill(String staffNo, String skillCode){
        this.staffNo = staffNo;
        this.skillCode = skillCode;
    }
}
