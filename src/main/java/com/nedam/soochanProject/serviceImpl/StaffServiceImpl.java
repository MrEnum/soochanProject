package com.nedam.soochanProject.serviceImpl;


import com.nedam.soochanProject.domain.CodeSkill;
import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.*;
import com.nedam.soochanProject.dto.request.SearchRequestDto;
import com.nedam.soochanProject.dto.request.StaffRequestDto;
import com.nedam.soochanProject.dto.request.UpdateRequestDto;
import com.nedam.soochanProject.dto.response.GetDetailResponseDto;
import com.nedam.soochanProject.mapper.StaffMapper;
import com.nedam.soochanProject.service.StaffService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

@Service("StaffServiceImpl")
@Transactional
@AllArgsConstructor
public class StaffServiceImpl implements StaffService {
    public static List<String> skillList = new ArrayList<>();//
    public static List<String> essentialSkills = new ArrayList<>();

    @Autowired
    private StaffMapper staffMapper;


    //등록
    @Override
    public void register(StaffRequestDto staffRequestDto) throws ParseException {
        List<String> skillLists = new ArrayList<>();
        String staffName = staffRequestDto.getStaffName();
        String juminNo = staffRequestDto.getJuminNo();
        String gender = juminNo.charAt(6) == '1' || juminNo.charAt(6) == '3' ? "M" : "F";
        System.out.println("jummino 6번쨰 글자 : " + juminNo.charAt(6));
        // ex.Mon Jan 01 2001 00:00:00 GMT+0900 (한국 표준시)
        String[] skillToken = staffRequestDto.getSkillCode().split(",");
        //for문보다 더 빠름. 불변리스트 어쩌고
        skillLists.addAll(List.of(skillToken));
        StaffVo staffVo = new StaffVo(staffRequestDto.getStaffName(), juminNo, gender, staffRequestDto.getSchoolCode(), staffRequestDto.getDepartmentCode(), staffRequestDto.getGraduateDay());
        staffMapper.register(staffVo);
        checkSkill(skillLists);
        staffMapper.registerStaffSkill(new InserStaffSkillDto(staffName, skillLists));

        System.out.println("success register");
    }

    //수정
    @Override
    public void update(StaffRequestDto staffRequestDto) throws ParseException {
        List<String> skillLists = new ArrayList<>();
        int staffNo = staffRequestDto.getStaffNo();
        UpdateRequestDto updateRequestDto = new UpdateRequestDto(staffRequestDto.getStaffNo(), staffRequestDto.getStaffName(), staffRequestDto.getJuminNo(), staffRequestDto.getSchoolCode(), staffRequestDto.getDepartmentCode(), staffRequestDto.getGraduateDay());
        //문자열 리스트화
        String[] skillToken = staffRequestDto.getSkillCode().split(",");
        skillLists.addAll(List.of(skillToken));
        checkSkill(skillLists);
        //업데이트 (지우고 -> 다시 저장)
        staffMapper.updateStaff(updateRequestDto);
        staffMapper.deleteStaffSkills(staffNo);
        staffMapper.registerStaffSkill(new InserStaffSkillDto(staffNo, staffRequestDto.getStaffName(), skillLists));
        System.out.println("success update");
    }


    //상세조회
    @Override
    public GetDetailResponseDto getDetail(int staffNo) {
        addEssentialSkills();
        List<String> newStaffSkill = staffMapper.getStaffSkillList(staffNo);//전부 가지고 있는 상태에서
        List<String> staffSkill = new ArrayList<>();
        for (String essentialSkill : essentialSkills) {
            for (int j = 0; j < newStaffSkill.size(); j++) {
                if (essentialSkill.equals(newStaffSkill.get(j))) {
                    System.out.println("돌아가긴해요 essetionSkills : " + essentialSkill);
                    staffSkill.add(essentialSkill);
                    newStaffSkill.remove(newStaffSkill.get(j));

                }
            }
        }
        GetDetailResponseDto dto = new GetDetailResponseDto(staffMapper.getDetail(staffNo), staffSkill, newStaffSkill);
        return dto;//dto
    }

