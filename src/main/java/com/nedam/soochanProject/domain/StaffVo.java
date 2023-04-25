package com.nedam.soochanProject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.sql.Date;
import java.sql.Timestamp;

@AllArgsConstructor
@Getter
@NoArgsConstructor
@ToString
public class StaffVo {
    private int staffNo;
    private String staffName;
    private String juminNo;
    private String gender;
    private String schoolCode;
    private String departmentCode;
    private String graduateDay;


    public StaffVo(String staffName, String juminNo, String  gender, String schoolCode, String departmentCode, String  graduateDay) {
        this.staffName = staffName;
        this.juminNo = juminNo;
        this.gender = gender;
        this.schoolCode = schoolCode;
        this.departmentCode = departmentCode;
        this.graduateDay = graduateDay;
    }

    public StaffVo(StaffVo staffVo) {
        this.staffName = staffVo.getStaffName();
        this.juminNo = staffVo.getJuminNo();
        this.schoolCode = staffVo.getSchoolCode();
        this.departmentCode = staffVo.getDepartmentCode();
        this.graduateDay = staffVo.getGraduateDay();
    }
}
