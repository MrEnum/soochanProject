package com.nedam.soochanProject.service;


import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.GetDetailResponseDto;
import com.nedam.soochanProject.dto.StaffRequestDto;

import java.text.ParseException;
import java.util.List;

public interface StaffService {
    List<StaffVo> getStaffList();


    void update(StaffRequestDto staffRequestDto) throws ParseException;



    List<StaffVo> searchList(String staffName, String departmentCode, List<String> schoolCode, List<String> skillCode, String startGraduateDay,String endGraduateDay, String ansOr);

    void delete(int i);

    void register(StaffRequestDto staffRequestDto) throws ParseException;

    GetDetailResponseDto getDetail(int staffNo);
}
