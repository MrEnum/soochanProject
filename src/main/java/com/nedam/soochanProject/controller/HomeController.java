package com.nedam.soochanProject.controller;

import com.nedam.soochanProject.dto.response.GetDetailResponseDto;
import com.nedam.soochanProject.dto.request.StaffRequestDto;
import com.nedam.soochanProject.mapper.StaffMapper;
import com.nedam.soochanProject.service.StaffService;
import com.nedam.soochanProject.serviceImpl.StaffServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;

import java.util.*;

import static com.nedam.soochanProject.serviceImpl.StaffServiceImpl.essentialSkills;
import static com.nedam.soochanProject.serviceImpl.StaffServiceImpl.skillList;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final StaffService staffService;
    private final StaffServiceImpl staffServiceImpl;
    private final StaffMapper staffMapper;

    @GetMapping("/")
    public String home(Model model) {
        System.out.println("페이지 들어옴");
        //새로운 스킬 리스트 보여주기
        staffServiceImpl.addEssentialSkills();
        List<String> allSkillList = new ArrayList<>(staffMapper.getSkillList());
        for (int i = 0; i < essentialSkills.size(); i++) {
            for (int j = 0; j < allSkillList.size(); j++) {

                if (allSkillList.get(j).equals(essentialSkills.get(i))) {
                    allSkillList.remove(j);
                }
            }
        }

        model.addAttribute("newSkills", allSkillList);
        return "home/staff_search_form";
    }


    @GetMapping("/register")
    public String inputPage(Model model) {
        staffServiceImpl.addEssentialSkills();
        List<String> allSkillList = new ArrayList<>(staffMapper.getSkillList());
        for (int i = 0; i < essentialSkills.size(); i++) {
            for (int j = 0; j < allSkillList.size(); j++) {

                if (allSkillList.get(j).equals(essentialSkills.get(i))) {
                    allSkillList.remove(j);
                }
            }
        }
        System.out.println(allSkillList);
        model.addAttribute("newSkills", allSkillList);

        return "home/staff_input_form";
    }

    //수정 return :
    @PostMapping("/update")
    public String update(StaffRequestDto staffRequestDto) throws ParseException {
        System.out.println("타집니다. 컨트롤러 ");
//        staffRequestDto.setStaffNo(staffNo);
        staffService.update(staffRequestDto);

        return "home/staff_search_form";
    }

    //상세조회
    @GetMapping("/getupdate")
    public String getDetail(Model model, int staffNo) {
        GetDetailResponseDto dto = staffService.getDetail(staffNo);
        System.out.println(dto.getGraduateDay());
        //날짜 파싱
        String[] splitStr = dto.getGraduateDay().split("-");
        int year = Integer.parseInt(splitStr[0]);
        int month = Integer.parseInt(splitStr[1]);
        System.out.println(year + " " + month);
        Date date = new Date(year - 1900, month - 1, 1);
        List<String> allSkillList = new ArrayList<>(staffMapper.getSkillList());
        for (int i = 0; i < essentialSkills.size(); i++) {
            for (int j = 0; j < allSkillList.size(); j++) {

                if (allSkillList.get(j).equals(essentialSkills.get(i))) {
                    allSkillList.remove(j);
                }
            }
        }
        System.out.println(allSkillList);
        model.addAttribute("newSkills", allSkillList);

        //Date타입에서 자바스크립트단에 맞게 바꿔서 문자열로 보내주기
        System.out.println(staffService.getDetail(staffNo));
        System.out.println(dto.getSkillCode());
        model.addAttribute("staff", dto);
        model.addAttribute("skillList", dto.getSkillCode());
        model.addAttribute("yearMonth", date);
        model.addAttribute("staffNo", staffNo);
//        model.addAttribute("month", yearMonth.getMonth());
        return "home/staff_updel_form";
    }

    //등록
    @PostMapping(value = "/register/do")
    @ResponseBody
    public Map<String, Boolean> register(StaffRequestDto staffRequestDto) throws Exception {
        System.out.println("staffRequestDto : " + staffRequestDto);
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        //문자열로 바꿔서 Date타입으로 변환
        staffService.register(staffRequestDto);
        map.put("check", true);
        return map;
    }


    @DeleteMapping("/delete/{staffNo}")
    public String delete(@PathVariable int staffNo) {
        System.out.println("삭제 컨트롤러 staffNo : " + staffNo);
        staffService.delete(staffNo);
        return "home/staff_search_form";

    }
}