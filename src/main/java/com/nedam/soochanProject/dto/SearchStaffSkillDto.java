package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.spi.LocaleServiceProvider;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchStaffSkillDto {
    private List<Integer> staffNoLsit;
    private List<String> staffSkillList;
}
