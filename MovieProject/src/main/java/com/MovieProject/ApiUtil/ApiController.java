package com.MovieProject.ApiUtil;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Dto.Reserve;

@Controller
public class ApiController {

@Autowired
private ApiService apisvc;
	
	
	@RequestMapping(value="/kakaoPay_ready")
	public @ResponseBody String kakaoPay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("카카오 페이 요청");
		System.out.println(reInfo);
	String result = apisvc.kakaoPay_ready(reInfo, session);
		return result;
	}
	
	@RequestMapping(value="/kakaoPay_approval")
	public ModelAndView kakaoPay_approval(String pg_token,HttpSession session) {
		System.out.println("카카오 결제 요청");
		System.out.println("pg_token: "+ pg_token);
		String tid = (String) session.getAttribute("tid");
		System.out.println("tid: "+tid);
		String recode = (String) session.getAttribute("recode");
		String loginMemberId = (String) session.getAttribute("loginMemberId");
		
		ModelAndView mav = new ModelAndView();
		
		String result = apisvc.kakaoPay_approval(tid,recode,loginMemberId, pg_token);
		
		
		if(result == null) {
		System.out.println("카카오 결제 오류");
		mav.addObject("payResult","N");
		}
		else {
		System.out.println("카카오 결제 승인");	
		mav.addObject("payResult","Y");
		}
		
		session.removeAttribute("tid");
		mav.setViewName("PayResult");
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/kakaoPay_cancel")
	public ModelAndView kakaoPay_cancel(Reserve reInfo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
	
	String loginMemberId = (String) session.getAttribute("loginMemberId");
		
	System.out.println("reInfo: "+reInfo);
	int result = apisvc.kakaoPay_cancel(reInfo,loginMemberId);
	
		mav.addObject("payResult", "N");
		mav.setViewName("PayResult");
	return mav;
	}
	
	
	
	
}
