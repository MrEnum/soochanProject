package com.nedam.soochanProject.mapper;

import com.nedam.soochanProject.dto.SearchRequestDto;
import com.nedam.soochanProject.serviceImpl.StaffServiceImpl;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/applicationContext.xml")
public class StaffMapperTest extends TestCase {


    private StaffServiceImpl staffService;
    private StaffMapper staffMapper;

    @Test(expected =NullPointerException.class)
    public void testGetSearchList() {
        System.out.println("테스트 가능?");
//        SearchRequestDto searchRequestDto = new SearchRequestDto("문수찬",null,  null, List.of(new String[]{"JAVA", "JSP"}),null);
//        System.out.println(staffMapper.getSearchList(searchRequestDto));
        System.out.println(staffMapper.getAllStaff());
    }
}