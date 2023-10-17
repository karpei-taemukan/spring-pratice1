package com.MovieProject.Controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Seat;
import com.MovieProject.Dto.Theater;
import com.MovieProject.Service.MovieServie;
import com.MovieProject.Service.ScheduleService;
import com.MovieProject.Service.SeatService;
import com.MovieProject.Service.TheaterService;
import com.google.gson.Gson;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieServie mvsvc;
	
	@Autowired
	private TheaterService thsvc;
	
	@Autowired
	private ScheduleService scsvc;
	
	@Autowired
	private SeatService ssvc;
	
	
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		System.out.println("메인페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		// 1. 영화 랭킹 목록 조회 
		
		// select * from movies order by mvopen desc;
			
		 ArrayList<Movie> rankList = mvsvc.getRankMovieList();
			
		System.out.println("rankList: "+rankList);
			// 2. 이동할 페이지 설정 
			mav.addObject("rankList",rankList);
		mav.setViewName("home");
		return mav;
	}
	
	@RequestMapping(value="/movieDetail")
	public ModelAndView movieDetail(String mvcode) {
		System.out.println("영화상세페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		// 1. SERVICE - 영화정보 조회 메소드 호출 
		
		Movie movie = mvsvc.getDetailMovie(mvcode);
		
		System.out.println(movie);
		mav.addObject("movie",movie);
		
		// 2. SERVICE - 관람평 목록 조회 
		//--> mvcode로 관람평을 가져올려면 reviews와 조인을 해서 가져온다
		// 관람평 작성자 (아이디-mid, 프로필-mprofile), 관람평 내용-rvcomment, 관람평 작성일-rvdate 

		ArrayList<HashMap<String,String>> reviewList = mvsvc.getReviewList(mvcode);
		
		
		mav.addObject("rvList", reviewList);
		mav.setViewName("movie/movieDetail");
		return mav;
	}
	
	@RequestMapping(value="/movieList")
	public ModelAndView movieList() {
		ModelAndView mav = new ModelAndView();
		
	//	ArrayList<Movie> movieList = mvsvc.getCurrentMovie();
		ArrayList<Movie> movieList = mvsvc.getMovieList("ALL");

		System.out.println(movieList);
		
		mav.addObject("movieList",movieList);	
	
		mav.setViewName("movie/movieList");
		return mav;
	}
	
	
	
	
	
	@RequestMapping(value="/reserveMovie")
	public ModelAndView reserveMovie() {
		System.out.println("영화 예매 페이지 이동요청 - /reserveMovie");
		
		ModelAndView mav = new ModelAndView();
		
		//영화 목록
		ArrayList<Movie> movieList = mvsvc.getMovieList("ALL");
	//	ArrayList<Movie> movieList = mvsvc.getCurrentMovie();
		mav.addObject("mvList",movieList);
		
		
		//극장 목록 
		ArrayList<Theater> theaterList = thsvc.getTheaterList("ALL");
//		
		 mav.addObject("thList",theaterList);
		
		mav.setViewName("movie/reservePage");
		
		return mav;
	}

	
	@RequestMapping(value="/movieList_json")
	public @ResponseBody String movieList_json(String selThcode) {
		System.out.println("예매페이지_영화 목록 조회 요청");
		System.out.println("selThcode: "+selThcode );
		
		ArrayList<Movie> movieList = mvsvc.getMovieList(selThcode);
		
		
		return new Gson().toJson(movieList);
	}
	
	
	@RequestMapping(value="/theaterList_json")
	public @ResponseBody String theaterList_json(String selMvcode) {
		System.out.println("예매페이지_극장 목록 조회 요청");
		System.out.println("선택한 영화 코드: "+selMvcode);
		
		ArrayList<Theater> thList = thsvc.getTheaterList(selMvcode);
	
		System.out.println(thList);
		
		System.out.println(thList.size());
		
		return new Gson().toJson(thList);
	}
	
	
	
	
	
	@RequestMapping(value="/getScheduleDateList_json")
	public @ResponseBody String getScheduleDateList_json(String mvcode, String thcode) {
		System.out.println("예매가능한 날짜 목록 조회 요청");
		
		ArrayList<Schedule> scList = scsvc.getDateList(mvcode, thcode);
		
		return new Gson().toJson(scList);
	}
	
	
	
	@RequestMapping(value="/getScheduleTimeList_json")
	public @ResponseBody String getScheduleTimeList_json(String mvScode, String thScode, String scSdate) {
		System.out.println("예매가능한 상영관 목록 조회 요청");
		
		ArrayList<Schedule> screenList = scsvc.getTimeList(mvScode, thScode, scSdate);
		
		System.out.println("screenList: "+new Gson().toJson(screenList));
		
		return new Gson().toJson(screenList);
	}
	
	
	
	@RequestMapping(value="/registReserveInfo")
	public @ResponseBody String registReserveInfo(Reserve reinfo, HttpSession session) {
		System.out.println("예매처리요청 - /registReserveInfo ");
		System.out.println(reinfo);
		
		String loginId = (String)session.getAttribute("loginMemberId");
		//String loginId = (String)session.getAttribute("loginId"); 카카오 로그인
 		if(loginId == null) {
		
			return "login";
		}
		else {			
			reinfo.setMid(loginId);
			
			String registResult = mvsvc.registReserveInfo(reinfo);
			System.out.println("registResult: "+registResult);
			return registResult;	
		}
		
	}
	
	
// -------------------------------------------------------------------------------	
	
	
	@RequestMapping(value = "/seat")
	public @ResponseBody String seat(String mvcode,String thname, String schall, String sctime,String seatId, String seatType, HttpSession session) {
		System.out.println("좌석예매 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		System.out.println("mvcode: "+mvcode);
		
		System.out.println("thname: "+thname);
		//session.setAttribute("thname", thname);
		
		System.out.println("sctime: "+sctime);
		//session.setAttribute("scdate", scdate);
		
		System.out.println("schall: "+schall);
		//session.setAttribute("schall", schall);
		
		System.out.println("seatId: "+seatId);
		System.out.println("seatType: "+seatType);
		String loginId = (String)session.getAttribute("loginMemberId");
		//mav.addObject("loginId",loginId);

	ArrayList<Seat> seatList = ssvc.getSeatList(mvcode,thname,schall,sctime,loginId, seatId, seatType);
		
		
		return new Gson().toJson(seatList);
	}
	
	@RequestMapping(value = "/seatReserve")
	public @ResponseBody String seatReserve(String seatId, String seatType) {
		System.out.println("좌석예매 요청");
		System.out.println("좌석 번호 "+seatId);
		System.out.println("좌석 타입 "+seatType);
		ModelAndView mav = new ModelAndView();
		int seatList = ssvc.reserveSeat(seatId,seatType);
		mav.setViewName("seat");
		return new Gson().toJson(seatList);
	}
	

}
