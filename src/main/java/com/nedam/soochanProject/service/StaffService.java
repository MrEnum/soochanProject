package com.nedam.soochanProject.service;


import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.response.GetDetailResponseDto;
import com.nedam.soochanProject.dto.request.StaffRequestDto;

import java.text.ParseException;
import java.util.List;

public interface StaffService {
    //직원 등록
    void register(StaffRequestDto staffRequestDto) throws ParseException;

    //상세 조회
    GetDetailResponseDto getDetail(int staffNo);

    //직원 수정
    void update(StaffRequestDto staffRequestDto) throws ParseException;

    //삭제
    void delete(int i);

    //검색
    List<StaffVo> searchList(String staffName, String gender, String departmentCode, List<String> schoolCode, List<String> skillCode, String startGraduateDay,String endGraduateDay, String ansOr);


}
