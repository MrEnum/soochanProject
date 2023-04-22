package com.nedam.soochanProject.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class OrSearchDto {
    private List<Integer> staffNoList;
    private List<Integer> skillCodeList;
    private List<Integer> newSkillCodeList;
    private int skillCountEss;
    private int skillCountNew;

    public OrSearchDto (List<Integer> staffNoList, List<Integer> skillCodeList ,List<Integer> newSkillCodeList){
        this.staffNoList = staffNoList;
        this.skillCodeList =skillCodeList;
        this.newSkillCodeList =newSkillCodeList;
        this.skillCountEss = skillCodeList.size();
        this.skillCountNew = newSkillCodeList.size();

        System.out.println(skillCodeList.size() + "-----" +newSkillCodeList.size());
    }
}
