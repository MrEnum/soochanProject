package com.nedam.soochanProject.dto;

import com.nedam.soochanProject.domain.StaffVo;
import lombok.Data;

import java.util.List;

@Data
public class GetDetailResponseDto {
    private int staffNo;
    private String staffName;
    private String juminNo;
    private String schoolCode;
    private String departmentCode;
    private String graduateDay;
    private List<String> skillCode;

    public GetDetailResponseDto(StaffVo staffVo, List<String> skillCode){
        this.staffName = staffVo.getStaffName();
        this.juminNo = staffVo.getJuminNo();
        this.schoolCode = staffVo.getSchoolCode();
        this.departmentCode = staffVo.getDepartmentCode();
        this.graduateDay = String.valueOf(staffVo.getGraduateDay());
        this.skillCode = skillCode;
    }


}