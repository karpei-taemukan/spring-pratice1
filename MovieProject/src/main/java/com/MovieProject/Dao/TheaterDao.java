package com.MovieProject.Dao;

import java.util.ArrayList;

import com.MovieProject.Dto.Theater;

public interface TheaterDao {
// 극장 목록 조회 매개변수 O
	ArrayList<Theater> selectTheaterList(String selMvcode);

}
