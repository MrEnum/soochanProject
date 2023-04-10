package com.nedam.soochanProject.service;


import com.nedam.soochanProject.domain.StaffVo;

import java.util.List;

public interface StaffService {
    List<StaffVo> getStaffList();

    void register(String staffName, String juminNo, String schoolCode, String departmentCode, String graduateDay);

    void update(int staffNum, String staffName, String juminNo, String schoolCode, String departmentCode, String graduateDay);

    StaffVo getDetail(String staffName, String departmentCode);


}
