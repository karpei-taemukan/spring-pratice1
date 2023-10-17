package com.MovieProject.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.MovieProject.Dao.MemberDao;
import com.MovieProject.Dto.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memdao;
	
	public Member getLoginMemberInfo_kakao(String id) {
		System.out.println("SERVICE - getLoginMemberInfo_kakao()호출");
		Member loginMember_kakao = memdao.selectLoginMember_kakao(id);
		
		return loginMember_kakao;
	}

	public int regusterMember_kakao(Member member) {
		System.out.println("SERVICE - regusterMember_kakao()호출");
		return memdao.insetMember_kakao(member);
	}

	public int joinMember(Member mem, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("SERVICE-joinMember() 호출");
		
		MultipartFile mfile = mem.getMfile();
		String mprofile = "";
		String savePath = session.getServletContext().getRealPath("/resources/users/memberProfile");
		
		if(!mfile.isEmpty()){
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			mprofile = code + "_" +mfile.getOriginalFilename();
			File newFile = new File(savePath, mprofile);
			mfile.transferTo(newFile);
		}
		mem.setMprofile(mprofile);
		int joinMember = 0;
		try {
		joinMember=memdao.insertJoinMember(mem);
		} catch (Exception e) {
			e.printStackTrace();		}
	
		return joinMember;
	}

	public Member getLoginMemberInfo(String userId, String userPw) {
		System.out.println("SERVICE - getLoginMemberInfo()호출");
		
		Member loginMember = memdao.selectMemberLoginInfo(userId, userPw);
		
		return loginMember;
	}

	public String memberIdCheck(String inputId) {
		System.out.println("SERVICE - memberIdCheck()호출");
//		String result = memdao.selectId(inputId);
//		
//		if(result == null) {
//			return "Y";
//		}
//		else {
//			return "N";
//		}
		
		return memdao.selectId(inputId);
	}

	public ArrayList<HashMap<String, String>> getReserveList(String loginId) {
		System.out.println("SERVICE - getReserveList()호출");
		
		
		ArrayList<HashMap<String,String>> reList = memdao.selectReserveList(loginId);
		
		System.out.println("reList: "+reList);
		
		for(HashMap<String,String> re : reList) {
			String recode = re.get("RECODE");
			System.out.println("recode: "+recode);
			String rvcode = memdao.selectReviewCode(recode);
			
			re.put("rvcode", rvcode);
		}
		
		return reList;
	}

	public int deleteReserve(String recode, String loginId) {
	System.out.println("SERVICE - deleteReserve()호출");
		
		return memdao.deleteReserve(recode, loginId);
	}

	public int getReview(String loginId, String recode, String rvcomment) {
		System.out.println("SERVICE - getReview() 호출");
		String maxRvcode = memdao.selectMaxRecode();
		
		String rvcode = genCode(maxRvcode);
		
		
		return memdao.insertReview(rvcode,loginId, recode, rvcomment);
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

	public int deleteComment(String rvcode) {
		System.out.println("SERVICE - deleteComment()호출");
		
		int commentDelete = 0;
		
		try {
			commentDelete = memdao.deleteComment(rvcode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return commentDelete;
	}
	

}
