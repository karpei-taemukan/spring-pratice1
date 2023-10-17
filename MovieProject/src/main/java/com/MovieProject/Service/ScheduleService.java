package com.MovieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.ScheduleDao;
import com.MovieProject.Dto.Schedule;

@Service
public class ScheduleService {

	@Autowired
	private ScheduleDao scdao;
	
	public ArrayList<Schedule> getDateList(String mvcode, String thcode) {
		System.out.println("SERVICE - getDateList() 호출");
		ArrayList<Schedule> scList =  scdao.selectDateList(mvcode, thcode);
		return scList;
	}

	public ArrayList<Schedule> getTimeList(String mvScode, String thScode, String scSdate) {
		System.out.println("SERVICE - getScreenList() 호출");
		ArrayList<Schedule> screenList = scdao.selctTimeList(mvScode, thScode, scSdate);
		return screenList;
	}

	

}
