package com.nedam.soochanProject.serviceImpl;

import com.nedam.soochanProject.domain.StaffVo;
import com.nedam.soochanProject.dto.DetailRequestDto;
import com.nedam.soochanProject.dto.UpdateRequestDto;
import com.nedam.soochanProject.mapper.StaffMapper;
import com.nedam.soochanProject.service.StaffService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("StaffServiceImpl")
@Transactional
@AllArgsConstructor
public class StaffServiceImpl implements StaffService {

    @Autowired
    private final StaffMapper staffMapper;

    @Override
    public List<StaffVo> getStaffList() {
        System.out.println("작동 됩니까?7");
        return staffMapper.getStaffList();
    }

    //등록
    @Override
    public void register(String staffName, String juminNo, String schoolCode, String departmentCode, String graduateDay) {
        StaffVo staffVo = new StaffVo(staffName, juminNo, schoolCode, departmentCode, graduateDay);
        staffMapper.register(staffVo);
        System.out.println("success register");
    }

    //수정
    @Override
    public void update(int staffNum, String staffName, String juminNo, String schoolCode, String departmentCode, String graduateDay) {
        UpdateRequestDto updateRequestDto = new UpdateRequestDto(staffNum, staffName, juminNo, schoolCode, departmentCode, graduateDay);
        staffMapper.update(updateRequestDto);
        System.out.println("success update");
    }

    //상세조회
    @Override
    public StaffVo getDetail(String staffName, String departmentCode) {
        DetailRequestDto dto = new DetailRequestDto(staffName, departmentCode);

        return staffMapper.getDetail(dto);
    }
}
