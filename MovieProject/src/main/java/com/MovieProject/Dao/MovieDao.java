package com.MovieProject.Dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;

public interface MovieDao {
	
	// 영화 인기순위
	ArrayList<Movie> selectMovieMvopen_mapper();

	// 영화 상세정보 
	Movie selectDetailMovie(String mvcode);
	 //영화 목록 매개변수 X
	ArrayList<Movie> selectCurrentMovie_Mapper();
	// 영화 목록 매개변수 O
	ArrayList<Movie> selectMovieList_json_Mapper(String selThcode);

	String selectMaxRecode();

	int insertReserve(Reserve reinfo);

	ArrayList<HashMap<String, String>> selectReviewList(String mvcode);

}
