package com.nedam.soochanProject.mapper;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.DetailRequestDto;
import com.nedam.soochanProject.dto.UpdateRequestDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StaffMapper {
    List<StaffVo> getStaffList();

    void register(StaffVo staffVo);

    StaffVo getDetail(DetailRequestDto dto);

    void update(UpdateRequestDto updateRequestDto);
}
