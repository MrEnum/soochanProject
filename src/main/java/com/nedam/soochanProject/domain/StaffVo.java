package com.nedam.soochanProject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Getter
@NoArgsConstructor
public class StaffVo {
    int staffNo;
    String staffName;
    String juminNo;
    String schoolCode;
    String departmentCode;
    String  graduateDay;

    public StaffVo(String staffName, String juminNo, String  schoolCode, String  departmentCode, String  graduateDay){
        this.staffName = staffName;
        this.juminNo = juminNo;
        this.schoolCode = schoolCode;
        this.departmentCode = departmentCode;
        this.graduateDay = graduateDay;
    }
}
