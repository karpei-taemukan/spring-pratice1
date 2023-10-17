package com.MovieProject.Dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.Dto.Member;
import com.MovieProject.Dto.Reserve;

public interface MemberDao {

	Member selectLoginMember_kakao(String id);

	int insetMember_kakao(Member member);

	int insertJoinMember(Member member);

	Member selectMemberLoginInfo(@Param("userId") String userId, @Param("userPw") String userPw);

	String selectId(String inputId);

	ArrayList<HashMap<String, String>> selectReserveList(String loginId);

	int deleteReserve(@Param("recode") String recode, @Param("loginId") String loginId);

	int deleteKakao_pay(@Param("reInfo") Reserve reInfo, @Param("loginMemberId") String loginMemberId);

	String selectReviewCode(String recode);

	String selectMaxRecode();

	int insertReview(@Param("rvcode") String rvcode, @Param("loginId") String loginId, @Param("recode") String recode, @Param("rvcomment") String rvcomment);

	int deleteComment(String rvcode);

	


}
