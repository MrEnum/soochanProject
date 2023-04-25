package com.nedam.soochanProject.controller;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.request.SearchRequestDto;
import com.nedam.soochanProject.mapper.StaffMapper;
import com.nedam.soochanProject.service.StaffService;
import com.nedam.soochanProject.serviceImpl.StaffServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class SearchController {

    private final StaffService staffService;
    private final StaffServiceImpl staffServiceImpl;
    private final StaffMapper staffMapper;

    @PostMapping("/search")
    @ResponseBody
    public List<StaffVo> search(SearchRequestDto searchRequestDto) {
        System.out.println("search컨트롤 들어오긴하네!" + searchRequestDto.toString());
        if (searchRequestDto == null) {
            return staffMapper.getAllStaff();
        } else {
            //for문보다 더 빠름. 불변리스트 어쩌고
            List<String> skillList = new java.util.ArrayList<>(List.of(searchRequestDto.getSkills().replace(" ", "").split(",")));
            List<String> schoolList = new java.util.ArrayList<>(List.of(searchRequestDto.getSchoolCodes().split(",")));
            if(skillList.get(0).equals("")){
                skillList.remove(0);
            }

            String startGra = null;
            String endGra = null;
            if (!searchRequestDto.getStartGraduateDay().equals("")) {
                startGra = searchRequestDto.getStartGraduateDay().substring(0, 4) + "-" + searchRequestDto.getStartGraduateDay().substring(4, 6) + "-" + searchRequestDto.getStartGraduateDay().substring(6, 8);
            }
            if (!searchRequestDto.getEndGraduateDay().equals("")) {
                endGra = searchRequestDto.getEndGraduateDay().substring(0, 4) + "-" + searchRequestDto.getEndGraduateDay().substring(4, 6) + "-" + searchRequestDto.getEndGraduateDay().substring(6, 8);
            }
            System.out.println(startGra + " / " + endGra);
            List<StaffVo> staffVoList = staffService.searchList(searchRequestDto.getStaffName(), searchRequestDto.getGender(), searchRequestDto.getDepartmentCode(), schoolList, skillList, startGra, endGra, searchRequestDto.getAndOr());
            return staffVoList;
        }
    }

    @PostMapping("/searchAll")
    @ResponseBody
    public List<StaffVo> searchAll() {
        return staffMapper.getAllStaff();
    }
}
