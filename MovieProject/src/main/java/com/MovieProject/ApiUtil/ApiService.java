package com.MovieProject.ApiUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.MemberDao;
import com.MovieProject.Dto.Reserve;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class ApiService {

	public String kakaoPay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("SERVICE - kakaoPay_ready 호출");

		String requestUrl = "https://kapi.kakao.com/v1/payment/ready";
		
		/*
		 partner_order_id	가맹점 주문번호, 최대 100자  // RE00000
	     partner_user_id  	가맹점 회원 id, 최대 100자	// "TESTID"
	     item_name			상품명, 최대 100자		// 영화 예매 결제
	     quantity			상품 수량			1
	     total_amount		상품 총액			12000
	     tax_free_amount	상품 비과세 금액		0
	     approval_url		결제 성공 시 redirect url, 최대 255자   "http://localhost:8082/MovieProjectController/kakaoPay_approval"
	     cancel_url			결제 취소 시 redirect url, 최대 255자		"http://localhost:8082/MovieProjectController/kakaoPay_cancel"
	     fail_url			결제 실패 시 redirect url, 최대 255자		"http://localhost:8082/MovieProjectController/kakaoPay_fail"
		 */
		
	
		 HashMap<String, String> reqParams = new HashMap<String, String>();
		reqParams.put("partner_order_id", reInfo.getRecode()); 
		reqParams.put("partner_user_id", (String) session.getAttribute("loginMemberId"));  // "TESTID"
		reqParams.put("item_name", "영화예매결제"); 
		reqParams.put("quantity", "1"); 
		reqParams.put("total_amount", "12000"); 
		reqParams.put("tax_free_amount", "0"); 
		reqParams.put("approval_url", "http://localhost:8082/MovieProjectController/kakaoPay_approval"); 
		reqParams.put("cancel_url", "http://localhost:8082/MovieProjectController/kakaoPay_cancel"); 
		reqParams.put("fail_url", "http://localhost:8082/MovieProjectController/kakaoPay_fail"); 
		
		
		String result = null;
		try {
		String response = kakaoResponse_json(requestUrl,reqParams);
		
		
		
		//	tid
		//	next_redirect_pc_url
	
		
		
		JsonObject re = (JsonObject) JsonParser.parseString(response);
		String tid = re.get("tid").getAsString();
		String nextUrl = re.get("next_redirect_pc_url").getAsString();
		
		System.out.println("tid: "+tid);
		session.setAttribute("tid", tid);
		session.setAttribute("recode",  reInfo.getRecode());
		System.out.println("next_redirect_pc_url: "+ nextUrl);
		result=nextUrl;
		
		}
		catch (IOException e){
			e.printStackTrace();
		}
		return result; // 결제 QR 페이지 URL 반환
	}
	
	
	
	private String kakaoResponse_json(String requestUrl, HashMap<String, String> reqParams) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(requestUrl); /*URL 만들기*/
		   
		urlBuilder.append("?" + URLEncoder.encode("cid","UTF-8") + "=TC0ONETIME"); /*Service Key*/
		
		
		for(String key : reqParams.keySet()) { // .keySet() 키들만으로 구성된 객체를 반환 
urlBuilder.append("&" + URLEncoder.encode(key,"UTF-8") + "=" + URLEncoder.encode(reqParams.get(key), "UTF-8")); /*페이지번호*/
		}
	
	    URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Authorization", "KakaoAK 6366f5d9986ddd82249be98fa04f9524");
	    conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	   
	    
	    
	    System.out.println("Response code: " + conn.getResponseCode());
	    if(conn.getResponseCode() != 200){
	    	return null;
	    }
	    
	    
	    
	    
	    BufferedReader rd;
	    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    } else {
	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	    }
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	        sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();
	    System.out.println(sb.toString());
		return sb.toString();
	}

	public String kakaoPay_approval(String tid, String recode, String loginMemberId, String pg_token) {
		System.out.println("SERVICE - kakaoPay_approval 호출");
		
		String requestUrl= "https://kapi.kakao.com/v1/payment/approve";
		
		 HashMap<String, String> reqParams = new HashMap<String, String>();
			reqParams.put("tid", tid); 
			reqParams.put("partner_order_id", recode); 
			reqParams.put("partner_user_id", loginMemberId); 
			reqParams.put("pg_token", pg_token); 
			
			
			String result = null;
			
		try {
			String response = kakaoResponse_json(requestUrl, reqParams);
			result = response; // -> 데이터 활용시 밑에 있는 과정을 거쳐서 컨트롤러로 가던 DAO로 가던지 한다 
			/*
			 * 
		JsonObject re = (JsonObject) JsonParser.parseString(response);
		String tid = re.get("tid").getAsString();
		String nextUrl = re.get("next_redirect_pc_url").getAsString();
		
		System.out.println("tid: "+tid);
		session.setAttribute("tid", tid);
		System.out.println("next_redirect_pc_url: "+ nextUrl);
			 * */
		} catch (IOException e) {
			e.printStackTrace();
		}	
		
		return result;
	}

	
	
	@Autowired
	private MemberDao memdao;
	
	public int kakaoPay_cancel(Reserve reInfo, String loginMemberId) {
		System.out.println("SERVICE - kakaoPay_cancel - 호출");
		int deleteResult =  memdao.deleteKakao_pay(reInfo, loginMemberId);
		return deleteResult;
	}



	

}
