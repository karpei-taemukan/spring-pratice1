package com.MovieProject.Service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Reserve;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

@Service
public class MovieServie {
	
	@Autowired
	private MovieDao mvdao;
	
	public ArrayList<Movie> getRankMovieList() {
		System.out.println("SERVICE - getRankMovieList()호출");
		
		ArrayList<Movie> mvRankList = mvdao.selectMovieMvopen_mapper(); 
		for(Movie mov : mvRankList) {
			String movGrade = mov.getMvinfo();
			movGrade=movGrade.split(",")[0];
			if(movGrade.equals("15세이상관람가")) {
				movGrade = "15";
			
			}
			else if(movGrade.equals("전체관람가")) {
				movGrade = "All";
			}
			else if(movGrade.equals("12세이상관람가")) {
				movGrade = "12";
			}
			mov.setMvgrade(movGrade);
		}
		
		return mvRankList;
	}

	public Movie getDetailMovie(String mvcode) {
		System.out.println("SERVICE - getDetailMovie()호출");

		return mvdao.selectDetailMovie(mvcode);
	}

	public ArrayList<Movie> getCurrentMovie() {
		System.out.println("SERVICE - getCurrentMovie()호출");	
				
		ArrayList<Movie> mvCurrentList = mvdao.selectCurrentMovie_Mapper();		
		
		int totalCount = 0;

		for(Movie mov : mvCurrentList) {

			totalCount += Integer.parseInt(mov.getRecount());

			String movGrade = mov.getMvinfo();
			
			//movGrade=movGrade.split(",")[0].substring(0,2);
			movGrade=movGrade.split(",")[0];
			System.out.println("movGrade: "+movGrade);
			
			if(movGrade.equals("전체관람가")) {
				movGrade="All";
			}
			else if(movGrade.equals("청소년관람불가")) {
				movGrade="18";	
			}
			else if(movGrade.equals("15세이상관람가")) {
				movGrade="15";
			}
			else {
				movGrade="12";
			}
			mov.setMvstate(movGrade);
			
		}
		
		for(Movie mov : mvCurrentList) {
			int recount = Integer.parseInt(mov.getRecount());
			
			double reRate = ((double) recount/totalCount) * 100;
			
			String recount_str = (Math.round(reRate*100)/100.0)+"";
			mov.setRecount(recount_str);
		}
		
		
				return mvCurrentList;
	}

	public ArrayList<Movie> getMovieList(String selThcode) {
		ArrayList<Movie> mvCurrentList = mvdao.selectMovieList_json_Mapper(selThcode);		

		for(Movie mov : mvCurrentList) {
			String movGrade = mov.getMvinfo();
			
			//movGrade=movGrade.split(",")[0].substring(0,2);
			movGrade=movGrade.split(",")[0];
			System.out.println("movGrade: "+movGrade);
			
			if(movGrade.equals("전체관람가")) {
				movGrade="All";
			}
			else if(movGrade.equals("청소년관람불가")) {
				movGrade="18";	
			}
			else if(movGrade.equals("15세이상관람가")) {
				movGrade="15";
			}
			else {
				movGrade="12";
			}
			mov.setMvstate(movGrade);
		}
		return mvCurrentList;
	}

	public String registReserveInfo(Reserve reinfo) {
		System.out.println("SERVICE - registReserveInfo() 호출");
		
		// 1. 예매코드 생성
		
		
		String maxRecode = mvdao.selectMaxRecode();
		
		String recode = genCode(maxRecode);
		
		reinfo.setRecode(recode);
		
		// 2. DAO - insert 

		
		int insertReult = 0;
		
		try {
			
			insertReult = mvdao.insertReserve(reinfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(insertReult > 0)
		{
			return recode;
		}
		else {
			return null;
		}
		

	}

	private String genCode(String currentCode) {
		System.out.println("genCode() 호출 "+currentCode);
		//currentCode = mv00000
		String strCode = currentCode.substring(0,2);
//		System.out.println("strCode: "+strCode);
		int numCode = Integer.parseInt(currentCode.substring(2));
//		System.out.println("numCode: "+numCode);
		//newCode = mv00001
		String newCode = strCode+String.format("%05d",numCode+1);
		return newCode;
		}

	public ArrayList<HashMap<String, String>> getReviewList(String mvcode) {
		System.out.println("SERVICE - getReviewList() 호출");
		
		return mvdao.selectReviewList(mvcode);
	}
	
	}

