package com.nedam.soochanProject.serviceImpl;

import com.nedam.soochanProject.domain.StaffVo;
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
    private StaffMapper staffMapper;
    @Override
    public List<StaffVo> getStaffList() {
        System.out.println("작동 됩니까?7");
        return staffMapper.getStaffList();
    }
}
