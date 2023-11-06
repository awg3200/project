package com.oracle.S202350102.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.jhService.JhCallengeService;
import com.oracle.S202350102.service.main.UserService;
import com.oracle.S202350102.service.yrService.YrChallengerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class JhController {

	private final JhCallengeService jhCService;
	private final UserService userService;
	// yr 작성
	// challenger 테이블값 가져오기용
	private final YrChallengerService ycs;
	
	//챌린지 상세정보 조회
	@RequestMapping(value = "chgDetail")
	public String chgDetail(@RequestParam("chg_id") int chg_id, HttpSession session, Model model, String insertResultStr) {
		//																						  yr작성(챌린지 신청 후 결과 값 불러오기)

		System.out.println("JhController chgDetail Start...");
		System.out.println("JhController chgDetail  chg_id -> "+ chg_id);

		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		}
		//유저 정보(회원번호) 조회 -> 일단 더 필요한 유저 정보 있을까봐 user dto 자체를 가져옴 없으면 나중에 userNum만 모델에 저장할 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController chgDetail userNum -> " + user);
		model.addAttribute("user", user);
		
		
		
		//jh 작성
		//챌린지 상세정보 조회
		Challenge chgDetail = jhCService.chgDetail(chg_id);
		System.out.println("JhController chgDetail chg -> " + chgDetail);
		model.addAttribute("chg", chgDetail);
		
		//jh 작성
		//후기 목록 조회
		List<Board> chgReviewList = jhCService.chgReviewList(chg_id);
		model.addAttribute("chgReviewList", chgReviewList);
		
		
		
		
		// yr 작성
		// challenger 테이블에서 참여인원 가져오기용
		int chgrParti = ycs.selectChgrParti(chg_id);
		System.out.println("JhController chgDetail chgrParti -> " + chgrParti);
		model.addAttribute("chgrParti", chgrParti);
		
		// challenger 참여 유무 판단용
		Challenger chgr = new Challenger();
		chgr.setUser_num(userNum);
		chgr.setChg_id(chg_id);
		int chgrJoinYN = ycs.selectChgrJoinYN(chgr);
		System.out.println("JhController chgDetail chgrJoinYN -> " + chgrJoinYN);
		model.addAttribute("chgrYN", chgrJoinYN);
		
		// 챌린지 신청 완료 유무 판단용
		int insertResult = 0;
		if(insertResultStr != null) insertResult = Integer.parseInt(insertResultStr);
		System.out.println("JhController chgDetail insertResult -> " + insertResult);
		model.addAttribute("insertResult", insertResult);
		
		// 소세지들 출력용
		List<User1> listSsj = ycs.getListSsj(chg_id);
		System.out.println("JhController chgDetail listSsj -> " + listSsj);
		model.addAttribute("listSsj", listSsj);
		
		return "jh/jhChgDetail";
	}
	
	
	//챌린지 후기목록 조회 -> chgDetail로 합침
//	@RequestMapping(value = "reviewTab")
//	public String chgReviewList(@RequestParam("chg_id") int chg_id,  HttpSession session, Model model ){
//		System.out.println("JhController reviewList Start...");
//		System.out.println("JhController reviewList chg_id -> " + chg_id);
//		System.out.println("JhController reviewList user_num -> " + session.getAttribute("user_num"));
//		
//		//세션에서 회원번호 가져옴
//		int userNum = 0;
//		if(session.getAttribute("user_num") != null) {
//			userNum = (int) session.getAttribute("user_num");
//			System.out.println("JhController chgDetail userNum -> " + userNum);
//		}
//		
//		//유저 정보(회원번호) 조회 -> 일단 유저 dto로 모델에 저장 특정 정보만 필요할 경우 나중에 수정 예정
//		User1 user = userService.userSelect(userNum);
//		System.out.println("JhController chgDetail userNum -> " + user);
//		
//		List<Board> chgReviewList = jhCService.chgReviewList(chg_id);
//		model.addAttribute("chgReviewList", chgReviewList);
//		
//		model.addAttribute("user", user);
//		
//		return "jh/test3";
//	}
//	
	
	//챌린지 글 내용 조회
	@RequestMapping(value = "reviewContent")
	public String reviewContent(@RequestParam int brd_num, HttpSession session, Model model) {
		System.out.println("JhController reviewContent Start...");
		System.out.println("JhController reviewContent brd_num -> " + brd_num);
		
		//챌린지 글 내용 조회
		Board reviewContent = jhCService.reviewContent(brd_num);
		
		//챌린지 해당 글에 대한 댓글 조회
//		Board reviewReply = jhCService.reviewReply(brd_num);
		
		System.out.println("JhController reviewContent reviewContent -> " + reviewContent);
		model.addAttribute("reviewContent", reviewContent);
		return "jh/jhReviewContent";
	}
	
	
	
	
	
	
	
	
	
	//챌린지 신청 페이지로 이동
	@RequestMapping(value = "chgApplicationPage")
	public String chgApplication (HttpSession session, Model model) {
		System.out.println("JhController chgApplication Start...");
		System.out.println("JhController reviewList user_num -> " + session.getAttribute("user_num"));
		
		//세션에서 회원번호 가져옴
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("JhController chgDetail userNum -> " + userNum);
		}
		
		//유저 정보(회원번호) 조회 -> 일단 유저 dto로 모델에 저장 특정 정보만 필요할 경우 나중에 수정 예정
		User1 user = userService.userSelect(userNum);
		System.out.println("JhController chgDetail userNum -> " + user);
		
		//유저의 회원상태 가져옴
		String userStatus = jhCService.userStatus(userNum);
		
		model.addAttribute("user", user);
		model.addAttribute("userStatus", userStatus);
		
		
		return "jh/chgApplicationPage";
	}
	
	
	//챌린지 신청 등록
	@RequestMapping(value = "chgApplication")
	public String chgApplication (@ModelAttribute Challenge chg, @ModelAttribute User1 user, @RequestParam String userStatus,  Model model) {
		System.out.println("JhController chgApplication Start...");
		System.out.println("JhController chgApplication chg -> " + chg);		
		
		Date start_date = chg.getStart_date();
		Date end_date = chg.getEnd_date();
		
		
	
		//임시로 챌린지 목록으로 이동하게 함
		//나중에 내가 신청한 챌린지 목록으로 이동할 것
		return "listChallenge";
		
	}
	
	
	
	
}
