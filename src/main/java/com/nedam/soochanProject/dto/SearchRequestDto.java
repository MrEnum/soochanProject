package com.nedam.soochanProject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class SearchRequestDto {
    private String staffName;       //like
    private String departmentCode;  //where
    private String schoolCode;      //where
    private List<String> skillCode; //like in
    private String graduateDay;	//where

}
