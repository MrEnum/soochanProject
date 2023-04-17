package com.nedam.soochanProject.mapper;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.*;
import org.springframework.http.converter.json.GsonBuilderUtils;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffMapper {
    //직원과 관련된 메서드----------------------------------
    //직원 리스트
    public List<StaffVo> getStaffList();
    //직원 등록
    void register(StaffVo staffVo);
    //직원 상세정보 가져오기
    StaffVo getDetail(int staffNo);
    //직원 검색리스트 가져오기
    List<Integer> getSearchIntegerList(SearchRequestDto searchRequestDto);//직원 스킬 외에 조건
    List<StaffVo> getSearchStaffList(SearchStaffSkillDto searchStaffSkillDto);//직원 스킬 조건
    List<StaffVo> getSearchIntegerStaffList(SearchRequestDto searchRequestDto);//직원 스킬 조건




    //직원 수정
    void updateStaff(UpdateRequestDto updateRequestDto);
    //모든 직원 가져오기
    List<StaffVo> getAllStaff();
    //직원 삭제
    void delete(int i);

    //직원 스킬과 관련된 메서드----------------------------------
    //직원 스킬 등록
    void registerStaffSkill(InserStaffSkillDto inserStaffSkillDto);
    //직원 스킬 목록 가져오기
    List<String> getStaffSkillList(int staffNo);
    //직원 스킬 지우기
    void deleteStaffSkills(int staffNo);

    //스킬과 관련된 메서드----------------------------------
    //스킬 목록 가져오기
    List<String> getSkillList();
    //스킬등록
    void registerSkill(ForSkillListDto newSkillList);
}