    //검색
    @Override
    public List<StaffVo> searchList(String staffName, String gender, String departmentCode, List<String> schoolCode, List<String> skillCode, String startGraduateDay, String endGraduateDay, String andOr) {
        if (skillCode != null) {
            checkSkill(skillCode);
        }
        List<String> a = (schoolCode.get(0).equals("")) ? null : schoolCode;
        List<String> b = (skillCode.isEmpty() || skillCode.get(0).equals("")) ? null : skillCode;
        String c = (departmentCode.trim().equals("")) ? null : departmentCode;
        String d = (staffName.trim().equals("")) ? null : staffName;
        String e = (gender.equals("")) ? null : gender;

        if (b == null && andOr.equals("and")) {
            System.out.println("스킬 코드가  null이고 and 조건일 때 : " + b);
            List<StaffVo> staffList = staffMapper.getSearchIntegerStaffList(new SearchRequestDto(d, e, c, a, null, startGraduateDay, endGraduateDay, null, null));
            return staffList;
        } else {
            List<Integer> skillCodes = stringToIntSkill(skillCode);
            //검색 조건으로 staffName List 조회
            List<Integer> staffNoList = staffMapper.getSearchIntegerList(new SearchRequestDto(d, e, c, a, null, startGraduateDay, endGraduateDay, null, null));
            List<StaffVo> staffList;
            System.out.println("스킬 코드가  null이 아니고 and 조건일 때 : " + b);
            System.out.println("staffNoList : " + staffNoList.toString());
            if (!staffNoList.isEmpty()) {
                if (andOr.equals("and")) {
                    //And
                    staffList = staffMapper.getSearchStaffListAnd(new SearchStaffSkillDto(staffNoList, skillCodes));
                } else {
                    System.out.println("스킬 코드가  null이 아니고 or 조건일 때 : " + b);
//                Or
                    List<Integer> essenList = new ArrayList<>();
                    List<Integer> skills = new ArrayList<>();
                    skills.addAll(skillCodes);
                    //필수 스킬과 추가 스킬을 나누는 작업
                    for (int i = skillCodes.size() - 1; i > -1; i--) {
                        for (int j = 5; j > 0; j--) {
                            if (!skillCodes.isEmpty()) {
                                if (skillCodes.get(i) == j) {
                                    essenList.add(j);
                                    skills.remove(i);

                                }
                            }
                        }
                    }
                    staffList = staffMapper.getSearchStaffListOr(new OrSearchDto(staffNoList, essenList, skills));
                }
            } else {
                staffList = null;
            }
            return staffList;
        }
    }

    //삭제
    @Override
    @Transactional
    public void delete(int i) {
        staffMapper.delete(i);
        staffMapper.deleteStaffSkills(i);
    }
    //문자열로 된 스킬을 skill_no로 바꿔주는 메서드
    private List<Integer> stringToIntSkill(List<String> skillCode) {
        List<Integer> skillCodes = new ArrayList<>();
        List<CodeSkill> codeSkills = staffMapper.getSkillBoth();//데이터베이스에서 가져온 스킬
        for (int i = 0; i < codeSkills.size(); i++) {
            for (int j = 0; j < skillCode.size(); j++) {
                if (codeSkills.get(i).getSkillName().equals(skillCode.get(j))) {
                    skillCodes.add(codeSkills.get(i).getSkillCode());
                }
            }
        }
        System.out.println("skillCodes : " + skillCodes.toString());
        return skillCodes;
    }

    //기존 스킬 외의 기술 체크 후 신규 저장
    public void checkSkill(List<String> skillCode) {
        addEssentialSkills();
        if (skillList.isEmpty()) {
            skillList.addAll(staffMapper.getSkillList());
        }
        List<String> newSkillCode = new ArrayList<>();
        newSkillCode.addAll(skillCode);
        //다지우고 남아 있는 코드가 있으면 추가해라
        for (int i = 0; i < skillList.size(); i++) {
            for (int j = 0; j < newSkillCode.size(); j++) {
                if (skillList.get(i).equals(newSkillCode.get(j))) {
                    System.out.println("2skillCode : " + newSkillCode);
                    newSkillCode.remove(j);
                }
            }
        }
        List<String> newSkillCodes = new ArrayList<>();
        try {
            if (!newSkillCode.isEmpty()) {
                //신규 스킬 등록
                skillList.addAll(newSkillCode);
                newSkillCodes.addAll(newSkillCode);
                staffMapper.registerSkill(new ForSkillListDto(newSkillCodes));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //필수스킬을 static array에 저장시켜주는 메서드드
   public void addEssentialSkills() {
        if (essentialSkills.isEmpty()) {
            essentialSkills.add("JAVA");
            essentialSkills.add("JSP");
            essentialSkills.add("ASP");
            essentialSkills.add("PHP");
            essentialSkills.add("DELPHI");
        }
    }


}
