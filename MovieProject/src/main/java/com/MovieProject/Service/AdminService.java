package com.MovieProject.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.AdminDao;
import com.MovieProject.Dto.Movie;
import com.MovieProject.Dto.Schedule;
import com.MovieProject.Dto.Theater;

@Service
public class AdminService {

	@Autowired
	private AdminDao adminDao;
	
	public int addCgvMovie() throws IOException {
		System.out.println("SERVICE - addCgvMovie 호출");
		// cgv 영화정보 수집 
		// Jsoup 사용
		// 무비차트에 접속 -> 영화 상세페이지 url 받기
		// 영화 상세페이지 접속 -> 영화상세 정보 수집 
		
		String cgvUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0";
		Document cgvRankDoc = Jsoup.connect(cgvUrl).get();
		
		Elements urlItems = cgvRankDoc.select("div.box-contents>a");
		//System.out.println(urlItems);

		
		ArrayList<Movie> movieList = new ArrayList<Movie>();
		
		
		for(Element urlItem : urlItems) {
			String detailUrl = "http://www.cgv.co.kr"+urlItem.attr("href");
			//System.out.println(detailUrl);
			Movie movie = new Movie();

		Document detailDoc = Jsoup.connect(detailUrl).get();	
		String mvtitle = detailDoc.select("#select_main > div.sect-base-movie > div.box-contents > div.title > strong").text();
		System.out.println("영화 제목: " + mvtitle);
		movie.setMvtitle(mvtitle);

		String mvdirector=detailDoc.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd:nth-child(2) > a").text();
		mvdirector=mvdirector.replace(" , ", ",");
		System.out.println("영화감독: "+mvdirector);
		movie.setMvdirector(mvdirector);
		
		String mvactors = detailDoc.select("dd.on").get(0).text();
		// 추가정보로 인해 nth-child()의 순서가 흐트러져서 못씀 
		// => dd태그중 on클래스인 것들 중에 첫번째 인덱스 선택 
		mvactors=mvactors.replace(" , ", ",");
		System.out.println("영화배우들: "+mvactors);
		movie.setMvactors(mvactors);
		
		String mvgenre = detailDoc.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0).nextElementSibling().text();
		mvgenre=mvgenre.replace("장르 : ","").replace(", ", ",").trim();
		System.out.println("영화 장르: "+mvgenre);
		movie.setMvgenre(mvgenre);
		
		String mvinfo = detailDoc.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(1).text();
		mvinfo=mvinfo.replace(", ", ",");
		System.out.println("영화 정보: "+mvinfo);
		movie.setMvinfo(mvinfo);

		String mvopendate = detailDoc.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(2).text();
		System.out.println("영화 개봉일: "+ mvopendate);
		movie.setMvopendate(mvopendate);
		
		String mvposter = detailDoc.select("#select_main > div.sect-base-movie > div.box-image > a > span > img").attr("src");
		System.out.println("영화 포스터: "+ mvposter);
		movie.setMvposter(mvposter);
		movieList.add(movie);
		}
		
		
		// DB - movies 테이블 insert
		// movies 테이블 mvcode 최대값 조회 
		String maxMvcode = adminDao.selectMaxMvCode();
		
		System.out.println("maxMvCode: "+ maxMvcode);// mv00000
		
		int insertCount=0;
		
		// 크롤링한 영화 목록에다 각각의 mvcode를 붙이기 위한 코드 
		//==> mvcode를 각각 구별해주려면 번호를 붙이면 된다 (mvcode 최댓값을 조회해서 조회한 mvcode 최댓값에 1을 더한다)
		for(Movie mov : movieList) {
			// 영화 코드 생성
			String mvcode = genCode(maxMvcode);// mv00001
			System.out.println("mvcode: "+mvcode);// mv00002
			
			mov.setMvcode(mvcode);
			System.out.println(mov);
			// movies 테이블 insert
		try {
			int insertResult = adminDao.insetMovie(mov);
			
			insertCount+=insertResult;
			
			maxMvcode=mvcode;
		} catch (Exception e) {
			continue; //중복 영화일 경우 다음으로 넘김 
		}
		}
		
