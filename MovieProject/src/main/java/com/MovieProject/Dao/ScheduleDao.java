package com.MovieProject.Dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.Dto.Schedule;

public interface ScheduleDao {

	ArrayList<Schedule> selectDateList(@Param("mvcode") String mvcode, @Param("thcode") String thcode);

	ArrayList<Schedule> selctTimeList(@Param("mvScode") String mvScode, @Param("thScode") String thScode, @Param("scSdate") String scSdate);

}
