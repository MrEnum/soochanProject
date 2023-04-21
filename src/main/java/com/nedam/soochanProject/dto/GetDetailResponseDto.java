package com.nedam.soochanProject.dto;

import com.nedam.soochanProject.domain.StaffVo;
import lombok.Data;

import java.util.List;

import static com.nedam.soochanProject.serviceImpl.StaffServiceImpl.skillList;

@Data
public class GetDetailResponseDto {
    private int staffNo;
    private String staffName;
    private String juminNo;
    private String schoolCode;
    private String departmentCode;
    private String graduateDay;
    private List<String> skillCode;
    private List<String> newSkillCodes;

    public GetDetailResponseDto(StaffVo staffVo, List<String> skillCode, List<String> newSkillCodes){
        this.staffName = staffVo.getStaffName();
        this.juminNo = staffVo.getJuminNo();
        this.schoolCode = staffVo.getSchoolCode();
        this.departmentCode = staffVo.getDepartmentCode();
        this.graduateDay = String.valueOf(staffVo.getGraduateDay());
        this.skillCode = skillCode;
        this.newSkillCodes = newSkillCodes;
    }


}