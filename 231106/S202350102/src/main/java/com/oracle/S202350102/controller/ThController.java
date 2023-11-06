package com.oracle.S202350102.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.thService.ThKakaoPay;
import com.oracle.S202350102.service.thService.ThUser1Service;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@Data
public class ThController {
	// 태현 작업
	private final ThUser1Service us1;
	private final ThKakaoPay thKakaoPay;
	
	@PostMapping(value = "/writeUser1")
	public String writeUser1(User1 user1, Model model) {
		System.out.println("ThController writeUser1 start...");
		
		int insertResult = us1.insertUser1(user1);
		model.addAttribute("insertResult",insertResult);
		if(insertResult > 0 ) return "th/writeResult";
		else {
			model.addAttribute("msg", "입력 실패 확인해 보세요");
			return "signUp";
		}
	}
	
	@PostMapping(value = "/login")							// 로그인 유지를 위한 세션 필요
	public String login(@ModelAttribute User1 user1, HttpSession session, HttpServletRequest request) {
		System.out.println("ThController login start... ");
		User1 loginResult = us1.login(user1);
		System.out.println("ThController loginResult -- >" + loginResult);
		if (loginResult != null) {
			session = request.getSession();
			session.setAttribute("user_num", loginResult.getUser_num());
			System.out.println("session.getAttribute(\"user_num\") -->" + session.getAttribute("user_num"));
			return "home2";
		} else {
			return "loginForm";
		}
	}
	
	
	@RequestMapping(value = "/logoutForm")
	public String logoutForm() {
		System.out.println("ThController logoutForm start...");
		
		return "th/logoutForm";
	}
	
	@RequestMapping(value = "/logout")
	public String logout(User1 user1, HttpSession session) {
		System.out.println("ThController logout start... ");

		session.invalidate();
		return "home2";
	}
	
	@GetMapping(value = "/deleteUser1Form")
	public String deleteUser1Form() {
		System.out.println("ThController deleteUser1Form Start...");
		return "th/deleteUser1Form";
	}
	
	@PostMapping(value = "/deleteUser1")
	public String deleteUser1(User1 user1, HttpSession session, Model model) {
		System.out.println("ThController deleteUser1 Start... ");
		int deleteUserCnt = us1.deleteUser(user1); // 회원상태 탈퇴여부 N에서 Y로 변경
		session.invalidate(); // 세션 끊어줌
		System.out.println("ThController deleteUserCnt result --> " + deleteUserCnt);
		if (deleteUserCnt > 0) {
			model.addAttribute("deleteUserCnt",deleteUserCnt);
			return "home";
		}
		else {
			model.addAttribute("deleteUserCnt",deleteUserCnt);
			return "th/deleteUser1Form";
		}
	}
	
	@GetMapping(value = "userSubMng")
	public String userSubMng() {
		return "th/userSubMng";
	}
	
	@GetMapping(value = "thKakaoPayForm")
	public String thKakaoPayForm2() {
		return "th/thKakaoPayForm";
	}
	
	@GetMapping("/thKakaoPay")
	public void thKakaoPay2Get() {
		
	}
	
	@PostMapping("/thKakaoPay")
	public String thKakaoPay2() {
		System.out.println("ThController thKakaoPay2 Start...");
		
		return "redirect:" + thKakaoPay.kakaoPayReady();
	}
	
//	결제성공시 회원상태 구독회원으로 변경
    @PutMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);
        
        model.addAttribute("info", thKakaoPay.kakaoPayInfo(pg_token));
        
        return "th/kakaoPaySuccess";
    }
	
    @GetMapping("/kakaoPayCancel")
    public String kakaoPayCancel() {
    	
    	return "home2";
    }

		 
		
	
}