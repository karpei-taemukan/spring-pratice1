package com.MovieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.TheaterDao;
import com.MovieProject.Dto.Theater;

@Service
public class TheaterService {

	@Autowired
	private TheaterDao thDao;
	
	public ArrayList<Theater> getTheaterList(String selMvcode) {
		System.out.println("SERVICE - getCurrentTheater");
		ArrayList<Theater> thList = thDao.selectTheaterList(selMvcode);
		return thList;
	}

}
