package com.nedam.soochanProject.mapper;

import com.nedam.soochanProject.domain.StaffVo;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface StaffMapper {
    public List<StaffVo> getStaffList();
}
