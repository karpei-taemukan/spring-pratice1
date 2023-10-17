package com.MovieProject.Controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Service.AdminService;

@Controller
public class AdminController {
@Autowired
private AdminService adsvc;

@RequestMapping(value="/addCgvMovieInfo")
public ModelAndView addCgvMovieInfo() throws IOException {
	System.out.println("영화정보 수집 요청 - addCgvMovieInfo");
	//추가된 영화 개수 
	int addCount = adsvc.addCgvMovie();
	 System.out.println("추가: "+addCount);
	
	 
	 ModelAndView mav = new ModelAndView();
	 mav.setViewName("redirect:/");
	 return mav;
}


@RequestMapping(value="/addCgvTheaterInfo")
public ModelAndView addCgvTheaterInfo() {
	System.out.println("극장정보 수집 요청 - addCgvTheaterInfo");	
	
	int addCount = adsvc.addCgvTheaters();
	System.out.println("극장 개수: "+addCount);
	
	ModelAndView mav = new ModelAndView();
	mav.setViewName("redirect:/");
	return mav;
}

@RequestMapping(value="/addCgvScheduleInfo")
public ModelAndView addCgvScheduleInfo() {
	System.out.println("극장정보 수집 요청 - addCgvScheduleInfo");	
	
	int addCount = adsvc.addCgvSchedule();
	System.out.println("상영 스케쥴: "+addCount);
	ModelAndView mav = new ModelAndView();
	mav.setViewName("redirect:/");
	return mav;
}

@RequestMapping(value="/mapperTest")
public String mapperTest(String thcode) {
	System.out.println("선택한 극장: "+thcode);
	adsvc.mapperTest_movie(thcode);
	return "redirect:/";
}
}