		return insertCount;
	}

/*===============================================================================================================================*/
// 코드 생성 메소드 	
	private String genCode(String currentCode) {
	System.out.println("genCode() 호출 "+currentCode);
	//currentCode = mv00000
	String strCode = currentCode.substring(0,2);
//	System.out.println("strCode: "+strCode);
	int numCode = Integer.parseInt(currentCode.substring(2));
//	System.out.println("numCode: "+numCode);
	//newCode = mv00001
	String newCode = strCode+String.format("%05d",numCode+1);
	return newCode;
	}
	
	
/*===============================================================================================================================*/

	private ArrayList<String> getCgvTheaterUrls() {
		System.out.println("SERVICE - getCgvTheaterUrls 호출");
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL); // 페이지 데이터가 로드될때까지 대기
		options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		
		String cgvTheaterUrl="http://www.cgv.co.kr/theaters/";
		driver.get(cgvTheaterUrl);
		
		List<WebElement> theaterElements=driver.findElements(By.cssSelector("div.sect-city > ul > li > div.area > ul > li > a"));
		
		//System.out.println("theaterElements.size(): "+theaterElements.size());
		
		ArrayList<String> thUrls = new ArrayList<String>();
		
		
		for(WebElement theaterElement : theaterElements) {
			String thUrl = theaterElement.getAttribute("href"); 
			//  열려있는 브라우저(Chrome 아님) a태그 href 속성 데이터 
		//	System.out.println("theaterElement: "+theaterElement);
		thUrls.add(thUrl);
		}
	
