package com.nedam.soochanProject.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StaffRequestDto {
    private int staffNo;
    private String staffName;
    private String juminNo;
    private String departmentCode;
    private String schoolCode;
    private String graduateDay;
    private String skillCode;
    private String newSkills;

    public StaffRequestDto(String staffName, String juminNo, String departmentCode, String schoolCode, String graduateDay, String skillCode){
        this.staffName = staffName;
        this.juminNo = juminNo;
        this.departmentCode = departmentCode;
        this.schoolCode = schoolCode;
        this.graduateDay = graduateDay;
        this.skillCode = skillCode;
    }
}
