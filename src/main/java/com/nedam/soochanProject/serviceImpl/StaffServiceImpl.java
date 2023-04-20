package com.nedam.soochanProject.serviceImpl;


import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.*;
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
    public static List<String> skillList = new ArrayList<>();

    @Autowired
    private StaffMapper staffMapper;

    @Override
    public List<StaffVo> getStaffList() {
        System.out.println("작동 됩니까?7");
        return staffMapper.getStaffList();
    }

    //등록
    @Override
    public void register(StaffRequestDto staffRequestDto) throws ParseException {
        List<String> skillLists = new ArrayList<>();
        System.out.println("service staff:::" + staffRequestDto.toString());
        String staffName = staffRequestDto.getStaffName();

        // ex.Mon Jan 01 2001 00:00:00 GMT+0900 (한국 표준시)
        String[] skillToken = staffRequestDto.getSkillCode().split(",");
        //for문보다 더 빠름. 불변리스트 어쩌고
        skillLists.addAll(List.of(skillToken));
        System.out.println("graduateday : " + staffRequestDto.getGraduateDay());
        StaffVo staffVo = new StaffVo(staffRequestDto.getStaffName(), staffRequestDto.getJuminNo(), staffRequestDto.getSchoolCode(), staffRequestDto.getDepartmentCode(), staffRequestDto.getGraduateDay());
        staffMapper.register(staffVo);
        checkSkill(skillLists);
        staffMapper.registerStaffSkill(new InserStaffSkillDto(staffName, skillLists));

        System.out.println("success register");
    }

    //수정
    @Override
    public void update(StaffRequestDto staffRequestDto) throws ParseException {
        System.out.println("타집니다. 서비스 ");
        List<String> skillLists = new ArrayList<>();
        int staffNo = staffRequestDto.getStaffNo();
        UpdateRequestDto updateRequestDto = new UpdateRequestDto(staffRequestDto.getStaffNo(), staffRequestDto.getStaffName(), staffRequestDto.getJuminNo(), staffRequestDto.getSchoolCode(), staffRequestDto.getDepartmentCode(), staffRequestDto.getGraduateDay());
        System.out.println("타집니다. 믄자열 ");
        System.out.println("graduateday str : " + staffRequestDto.getGraduateDay());
        //문자열 리스트화
        String[] skillToken = staffRequestDto.getSkillCode().split(",");
        skillLists.addAll(List.of(skillToken));
        //업데이트 (지우고 -> 다시 저장)
        staffMapper.updateStaff(updateRequestDto);
        staffMapper.deleteStaffSkills(staffNo);
        staffMapper.registerStaffSkill(new InserStaffSkillDto(staffNo, staffRequestDto.getStaffName(), skillLists));
        System.out.println("success update");
    }

    //상세조회
    @Override
    public GetDetailResponseDto getDetail(int staffNo) {
        GetDetailResponseDto dto = new GetDetailResponseDto(staffMapper.getDetail(staffNo), staffMapper.getStaffSkillList(staffNo));
        return dto;//dto
    }

    //검색
    @Override
    public List<StaffVo> searchList(String staffName, String departmentCode, List<String> schoolCode, List<String> skillCode, String startGraduateDay, String endGraduateDay, String andOr) {
        if (skillCode == null) {
            checkSkill(skillCode);
        }
        List<String> a = (schoolCode.get(0).equals("")) ? null : schoolCode;
        List<String> b = (skillCode.get(0).equals("")) ? null : skillCode;
        String c = (departmentCode.trim().equals("")) ? null : departmentCode;
        String d = (staffName.trim().equals("")) ? null : staffName;

        if (b == null) {
            System.out.println("skillcode 값이 없을 때");

            List<StaffVo> staffList = staffMapper.getSearchIntegerStaffList(new SearchRequestDto(d, c, a, null, startGraduateDay, endGraduateDay, null, null));
            System.out.println(staffList.toString());
            return staffList;
        } else {
            System.out.println("스킬코드 값이 있을 떄");
            List<Integer> skillCodes = stringToIntskill(skillCode);
            System.out.println(skillCodes.toString());
            //검색 조건으로 staffName List 조회
            List<Integer> staffNoList = staffMapper.getSearchIntegerList(new SearchRequestDto(d, c, a, null, startGraduateDay, endGraduateDay, null, null));
//            staffNoList.addAll(List.of(121,122,123,124,125,126,127,128,129,130));

            System.out.println("staffNoList : " + staffNoList.toString());
            List<StaffVo> staffList;
            if (andOr.equals("and")) {
                //And
                staffList = staffMapper.getSearchStaffListAnd(new SearchStaffSkillDto(staffNoList, skillCodes));
            }else {
//                Or
                 staffList = staffMapper.getSearchStaffListOr(new SearchStaffSkillDto(staffNoList, skillCodes));
            }
            //staffName List로 staffSkill조건으로 return staffVo
            System.out.println(staffList.toString());
            return staffList;
        }
    }

    private List<Integer> stringToIntskill(List<String> skillCode) {
        List<Integer> skillCodes = new ArrayList<>();
        for (int i = 0; i < skillCode.size(); i++) {
            if (skillCode.get(i).equals("JAVA")) {
                skillCodes.add(31);
            }
            if (skillCode.get(i).equals("JSP")) {
                skillCodes.add(32);
            }
            if (skillCode.get(i).equals("ASP")) {
                skillCodes.add(33);
            }
            if (skillCode.get(i).equals("PHP")) {
                skillCodes.add(34);
            }
            if (skillCode.get(i).equals("DELPHI")) {
                skillCodes.add(35);
            }
        }
        return skillCodes;
    }

    //삭제
    @Override
    @Transactional
    public void delete(int i) {
        staffMapper.delete(i);
        staffMapper.deleteStaffSkills(i);
    }

    //기존 스킬 외의 기술 체크 후 신규 저장
    public void checkSkill(List<String> skillCode) {
//        System.out.println(staffMapper.getSkillList());
        if (skillList.isEmpty()) {
//            skillList.add("JAVA");
//            skillList.add("JSP");
//            skillList.add("ASP");
//            skillList.add("PHP");
//            skillList.add("DELPHI");
            skillList.addAll(staffMapper.getSkillList());
        }
        System.out.println("스태틱리스트 : " + skillList.toString());
        System.out.println("codeList1 : " + skillCode);
        List<String> newSkillCode = new ArrayList<>();
        newSkillCode.addAll(skillCode);
        System.out.println("1skillCode: " + newSkillCode);
        //다지우고 남아 있는 코드가 있으면 추가해라
        for (int i = 0; i < skillList.size(); i++) {
            for (int j = 0; j < newSkillCode.size(); j++) {
                if (skillList.get(i).equals(newSkillCode.get(j))) {
                    System.out.println("2skillCode : " + newSkillCode);
                    newSkillCode.remove(j);
                }
            }
        }
        System.out.println("리퀘스트리스트 : " + newSkillCode);
        try {
            if (!newSkillCode.isEmpty()) {
                //신규 스킬 등록
                skillList.addAll(newSkillCode);
                System.out.println("2 newSkillcode : " + newSkillCode);
                staffMapper.registerSkill(new ForSkillListDto(newSkillCode));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String stringToTimestamp(String year, String month) throws ParseException {
        String date = changeMonth(month) + "-" + "01" + "-" + year + " " + "00:00:00";

        System.out.println(date);
        return date;
    }

    ;

    public String changeMonth(String monthString) {
        String month;
        switch (monthString) {
            case "Jan":
                month = "01";
                break;
            case "Feb":
                month = "02";
                break;
            case "Mar":
                month = "03";
                break;
            case "Apr":
                month = "04";
                break;
            case "May":
                month = "05";
                break;
            case "Jun":
                month = "06";
                break;
            case "Jul":
                month = "07";
                break;
            case "Aug":
                month = "08";
                break;
            case "Sep":
                month = "09";
                break;
            case "Oct":
                month = "10";
                break;
            case "Nov":
                month = "11";
                break;
            case "Dec":
                month = "12";
                break;
            default:
                month = "";
        }
        return month;
    }
}
