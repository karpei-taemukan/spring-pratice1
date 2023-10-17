package com.MovieProject.Dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.Dto.Seat;

public interface SeatDao {



	ArrayList<Seat> insertSeatInfo(@Param("mvcode") String mvcode, @Param("thname") String thname,@Param("schall")  String schall, @Param("sctime") String sctime,@Param("loginId")  String loginId, @Param("seatId")  String seatId,@Param("seatType")  String seatType);
	

}
