package com.nedam.soochanProject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CodeSkill {
    private int staffSkillCode;
    private String staffNo;
    private String skillCode;

    public CodeSkill(String staffNo, String skillCode){
        this.staffNo = staffNo;
        this.skillCode = skillCode;
    }
}
