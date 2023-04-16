package com.nedam.soochanProject.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeSkill {
    private int skillCode;
    private String skillName;

    CodeSkill(String skillName){
        this.skillName = skillName;
    }
}
