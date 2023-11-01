package com.oracle.S202350102.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.service.yrService.YrChallengerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class YrController {
	private final YrChallengerService ycs;
	
//	@RequestMapping(value = "checkBoard")
//	public String checkBoard() {
//		System.out.println("YrController index Start...");
//		return "yr/checkBoard";
//	}
	
	@RequestMapping(value = "ssjFriends")
	public String listSsj(Model model) {
		System.out.println("YrController listSsj Start...");
		List<Challenger> listSsj = ycs.getListSsj();
		return "yr/ssjFriends";
	}
	
}