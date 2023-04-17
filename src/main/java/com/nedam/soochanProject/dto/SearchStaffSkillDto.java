package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.spi.LocaleServiceProvider;

@Data
@NoArgsConstructor
public class SearchStaffSkillDto {
    private List<Integer> staffNoList;
    private List<Integer> skillCodeList;
    private int skillCount;


    public SearchStaffSkillDto (List<Integer> staffNoList, List<Integer> skillCodeList){
        this.staffNoList = staffNoList;
        this.skillCodeList= skillCodeList;
        this.skillCount = skillCodeList.size();

    }
}
