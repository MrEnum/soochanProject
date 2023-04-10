package com.nedam.soochanProject.controller;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.service.StaffService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final StaffService staffService;

    @GetMapping("/")
    public String home(Model model) {

        //전체조회
//        List<StaffVo> staffList = staffService.getStaffList();
//        System.out.println("home::::::::: wowwow~~" + staffList.get(0).getStaffName());
        //상세조회
//        System.out.println(staffService.getDetail("문어","ICT사업부").getStaffName());
        //등록
//        staffService.register("문어", "45321", "고졸", "ICT사업부", "s");
        //수정
        staffService.update(1,"문수찬", "일이삼사", "고졸", "ICT사업부", "s");
        //삭제
//        model.addAttribute("viewAll", staffService.getStaffList());
        return "home/index";
    }

    @PostMapping("/register")
    public void register() {
    }
}