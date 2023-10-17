package com.MovieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.SeatDao;
import com.MovieProject.Dto.Seat;

@Service
public class SeatService {

	@Autowired
	private SeatDao sdao;
	


	public ArrayList<Seat> getSeatList(String mvcode, String thname, String schall, String sctime, String loginId, String seatId, String seatType) {
		System.out.println("SERVICE - getSeatList() 호출");
		
		ArrayList<Seat> seat = sdao.insertSeatInfo(mvcode,thname, schall, sctime, loginId, seatId, seatType);
		
		return seat;
	}



	public int reserveSeat(String seatId, String seatType) {
		// TODO Auto-generated method stub
		return 0;
	}


	
}
