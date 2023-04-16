package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class ForSkillListDto {
    private List<String> skillList;
}
