package com.oracle.S202350102.controller;



import java.io.File;
import java.io.IOException;

import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.BoardReChk;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Comm;
import com.oracle.S202350102.dto.SearchHistory;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.chService.ChBoardService;
import com.oracle.S202350102.service.chService.ChChallengeService;
import com.oracle.S202350102.service.chService.ChSearchService;
import com.oracle.S202350102.service.chService.ChUser1Service;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.jhService.JhCallengeService;
import com.oracle.S202350102.service.main.UserService;
import com.oracle.S202350102.service.thService.ThChgService;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ChController {
	
	
	private final ChBoardService 		chBoardService;
	private final ChSearchService 		chSearchService;
	private final ChChallengeService	chChallengeService;
	private final UserService			userService;
	private final JhCallengeService 	jhCService;
	private final ThChgService 			tcs;
	
	
	// notice List 조회 
	@RequestMapping("/notice")
	public String noticeList(Board board,Model model,HttpSession session, String currentPage) {
		System.out.println("ChController noticeList Start...");
		int totalNotice = chBoardService.noticeCount(board.getBrd_md());
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			model.addAttribute("status_md", user1.getStatus_md());
			model.addAttribute("user_num", user_num);
			
		}
		
		Paging page = new Paging(totalNotice, currentPage);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		List<Board> noticeList = chBoardService.noticeLIst(board);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("brd_md", board.getBrd_md());
		model.addAttribute("totalNotice", totalNotice);
		model.addAttribute("page", page);
		
		return "notice";
	}
	// notice 작성 form
	@PostMapping("noticeWriteForm")
	public String noticeWrite(int brd_md,Model model,HttpSession session) {
		System.out.println("ChController noticeList Start...");
		
		model.addAttribute("brd_md", brd_md);
		// 권한 확인 
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			
			if(user1.getStatus_md() == 102) {
				//user id에 맞는 값 가지고 가기
				model.addAttribute("user1",user1);
				return "/ch/noticeWriteForm";
			}
		}
		
		return "forward:notice";
		
		
	}
	
	// notice 작성	
	@PostMapping("noticeWrite")
	public String noticeWrite(Board board, HttpServletRequest request,@RequestParam(value = "file", required = false) MultipartFile file1) throws IOException {
		System.out.println("ChController noticeWrite Start...");
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");  // 저장경로 생성
//		ServletContext servletContext = request.getSession().getServletContext();
//		String realPath = servletContext.getRealPath("/upload/");
		System.out.println("realPath" + uploadPath);
		log.info("originalName : " + file1.getOriginalFilename());
//		log.info("size: " + file1.getSize());
//		log.info("contentType: " + file1.getContentType());
//		log.info("uploadPath: " + realPath);  // 저장 경로 확인 
		String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);  // 진짜 저장
		
		board.setImg(saveName);
		System.out.println("brd_md->"+ board.getBrd_md());
		int result = chBoardService.noticeWrite(board);
		System.out.println("Insert result->" + result);	

		request.setAttribute("brd_md", board.getBrd_md());
		
		return "forward:notice";		
		
	}
	
	
	// notice 조회
	@GetMapping("noticeConts")
	public String noticeConts(int brd_num, Model model,HttpSession session) {
		System.out.println("ChController noticeConts Start...");
		System.out.println("brd_num->" + brd_num);
		// 작성자 확인 
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			model.addAttribute("status_md", user1.getStatus_md());
			model.addAttribute("user_num", user_num);
		}
		
		
		chBoardService.noticeViewUp(brd_num);
		Board noticeConts = chBoardService.noticeConts(brd_num);
		
		model.addAttribute("noticeConts", noticeConts);
		
		return "/ch/noticeConts";
	}
	
	// notice UpdateForm
	@RequestMapping(value = "noticeUpdateForm")
	public String noticeUpdateForm(Board board, Model model, HttpSession session) {
		System.out.println("ChController noticeUpdateForm Start...");
		System.out.println("brd_num->" + board.getBrd_num());
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			// 글의 user_num과 내 session의 user_num이 같은가?
			if(board.getUser_num() == user_num) {
				Board noticeConts = chBoardService.noticeConts(board.getBrd_num());
				model.addAttribute("noticeConts", noticeConts);
				
				return "/ch/noticeUpdateForm";
			}
		}
		
		return "/ch/notAnAdmin";
		
	}
	// notice Update
	@PostMapping("noticeUpdate")
	public String noticeUpdate(Board board, HttpServletRequest request, @RequestParam(value = "file1", required = false) MultipartFile file1) throws IOException {
		System.out.println("ChController noticeUpdate Start...");
		int result = 0;
		ServletContext servletContext = request.getSession().getServletContext();
		String realPath = servletContext.getRealPath("/upload/");
		System.out.println("realPath->" + realPath);
		if(file1 != null) {
			String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), realPath);  // 진짜 저장
			
			board.setImg(saveName);	
		}
		
		
		result = chBoardService.noticeUpdate(board);
	
		request.setAttribute("brd_md", board.getBrd_md());
		return "forward:notice";
	}
	// notice 삭제 확인
	@GetMapping("deleteNoticeForm")
	public String deleteform(int brd_num, Model model) {
			System.out.println("ChController deleteform Start...");
			Board board = chBoardService.noticeConts(brd_num);
			model.addAttribute("brd_num", brd_num);
			model.addAttribute("brd_md", board.getBrd_md());
			
		return "/ch/deleteNoticeForm";
	}
	// 실제 삭제
	@PostMapping("deleteNotice")
	public String deleteNotice(Board board, HttpServletRequest request,HttpSession session) {
		System.out.println("ChController deleteNotice Start...");
		board = chBoardService.noticeConts(board.getBrd_num());
		int user_num = 0;
		
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			// 글의 user_num과 내 session의 user_num이 같은가?
			if(board.getUser_num() == user_num) {
				int result = chBoardService.deleteNotice(board.getBrd_num());
				request.setAttribute("brd_md",board.getBrd_md());
				
				return "forward:notice";
			}
		}
		
		return "/ch/notAnAdmin";
		
		
	}
	// 검색 기본 page
	@GetMapping("search")
	public String search(Model model, HttpSession session) {
		System.out.println("ChController search Start...");
		List<Challenge> popchgList = chChallengeService.popchgList(); // 챌린지
		List<Board> popBoardList = chBoardService.popBoardList(); // 자유개시판
		List<Board> popShareList = chBoardService.popShareList();
		
		// 검색기록 조회
		int user_num = 0;
		List<SearchHistory> sHList = null; 
		// 로그인 회원이면
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			List<SearchHistory> sh = chSearchService.sHistoryList(user_num);
			model.addAttribute("shList", sh);
			
		}
		model.addAttribute("user_num", user_num);
		model.addAttribute("popchgList", popchgList); 
		model.addAttribute("popBoardList", popBoardList);
		model.addAttribute("popShareList", popShareList);
		
		
		return "search";
	}
	
	// 검색기능 
	@GetMapping("searching")
	public String searching(String srch_word, HttpSession session, Model model) {
		System.out.println("ChController searching Start...");
		String replSrch_word = srch_word.replace(" ", "");
		int user_num = 0;
		List<Challenge> srch_chgResult = null; // chg 검색 결과 List
		List<Board> srch_brdResult = null; // brd 검색 결과 List 
		List<Board> srch_shareResult = null; // sharing 검색 결과 List
		
		if(srch_word != "" && srch_word != null) { // 검색어가 null이 아니면 
			if(session.getAttribute("user_num") != null) {
				if(srch_word != null) {
					user_num = (int) session.getAttribute("user_num");
					User1 user1 = userService.userSelect(user_num);
					SearchHistory sh = new SearchHistory();
					sh.setSrch_word(replSrch_word);
					sh.setUser_num(user1.getUser_num());
					int result = chSearchService.saveWord(sh);
					if(result == 0) {
						chSearchService.updateHistory(sh);
						
					}
				}
				List<SearchHistory> sh = chSearchService.sHistoryList(user_num);
				model.addAttribute("shList", sh);
				
				
			}
			// 입력된 키워드에 따라 검색 
			srch_chgResult = chSearchService.chgSearching(replSrch_word); // 챌린지
			srch_brdResult = chSearchService.brdSearching(replSrch_word); // 자유게시판
			srch_shareResult = chSearchService.shareSearching(replSrch_word);
		}
		
		model.addAttribute("srch_word",replSrch_word);
		model.addAttribute("srch_chgResult",srch_chgResult);
		model.addAttribute("srch_brdResult",srch_brdResult);
		model.addAttribute("srch_shareResult",srch_shareResult);
	
		
		
		return "/ch/srchResult";
	}
	
	@RequestMapping(value = "srchcommunity")
	public String srchcommunity(String srch_word,Model model, String currentPage) {
		System.out.println("ChController srchcommunity Start...");
		
		String searchTerm = srch_word.replace(" ", "");
		Board board = new Board();
		board.setSearch(searchTerm);
		
		if(srch_word == null || srch_word=="") {
			return "redirect:searching";
		}
		List<Board> srch_brdResult = chSearchService.brdSearching(searchTerm); // 자유게시판
		Paging boardPage = new Paging(srch_brdResult.size(), currentPage);
		
		model.addAttribute("listCommunity",srch_brdResult);
		model.addAttribute("srch_word",searchTerm);
		model.addAttribute("boardPage",boardPage);
		
		return "listCommunity";
	}
	
	@ResponseBody
	@RequestMapping(value = "srch_history")
	public List<SearchHistory> srch_history(Model model, HttpSession session){
		
		List<SearchHistory> srch_his = null;
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num =(int) session.getAttribute("user_num");
			srch_his = chSearchService.sHistoryList(user_num);
		}
		
		
		
		return srch_his;
	}
	
	
	@RequestMapping(value = "deleteHis")
	public String deleteHis(String srch_word, HttpSession session) {
		System.out.println("ChController deleteHis Start...");
		SearchHistory sh = new SearchHistory();
		sh.setUser_num((int) session.getAttribute("user_num"));
		sh.setSrch_word(srch_word);
		chSearchService.deleteHis(sh);
		
		
		return "redirect:search";
	}
	
	@ResponseBody
	@RequestMapping(value = "rechk")
	public commReChk alarmchk(HttpSession session, ModelAndView mav) {
		int result = 0;
		List<BoardReChk> nochkList = null;
		commReChk rechk = new commReChk();
		if(session.getAttribute("user_num") != null) {
			int user_num = (int) session.getAttribute("user_num");
			
			nochkList = chBoardService.alarmchk(user_num);
			result = nochkList.size();
			System.out.println("nochkList.size()->" + nochkList.size());
			rechk.setListBdRe(nochkList);
			rechk.setReCount(result);
		}
		
		
		
		
		return rechk;
	}
	
	
	@RequestMapping(value = "chgCommManagement")
	public String chgCommManagement(HttpSession session, Model model) {
		System.out.println("ChController chgCommManagement Start...");
		List<Comm> chgCommList = null;
		if(session.getAttribute("user_num") != null) {
			int user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			if(user1.getStatus_md() == 102) {
				chgCommList = chChallengeService.chgCommList();
			}
			
		}
			
		model.addAttribute("chgCommList", chgCommList);
		
		return "/ch/chgCommManage";
	}
	
	@PostMapping(value = "insertChgComm")
	public String insertChgComm(String ctn) {
		System.out.println("ChController insertChgComm Start...");
		int result = 0;
		
		result = chChallengeService.chgInsertComm(ctn);
		
		return "redirect:chgCommManagement";
	}
	
	@PostMapping(value = "deleteChgComm")
	public String deleteChgComm(String[] ctn) {
		System.out.println("ChController deleteChgComm Start...");
		int result = 0;
		
		result = chChallengeService.chgDeleteComm(ctn);
		
		return "redirect:chgCommManagement";
	}
	
	
	public void myConts(HttpSession session, Model model, String currentPage) {
		System.out.println("ChController myConts Start...");
		int user_num = 0;
		
		
		Paging myReviewPage = null;
		Paging myCertiPage = null;
		Paging myCommuPage = null;
		Paging mySharePage = null;
		
		List<Board> myReviewList = null;
		List<Board> myCertiList = null;
		List<Board> myCommuList = null;
		List<Board> myShareList = null;
		
		if(session.getAttribute("user_num") != null) {
			user_num = (int)session.getAttribute("user_num");
			Board board = new Board();
			List<Paging> myPaging = chBoardService.myCount(user_num);
			System.out.println("myPaging size->" + myPaging.size());
			for(Paging p : myPaging) {
				if(p.getBrd_md() == 100) {
					myCertiPage= new Paging(p.getTotal(), currentPage);
					System.out.println("myCertiPage.getBrd_md()->" + p.getBrd_md());
					board.setBrd_md(p.getBrd_md());
					board.setUser_num(user_num);
					board.setStart(myCertiPage.getStart());
					board.setEnd(myCertiPage.getEnd());
					myCertiList = chBoardService.mychgBoardList(board);
					
					model.addAttribute("Certi_md",p.getBrd_md());
					model.addAttribute("myCertiPage",myCertiPage);
				} else if(p.getBrd_md() == 101) {
					myReviewPage= new Paging(p.getTotal(), currentPage);
					System.out.println("myCertiPage.getBrd_md()->" + p.getBrd_md());
					board.setBrd_md(p.getBrd_md());
					board.setUser_num(user_num);
					board.setStart(myReviewPage.getStart());
					System.out.println("myReviewPage.getStart()->" + p.getBrd_md());
					board.setEnd(myReviewPage.getEnd());
					myReviewList = chBoardService.mychgBoardList(board);
					
					model.addAttribute("Review_md",p.getBrd_md());
					model.addAttribute("myReviewPage",myReviewPage);
				} else if(p.getBrd_md() == 102) {
					mySharePage= new Paging(p.getTotal(), currentPage);
					System.out.println("mySharePage.getBrd_md()->" + mySharePage.getBrd_md());			
					board.setBrd_md(p.getBrd_md());
					board.setUser_num(user_num);
					board.setStart(mySharePage.getStart());
					board.setEnd(mySharePage.getEnd());
					myShareList = chBoardService.myCommuList(board);
					
					model.addAttribute("Share_md",p.getBrd_md());
					model.addAttribute("mySharePage",mySharePage);
				} else if(p.getBrd_md() == 103) {
					myCommuPage= new Paging(p.getTotal(), currentPage);
					System.out.println("myCommuPage.getBrd_md()->" + myCommuPage.getBrd_md());
					board.setBrd_md(p.getBrd_md());
					board.setUser_num(user_num);
					board.setStart(myCommuPage.getStart());
					board.setEnd(myCommuPage.getEnd());
					myCommuList = chBoardService.myCommuList(board);
					
					model.addAttribute("commu_bd",p.getBrd_md());
					model.addAttribute("myCommuPage",myCommuPage);
				}
						
					
				}
				myChgList(session, model);
			}

		
		model.addAttribute("myReviewList", myReviewList);
		model.addAttribute("myCertiList", myCertiList);
		model.addAttribute("myCommuList", myCommuList);
		model.addAttribute("myShareList", myShareList);
		
		
	}
	
	
	@ResponseBody
	@PostMapping(value = "readAlarm")
	public String readAlarm(BoardReChk brc) {
		System.out.println("ChController readAlarm Start...");
		
		int result = chBoardService.readAlarm(brc);
		
		String result1 = Integer.toString(result);
		
		return result1;
	}
	
	@ResponseBody
	@PostMapping(value = "moveToNewCmt")
	public String moveToNewCmt(BoardReChk brc) {
		System.out.println("ChController readAlarm Start...");
		
		int result = chBoardService.moveToNewCmt(brc);
		
		String result1 = Integer.toString(result);
		
		return result1;
	}
	
	@ResponseBody
	@PostMapping(value = "readAllcmt")
	public int readAllcmt(HttpSession session) {
		System.out.println("ChController readAllcmt Start...");
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num =(int) session.getAttribute("user_num");
		}
		
		int result = chBoardService.readAllcmt(user_num);
		
		System.out.println("ChController readAllcmt Start...");
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "pageAjax" )
	public commReChk pageAjax(int brd_md,String currentPage, HttpSession session) {
		System.out.println("pageAjax Start...");
		int user_num = 0;
		commReChk result = new commReChk();
		
		
		
		if(session.getAttribute("user_num") != null) {
			user_num = (int)session.getAttribute("user_num");
			Board board = new Board();
			board.setUser_num(user_num);
			board.setBrd_md(brd_md);
			int tot = chBoardService.pageMove(board);
			
			Paging page = new Paging(tot, currentPage);
			page.setBrd_md(brd_md);
			board.setUser_num(user_num);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
			List<Board> myList = null;
			
			switch (page.getBrd_md()) {
			case 100:
			case 101:
				myList = chBoardService.mychgBoardList(board);
				result.setListBdRe(myList);
				result.setPage(page);
				result.setReCount(myList.size());
				break;
				
			case 102:
			case 103:
				myList = chBoardService.myCommuList(board);
				result.setListBdRe(myList);
				result.setPage(page);
				result.setReCount(myList.size());
				break;
				
			default:
				break;
			}
			
		}
		
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "myContsDelete")
	public int myContsDelete(int brd_num) {
		System.out.println("ChController myContsDelete Start");
		System.out.println("ChController myContsDelete board.getBrd_num() -> "+brd_num);
		int result = 0;
		
		result = chBoardService.deleteNotice(brd_num);
		
		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "fuckingTryShit")
	public ModelAndView myApplychg(HttpSession session, ModelAndView mav) {
		System.out.println("ChController myApplychg Start...");
		Paging page = new Paging(0, null);
		if(session.getAttribute("user_num") != null) {
			int user_num = (int) session.getAttribute("user_num");
			// 내가 신청한 챌린지
			
			Board board = new Board();
			board.setUser_num(user_num);
			board.setStart(page.getStart());			
			board.setEnd(page.getEnd());
			List<Challenge> mychgList = chChallengeService.myChgList(board);
			
			mav.addObject("mychgList", mychgList);
			mav.setViewName("ch/myApplychg");
		}
		return mav;
	}
	
	@RequestMapping("myChgUpdate")
	public String myChgUpdate(int chg_id,HttpSession session, Model model) {
		if(session.getAttribute("user_num") != null) {
			int user_num = (int) session.getAttribute("user_num");
			Challenge chg = jhCService.chgDetail(chg_id);
			if(user_num != chg.getUser_num()) {
				return "ch/notAnAdmin";
			}
			User1 user = userService.userSelect(user_num);
			model.addAttribute("user", user);
			model.addAttribute("chg", chg);
			
			
			int categoryLd = 200;
			List<Comm> category = jhCService.category(categoryLd);
			
			model.addAttribute("category", category);
			
			List<Challenge> recomChgList = null;
			if (!category.isEmpty()) {
			    int firstMdValue = category.get(0).getMd();
			    
			    recomChgList = recommendCallenge(firstMdValue);
				
			}
			
			List<Comm> chgCategoryList = tcs.listChgCategory();
			model.addAttribute("chgCategoryList", chgCategoryList);

			
			
			model.addAttribute("recomChgList", recomChgList);
			
			model.addAttribute("user", user);
			
			
			
		}
		
		return "ch/myChgUpdateForm";
	}
	
	
	public void commentAlaram(int brd_num) {
		System.out.println("Start commentAlaram....");
		int result = chBoardService.commentAlarm(brd_num);
	}
	
	public void myChgList(HttpSession session, Model model) {
		System.out.println("ChController myChgList Start...");
		Paging page = new Paging(0, null);
		if(session.getAttribute("user_num") != null) {
			int user_num = (int) session.getAttribute("user_num");
			// 내가 신청한 챌린지
			
			Board board = new Board();
			board.setUser_num(user_num);
			board.setStart(page.getStart());			
			board.setEnd(page.getEnd());
			List<Challenge> mychgList = chChallengeService.myChgList(board);
			
			// 참여 중인 챌린지
			List<Challenger> mychgrList = chChallengeService.myChgrList(user_num);
			model.addAttribute("mychgList", mychgList);
			model.addAttribute("mychgrList", mychgrList);
		}
		System.out.println("ChController myChgList End...");
		
	}
	
	
	private String uploadFile(String originalName, byte[] fileData, String uploadPath) throws IOException {
		UUID uid = UUID.randomUUID();  // universally unique identifier 국제 유일 식별자, 해당 객체를 사용한다면 같은 파일을 올려도 서로 다른 이름을 갖는다. 
		// requestPath = requestPath + "/resources/image";
		System.out.println("uploadPath->" + uploadPath);
		//Directory 생성, jsp는 폴더가 없을 때 수동으로 폴더를 만들어주지만 spring boot는 없을경우 자동으로 만들 수 있음 
		File fileDirectory = new File(uploadPath);  
		if (!fileDirectory.exists()) { // 해당 경로에 폴더가 없다면 신규폴더를 생성 
			//신규 폴더 생성 
			fileDirectory.mkdirs(); // 해당 메서드를 사용하면 자동으로 디렉토리(폴더)를 만들 수 있음 
			System.out.println("시스템 업로드용 폴더 생성 :" + uploadPath);			
		}
		
		String savedName = uid.toString() + "_" + originalName;
		log.info("saveName : " + savedName); 
		File target = new File(uploadPath, savedName);
		//file target = new file(requestPath, savedName
		// file UpLoad ----> uploadPath / UUID + _ + originalname
		FileCopyUtils.copy(fileData, target);  // import org.springframework.util.FileCopyUtils;
		// 용량, target을 넣으면 내부적으로 업로드
		// 만든 타겟을 카피하면 업로드, 시스템적으로 떨어져 있더라도 업로드 시킨다.
		return savedName;
	}
	
	@Data
	private class commReChk {
		private List<?> listBdRe;
		private Object reCount;
		private Paging page;
	}
	
	public List<Challenge>  recommendCallenge(int chg_md){
		System.out.println("JhController recommendCallenge Start...");
		
		List<Challenge> recomChgList = jhCService.recomChgList(chg_md);
//		for (Challenge challenge : chgList) {
//		    System.out.println(challenge.getTitle());
//		}
		

		return recomChgList;
	}
	
	
}
