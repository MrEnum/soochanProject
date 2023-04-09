package com.nedam.soochanProject.controller;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.service.StaffService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {
   private final StaffService staffService;

    @GetMapping("/")
    public String home(Model model){

        List<StaffVo> staffList = staffService.getStaffList();
        System.out.println("home::::::::: wowwow~~" + staffList.get(0).getStaffName());

        model.addAttribute("viewAll", staffService.getStaffList());
        return "home/index";
    }
}