//		for(String url : thUrls) {
//		driver.get(url);
//		}
		
		driver.quit();
		return thUrls;
	}

	public int addCgvTheaters() {
		System.out.println("SERVICE - addCgvTheaters 호출");
		// 극장 페이지 URL 수집 기능 호출 
		ArrayList<String> theaterUrls = getCgvTheaterUrls();
		System.out.println(theaterUrls.size());
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL); // 페이지 데이터가 로드될때까지 대기
		//options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);


		ArrayList<Theater> thList = new ArrayList<Theater>();
	
		for (String url : theaterUrls) {
			driver.get(url);			
			Theater theater = new Theater();
	
			try {
				WebElement titleElement = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"));				
				String thname = titleElement.getText();
				System.out.println("극장: "+thname);
				theater.setThname(thname);
				
				WebElement addrElement = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > strong"));
				String thaddr = addrElement.getText();
				thaddr = thaddr.replace("위치/주차 안내 >","");
				//서울특별시 강남구 역삼동 814-6 스타플렉스\n서울특별시 강남구 강남대로 438 (역삼동)
				thaddr=thaddr.split("\n")[0];
				System.out.println("주소: "+thaddr);
				theater.setThaddr(thaddr);
				
				
				WebElement telElement = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(1)"));
				String thtel = telElement.getText();
				System.out.println("전화번호: "+thtel);
				theater.setThtel(thtel);
				
				WebElement infoElement = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(2)"));
				String thinfo = infoElement.getText();
				System.out.println("전화번호: "+thinfo);
				theater.setThinfo(thinfo);
				
				WebElement imgElement = driver.findElement(By.cssSelector("#theater_img_container > img"));
				String thimg = imgElement.getAttribute("src");
				System.out.println("이미지: "+thimg);
				theater.setThimg(thimg);
				
				
				thList.add(theater);
			
			} catch (NoSuchElementException e) {
				continue;
			}
		}

		
		// DB - theaters 테이블 insert
		// theaters 테이블 thcode 최대값 조회 
		
		String maxThcode = adminDao.selectMaxThCode();
		
	//	System.out.println("maxThcode: "+maxThcode);
		int insertCount=0;
		for(Theater th : thList) {
			String thcode = genCode(maxThcode);
			th.setThcode(thcode);
			try {
				int insertResult = adminDao.insertTheater(th);
				
				insertCount+=insertResult;
				maxThcode=thcode; // 최댓값 갱신
			} catch (Exception e) {
				continue;
			}
		}
		driver.quit();
		
		return insertCount;
	}

	public int addCgvSchedule() {
		System.out.println("SERVICE - addCgvSchedule 호출");
		// 극장 페이지 URL 수집 기능 호출 
		ArrayList<String> theaterUrls = getCgvTheaterUrls();
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
		//options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);
		
		
		ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
		
		
		for(String thurl : theaterUrls) {	/*극장 페이지 접속 for 시작*/
			
	
			
			driver.get(thurl);
			try { // 극장별 스케쥴 수집 try 시작
		
				String thname = driver.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span")).getText();
				//System.out.println("극장이름: "+thname);
				
				driver.switchTo().frame(driver.findElement(By.id("ifrm_movie_time_table"))); 
				// iframe(<html>안에 있는 <html>)을 선택하기 위함
				
				// 예약가능 날짜 목록 수집 
				List<WebElement> dayList  = driver.findElements(By.cssSelector("#slider > div:nth-child(1) > ul > li"));
				//System.out.println(dayList.size());
				
				
			for(int i=0; i<dayList.size(); i++) { // 상영스케쥴 for 시작
				//System.out.println(day);
				if(i>0) {
					driver.findElement((By.cssSelector("#slider > div:nth-child(1) > ul > li.on+li")));
				}
				List<WebElement> showtimeList = driver.findElements(By.cssSelector("body > div > div.sect-showtimes > ul > li"));
				//	System.out.println("showtimes: "+showtimes.size());
				String mm = driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > span")).getText();
				mm=mm.replace("월", "");
				String dd= driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > strong")).getText();
			
			//	System.out.println(mm+dd);
				
				for(WebElement showtime : showtimeList) { // 날짜별 스케쥴 for 시작
					// 애매 가능한 영화 제목 
					String mvtitle = showtime.findElement(By.cssSelector("div > div.info-movie > a > strong")).getText();
//					System.out.println("영화 제목: "+mvtitle);
	
					//애매 가능한 상영관 
					List<WebElement> typeHalls = showtime.findElements(By.cssSelector("div.col-times>div.type-hall"));
//					System.out.println(typeHalls.size());
					for(WebElement hall : typeHalls) {
						
						// 애매 가능한 시간 
						String hallName = hall.findElement(By.cssSelector("div.info-hall > ul > li:nth-child(2)")).getText();
						//System.out.println("상영관: "+hallName);
						List<WebElement> timeList = hall.findElements(By.cssSelector("div.info-timetable > ul > li > a > em"));
						for(WebElement time : timeList) {
							
							Schedule schedule = new Schedule();
							
							// 애매 가능한 시간 
							String hallTime = time.getText();
							//System.out.println("애매 가능 시간: "+hallTime);
							
							//System.out.println(thname+" : "+mm+dd+" : "+mvtitle+" : "+hallName+" : "+hallTime);
						
						schedule.setMvcode(mvtitle);
						schedule.setThcode(thname);
						schedule.setSchall(hallName);
						schedule.setScdate("2023"+mm+dd+" "+hallTime);
						
						scheduleList.add(schedule);
						}
					}

				}// 날짜별 스케쥴 for 끝
				
				driver.findElement(By.cssSelector("#slider > div.item-wrap.on > ul > li.on+li")).click();
			} // 상영스케쥴 for 끝
				
			
			} // 극장별 스케쥴 수집 try 끝
			catch (Exception e) {
				continue;
			}
		} 	/*극장 페이지 접속 for 끝*/
		
		System.out.println(scheduleList.size());
		
		
		//insert
		int insertCount = 0;
	
		for(Schedule sc : scheduleList) {
			try {
				int insertResult = adminDao.insertSchedule(sc);
	
				insertCount += insertResult;
			} catch (Exception e) {
				continue;
			}
		}
		
		driver.quit();
		return insertCount;
	}

	public void mapperTest_movie(String thcode) {
		System.out.println("service");
		ArrayList<Movie> movList = adminDao.selectMapper_test(thcode);
		System.out.println("극장 선택일 경우 "+movList.size());
		
		
		ArrayList<Movie> movList2 = adminDao.selectMapper_test(null);
		System.out.println("극장 선택 아닌 경우 "+movList2.size());
	}
	
	
}
