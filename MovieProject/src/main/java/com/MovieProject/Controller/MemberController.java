package com.MovieProject.Controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.MovieProject.Dto.Member;
import com.MovieProject.Service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memsvc;
	
	@RequestMapping(value="/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 페이지 이동요청 - /memberLoginForm");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/memberLoginForm");
		return mav;
	}

	@RequestMapping(value="/memberLogin")
	public ModelAndView memberLogin(@RequestParam(value="userId") String userId, 
			@RequestParam(value="userPw") String userPw, 
			HttpSession session, RedirectAttributes ra) {
		System.out.println("로그인 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		System.out.println("userId: "+userId);
		System.out.println("userPw: "+userPw);
		
		Member loginMember = memsvc.getLoginMemberInfo(userId, userPw);

		if(loginMember == null) {
			System.out.println("로그인 실패");
			mav.setViewName("redirect:/memberLoginForm");
			ra.addFlashAttribute("msg", "로그인 실패");
		}
		else {
			
			String mstate = loginMember.getMstate().substring(0,1);
			System.out.println(mstate);
			session.setAttribute("loginMemberId", loginMember.getMid());
			session.setAttribute("loginMemberName", loginMember.getMname());
			session.setAttribute("loginMemberProfile", loginMember.getMprofile());
			session.setAttribute("loginMemberState", loginMember.getMstate());
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg", "로그인 성공");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/memberLogin_kakao")
	public @ResponseBody String memberLogin_kakao(HttpSession session,String id) {
		System.out.println("카카오 로그인 요청");
		System.out.println("카카오 id: "+ id);
		
		Member loginMember_kakao = memsvc.getLoginMemberInfo_kakao(id);
		
		if(loginMember_kakao == null) {
			System.out.println("카카오 계정 정보 없음");
			return "N";
		}
		else {
			System.out.println("카카오 계정 정보 있음");
			System.out.println("로그인 처리");
			session.setAttribute("loginId", loginMember_kakao.getMid());
			session.setAttribute("loginName", loginMember_kakao.getMname());
			session.setAttribute("loginProfile", loginMember_kakao.getMprofile());
			session.setAttribute("loginState", loginMember_kakao.getMstate());

			return "Y";
		}
		
	}
	
	
	@RequestMapping(value="/memberJoin_kakao")
	public @ResponseBody String memberJoin_kakao(Member member){
		System.out.println("카카오 계정 - 회원 가입 요청 -/memberJoin_kakao");
		System.out.println(member);
		int result = memsvc.regusterMember_kakao(member);
		return result+"";
	}
	
	
	@RequestMapping(value="/memberJoin")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 페이지 이동요청 - /memberJoinForm");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/memberJoinForm");
		return mav;
	}
	
	@RequestMapping(value="/memberJoinRequest")
	public ModelAndView memberJoin(
			Member mem,RedirectAttributes ra, @RequestParam(value="memail" , required=false) String memail, @RequestParam(value="memailDomain", required=false) String memailDomain, HttpSession session) {
	System.out.println("회원 가입 요청 -/memberJoin");	
	mem.setMemail(memail+"@"+memailDomain);
	mem.setMstate("YC");
	ModelAndView mav = new ModelAndView();
//	System.out.println("member: "+mem);
//	System.out.println(memail+"@"+memailDomain);
	int joinMember = 0;
	
	try {
		joinMember = memsvc.joinMember(mem, session);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	if(joinMember > 0) {
		System.out.println("회원 가입 성공");
		mav.setViewName("redirect:/memberJoin");
		ra.addFlashAttribute("msg", "회원가입 성공"); 
	}
	else {
		System.out.println("회원 가입 실패");
		mav.setViewName("redirect:/memberJoin");
		ra.addFlashAttribute("msg", "회원가입 실패");
		
	}
	
	return mav;
	}
	
	@RequestMapping(value="/memberLogout")
	public String memberLogout(HttpSession session, RedirectAttributes ra) {
		session.invalidate();
		ra.addAttribute("msg", "로그아웃");
		return "redirect:/";
	}
	
	@RequestMapping(value="/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
	System.out.println("아이디 중복 확인 요청");
	System.out.println("중복확인할 아이디: "+ inputId);
	return memsvc.memberIdCheck(inputId);
	}

	@RequestMapping(value="/reserveList")
	public ModelAndView reserveList(HttpSession session, RedirectAttributes ra) {
		System.out.println("예매내역 페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginMemberId");
		
		if(loginId == null) {
			ra.addFlashAttribute("msg", "로그인 후 이용가능");
			mav.setViewName("redirect:/memberLoginForm");
			return mav;
		}
		
		// 예매 목록 조회 -> 영화제목 극장 상영관 상영시간
	
ArrayList<HashMap<String, String>> reserveList = memsvc.getReserveList(loginId); 
	
		System.out.println(reserveList);
		
		mav.addObject("reList", reserveList);
		mav.setViewName("member/reserveList");
		return mav;
	}
	
	@RequestMapping(value="/deleteComment")
	public ModelAndView deleteComment(@RequestParam(value="rvcode") String rvcode) {
		ModelAndView mav = new ModelAndView();
		
		int deleteCommentResult = memsvc.deleteComment(rvcode);
		
		if(deleteCommentResult > 0) {
			System.out.println("댓글 삭제 성공");
			
		}
		else {
			System.out.println("댓글 삭제 실패");
		}
		
		return mav;
	}
	
	
	
	
	@RequestMapping(value="/cancelReserve")
	public ModelAndView cancelReserve(@RequestParam(value="recode") String recode, HttpSession session, RedirectAttributes ra) {
		System.out.println("영화 예매 취소 요청 - /cancelReserve");
		
		System.out.println("취소할 영화: "+recode);
		
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String) session.getAttribute("loginMemberId");
		
		int deleteReserve = memsvc.deleteReserve(recode,loginId);
		
		if(deleteReserve > 0) {
			ra.addFlashAttribute("msg", "예매 취소 성공");
	
		}
		else {
			ra.addFlashAttribute("msg", "예매 취소 실패");
		}
		
		mav.setViewName("redirect:/reserveList");
		return mav;
	
	}
	
	@RequestMapping(value="/reviewWriteForm")
	public ModelAndView reviewWriteForm(String recode) {
		System.out.println("관람평 작성 페이지 이동 요청 - reviewWriteForm()");
		System.out.println("recode: "+recode);
		ModelAndView mav = new ModelAndView();
		
		// 관람한 영화 정보 조회 
		
		mav.setViewName("movie/reviewWriteForm");
		return mav;
	}
	

@RequestMapping(value="/registReview")
public ModelAndView registReview(String recode, String rvcomment, HttpSession session, RedirectAttributes ra) {
	ModelAndView mav = new ModelAndView();
	System.out.println("recode: "+recode);
	System.out.println("rvcomment: "+rvcomment);
	
	String loginId = (String)session.getAttribute("loginMemberId");
	
	 int registResult = memsvc.getReview(loginId, recode, rvcomment);
	
	 if(registResult > 0) {

		 ra.addFlashAttribute("msg", "댓글등록");
		 mav.addObject("rvList",rvcomment);
		 mav.setViewName("redirect:/reserveList");
	 }
	 else {
		 ra.addFlashAttribute("msg", "댓글실패");
		 mav.setViewName("redirect:/reviewWriteForm");

	 }
	 
	return mav;
}


	
}