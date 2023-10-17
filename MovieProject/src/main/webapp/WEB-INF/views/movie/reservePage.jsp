<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Movie reservation project</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="resources/users/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/users/css/styles.css" rel="stylesheet" />
        <!--  <link href="${pageContext.request.contextPath}/resources/users/css/styles.css" rel="stylesheet" />  -->
  <style>
  .selectList{
  cursor: pointer;
  border: 1px solid black;
  border-radius: 10px;
  margin-bottom: 3px;
  margin-top: 3px;
  padding: 3px;
  }
  .selectList:hover{
  background-color: green;
  }
  .selectObj{
  background-color: yellow !important;
  }
  
  .rankMov{
background-color: red;
margin-bottom: 5px;
border-radius: 5px;
text-align: center;
color: white;
font-size: 18px;
font-weight: 500;
}
.selectArea{
  height: 400px;
  overflow: scroll;
}
.selMoviePoster{

max-width:70%; height: auto; border-radius:10px;
}


.unselectList{
  cursor: pointer;
  border: 1px solid gray;
  border-radius: 10px;
  margin-bottom: 3px;
  margin-top: 3px;
  padding: 3px;
  color:gray;
  opacity: 0.3
}

.selEl{
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;   /*가려지는 텍스트 표현 형식*/
}
  </style>
  
    </head>
    <body>

        <!-- 메뉴 시작   -->
        
      <%@include file="/WEB-INF/views/includes/menu.jsp" %>
        
       <!-- 메뉴 끝 -->
       
       
       
       
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">영화 예매 페이지</h1>
                    <p class="lead mb-0">영화, 극장, 날짜 선택 및 결제 페이지</p>
                </div>
            </div>
        </header>
        
        
        
        
        <!-- Page content-->
        <div class="container">
        
        <div class="row">
        <div class="col-lg-3 col-md-6 p-1">
			 <div class="card mb-4">
			 	<div class="card-body p-2 selectArea" id="movArea">	
			 	<c:forEach items="${mvList}" var="mv">
			 	<div class="selectList selEl" id="${mv.mvcode}" onclick="movieClick(this, '${mv.mvcode}', '${mv.mvposter}')" tabindex="0">${mv.mvtitle}</div>
			 	</c:forEach>
			 	</div>
			 </div>
        </div>
          <div class="col-lg-3 col-md-6 p-1">
 			<div class="card mb-4">
			  	<div class="card-body p-2 selectArea" id="thArea">	
			 
			  	<c:forEach items="${thList}" var="th">
				 	<div class="selectList selEl" id="${th.thcode}" onclick="theaterClick(this,'${th.thcode}')">${th.thname}</div>
			 	 	</c:forEach>
			 	 	<!--
			 	 	
			 	 <img class="card-img-top" src="${th.thimg}" alt="..." />
                   <span>${th.thname }</span>
			 	 	 -->
			 	 
			 	</div>
			 </div>
        </div>
          <div class="col-lg-3 col-md-6 p-1">
 			<div class="card mb-4">
			  	<div class="card-body p-2" id="dateArea">	
			 	 	
			 	</div>
			 </div>
        </div>
          <div class="col-lg-3 col-md-6 p-1">
 			<div class="card mb-4">
			  	<div class="card-body p-2" id="timeArea">	

			 	</div>
			 </div>
        </div>
        </div>
        
       <div class="row">
       	<div class="col-lg-4">
       	
       <div class="card mb-4">
			 	<div class="card-body p-2"> 
			 	
			 	<p class="card-text" id="selTitle">영화 제목</p>
			 	<img class="selMoviePoster" id="selPoster" alt="" src="data:image/jpeg;base64,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" />
			 	
			 	</div>
			 </div>
			 
       	</div>
     <div class="col-lg-5">
       	    <div class="card mb-4">
			 	<div class="card-body p-2">	
			 	<p class="p-2 m-1 w-100">극장<span class="selInfo mx-3" id="selTheater">극장이름</span></p>
			 		<p class="p-2 m-1 w-100">일시<span class="selInfo mx-3" id="selDate">날짜</span><span id="selTime">시간</span></p>
			 			<p class="p-2 m-1 w-100">상영관<span class="selInfo mx-3" id="selHall"></span></p>
			 			<p class="p-2 m-1 w-100">좌석<span class="selInfo mx-3" id="selSeat"></span></p>
			 	</div>
			 </div>
       	</div>
     <div class="col-lg-3">
           <div class="card mb-4">
			 	<div class="card-body p-2">	
			 		<button class="btn btn-danger w-100 p-5 reserveBtn" onclick="movieReserve()">예매하기</button>
			 	</div>
			 </div>
       	</div>
       	
       	
       </div>
        
          </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
    </body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>

let reserve_mvcode = null; // 선택한 영화 코드 저징 

let reserve_thcode = null; // 선택한 극장 코드 저장 

let reserve_scdate = null; // 선택한 날짜 저장 => 2023-09-14

let reserve_sctime = null; // 선택한 시간 저장 => 13:20

let reserve_schall = null; // 선택한 상영관 저장 => 2관 B3층

let reserve_thname = null;

function resetSelectInfo(sel){
	// 선택 정보 초기화

	// 페이지: 시간 상영관 초기화 
	
	 document.querySelector("#selTime").innerText  = "";
	 document.querySelector("#selHall").innerText  = "";
     document.querySelector("#timeArea").innerHTML = "";
	 
	 // 시간 상영관 목록 초기화 
	 
	 
	// 변수초기화
	reserve_sctime = null; 
	 reserve_schall = null;
	 
	 
	 
	 
	if(sel){
		// 페이지 : 날짜 초기화
		// 변수 : reserve_scdate 초기화
		 document.querySelector("#selDate").innerText  = "";
		reserve_scdate = null;
	}
	
	
}

function movieClick(selectMVObj, mvcode, mvposter){
	console.log("movieClick 호출")
//	console.log(selectMVObj) // 스타일 변경 
//	console.log("선택한 영화 코드: "+selectMVObj.innerText) // 극장 목록 조회
//	console.log("선택한 영화 제목: "+mvcode) // 선택항목 출력
//	console.log("선낵한 영화 포스터: "+mvposter) // 선택항목 출력
	
	//reserve_mvcode = mvcode; 
	//-> 여기에 작성하면 blur 처리된 영화를 클릭했을 때 reserve_mvcode에  클릭한 영화가 저장 
	// 그러나 화면상으로는 그전에 클릭한 선택가능한 영화가 선택되어있다
	
	
	if(selectMVObj.classList.contains("unselectList")){
		console.log("예매가 불가한 영화 선택")
		 let reloadCheck = confirm('선택한 극장에 원하는 상영스케쥴은 없다 \n 계속?')
			 if(reloadCheck){
				 location.reload();
			 }
	}else{
//		let timeArea = document.querySelector("#timeArea");
//		timeArea.innerHTML = "";
	
	resetSelectInfo(true);
	
	reserve_mvcode = mvcode;
	
	// 1. 선택 항목 출력 
	document.querySelector("#selTitle").innerText = selectMVObj.innerText
	document.querySelector("#selPoster").setAttribute("src", mvposter)
	
	// 2. 선택 항목 스타일 변경
	addSelectStyle(selectMVObj);
	
	
	// 3. 선택환 영화를 예매할 수 있는 극장 목록
	
	let thList = getReserveTheaterList(mvcode);
	//console.log(thList.length)
	changeTheaterList(thList);
	 
	// 4. 영화 와 극장이 모두 선택이 되어있으면 날짜 목록 조회 출력
	
		if(reserve_mvcode != null && reserve_thcode != null){
//	console.log("선택한 영화코드: "+ reserve_mvcode)
//	console.log("선택한 극장코드: "+ reserve_thcode)
//	console.log("예매가능한 날짜 목록 조회")

	getReserveScheduleDateList();
	}
	}
	
}

</script>

<script>
function getReserveTheaterList(selectMovieCode){
	console.log("예매가능한 극장 목록 조회")
	
	let theaterList = [];
	
	$.ajax({
	type: "get",
	url: "theaterList_json",
	data:{
		"selMvcode": selectMovieCode
	},
	async: false,
	dataType: "json",
	success:function(result){
		//console.log(result)
	theaterList = result;

	},
	error:function(request, status, error){

		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	}
	})
	return theaterList;
}
</script>

<script>
function changeTheaterList(thList){
	console.log("changeTheaterList() 호출")
	//console.log(thList)
	
	let thcodeList = [];
	
	for(let th of thList){
		thcodeList.push(th.thcode);
	}
	
//	console.log(thcodeList)
	
	let theaterEls = document.querySelectorAll("#thArea>div.selEl");
	
	let thArea = document.querySelector("#thArea");
	
	for(let thEl of theaterEls){
		thEl.classList.remove("unselectList")
		thEl.classList.remove("selectList")
		if(thcodeList.includes(thEl.getAttribute('id'))){
		//	console.log("예매가능한 극장")
			thEl.classList.add("selectList")
		}
		else{
		//	console.log("예매 불가한 극장")
			thEl.classList.add("unselectList")
			thArea.appendChild(thEl)
		}
	}
	
}

function addSelectStyle(selectMVObj){
//	console.log(selectMVObj.parentElement)
	let movDiv = selectMVObj.parentElement.querySelectorAll(".selEl");

	for(let el of movDiv){
	el.classList.remove("selectObj")
	}
		selectMVObj.classList.add("selectObj");

	}
</script>

<script>
function theaterClick(selectTHObj, thcode){
	console.log("theaterClick 호출")
	//console.log(selectTHObj)	
	console.log("선택한 극장 코드: ", thcode)
	
	let selTheater = document.querySelector("#selTheater");
	selTheater.innerText = selectTHObj.innerText
	reserve_thname = selectTHObj.innerText
	// 영화 목록을 클릭하면 
	// 예매가능한 극장 목록 예매불가한 극장 목록이 둘다 존재
	if(selectTHObj.classList.contains("unselectList")){
		console.log("예매가 불가한 극장 선택")
		
		let reloadCheck = confirm('선택한 극장에 원하는 상영스케쥴은 없다 \n 계속?')
		if(reloadCheck){
			location.reload() //  새로 고침
		}
	}
	else{	
//		let timeArea = document.querySelector("#timeArea");
//	timeArea.innerHTML = "";
	resetSelectInfo(true);
		reserve_thcode=thcode
		console.log("예매가 가능한 극장 선택")
	// 1. 선택 항목 출력 
	// 2. 선택 항목스타일 변경
		addSelectStyle(selectTHObj)
	// 3. 선택한 극장에서 예매할 수 있는 영화 목록 조회
	
		let mvList = getReserveMovieList(thcode);
		console.log("mvList",mvList)
		changeMovieList(mvList);
		
		// 4. 영화 와 극장이 모두 선택이 되어있으면 날짜 목록 조회 출력
		

			if(reserve_mvcode != null && reserve_thcode != null){
	//	console.log("선택한 영화코드: "+ reserve_mvcode)
	//	console.log("선택한 극장코드: "+ reserve_thcode)
	//	console.log("예매가능한 날짜 목록 조회")
			getReserveScheduleDateList();
		}
	}
	
}
</script>


<script>
function getReserveMovieList(thcode){
	console.log("getReserveMovieList 호출")
	//console.log(thcode)
	
	let mvList = [];
	
	$.ajax({
		type: "get",
		url: "movieList_json",
		data:{
			"selThcode": thcode
		},
		async: false,
		dataType: "json",
		success:function(result){
			//console.log(result)
		mvList = result;

		},
	
		error:function(request, status, error){

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
		})
	
	return mvList;
}
</script>

<script>
function changeMovieList(mvList){
	console.log("changeMovieList 호출")
//console.log("mvList",mvList)
	
	let mvcodeList = []; 
	
	for(let mv of mvList){
		mvcodeList.push(mv.mvcode)
	}
	
//	console.log("mvcodeList",mvcodeList)
	
	let mvEls = document.querySelectorAll("#movArea>div.selEl");
	//console.log(mvEls);
	let mvArea = document.querySelector("#movArea");
	
	for(let mvEl of mvEls){
	//	console.log(mvEl)
		mvEl.classList.remove("unselectList")
		mvEl.classList.remove("selectList")
		
		if(mvcodeList.includes(mvEl.getAttribute("id"))){
			//console.log("예매가능한 영화 목록")
			mvEl.classList.add("selectList")
		}
		else {
			//console.log("예매 불가한 영화 목록")
	
			mvEl.classList.add("unselectList")
			mvArea.appendChild(mvEl)

	}
		
	
		
	}
	
	
}
</script>


<script>
function getReserveScheduleDateList(){
	console.log("예매가능한 날짜 목록 조회 요청")
	console.log("선택한 영화 코드: "+reserve_mvcode)
		console.log("선택한 극장 코드: "+reserve_thcode)
		
		let selDate = document.querySelector("#selDate");
	selDate.innerText = "";
		
		
		$.ajax({
		type: "get",
		url: "getScheduleDateList_json",
		data: {
			"mvcode" : reserve_mvcode,
			"thcode" : reserve_thcode
		},
		async: false,
		dataType: "json",
		success: function(result){
		console.log(result)	
		printScheduleDate(result)
		},
		error:function(request, status, error){

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
		})
}


function printScheduleDate(date){
let dateArea = document.querySelector("#dateArea");
dateArea.innerHTML="";

let nowMM = null; // 월(month) 츨력 

for(let sc of date){
let dateArr = sc.scdate.split("-")


if(nowMM != dateArr[1]){ // 월마다 출력가능 
	nowMM = dateArr[1]
	let mmDiv = document.createElement("div");
	mmDiv.innerText = dateArr[1] + "월";
	mmDiv.classList.add("text-center");
	dateArea.appendChild(mmDiv);
}

let dateDiv = document.createElement("div");
dateDiv.classList.add("selectList");
dateDiv.classList.add("selEl");
dateDiv.classList.add("text-center");
//dateDiv.innerText = (sc.scdate).split(" ")[0].split("2023-")[1];

dateDiv.innerText = dateArr[2] + "일";

dateDiv.addEventListener("click", function(e){
	console.log("날짜 선택: "+sc.scdate);
	
	resetSelectInfo(false);
	reserve_scdate = sc.scdate;
	// 1. 선택 항목 스타일 변경
	addSelectStyle(e.target);
	
	// 2. 선택 항목 출력
	document.querySelector("#selDate").innerText = dateArr[1]+"월"+dateArr[2]+"일";
	
	
	// 3. schedules schall, scdate ==> 선택한 영화 코드, 선택한 극장 코드, 선택한 날짜
	
	let scTimeList = getReserveScheduleTimeList(reserve_mvcode,reserve_thcode, sc.scdate);	
	
})


dateArea.appendChild(dateDiv);
}
}
</script>

<script>
function getReserveScheduleTimeList(mvcode, thcode, scdate){
	console.log(mvcode, thcode, scdate)
	
	$.ajax({
		type: "get",
		url: "getScheduleTimeList_json",
		data:{
			"mvScode":mvcode,
			"thScode":thcode,
			"scSdate":scdate
		},
		async: false, 
		dataType: "json",
		success: function(result){
			console.log(result)
			printScheduleTime(result)

		},

		error:function(request, status, error){

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
	})
}
</script>
<script>
function printScheduleTime(scList){
	console.log(scList)
		
	let timeArea = document.querySelector("#timeArea");
	timeArea.innerHTML = "";
	
	let nowHall = null;
	for(let sc of scList){
		// 상영관 출력
		if(nowHall != sc.schall){
			
			if(nowHall != null){
				let hr = document.createElement("hr");
				timeArea.appendChild(hr);	
			}
			nowHall = sc.schall
			
			let hallDiv =document.createElement("div");
			hallDiv.innerText = sc.schall;
			timeArea.appendChild(hallDiv);	
		}
		
		// 시간 출력
		let timeDiv = document.createElement("div");
		
		
		timeDiv.classList.add("selectList");
		timeDiv.classList.add("selEl");
		timeDiv.classList.add("text-center");
		timeDiv.classList.add("mx-1");
		timeDiv.classList.add("d-inline-block");
		timeDiv.innerText = sc.scdate;
		reserve_sctime = sc.scdate;
	
		timeDiv.addEventListener("click", function(e){
			addSelectStyle(e.target);
			let selHall = document.querySelector("#selHall");
			selHall.innerText = sc.schall;
			reserve_schall = sc.schall;
		    document.querySelector("#selTime").innerText = sc.scdate;
			
			//location.href="${pageContext.request.contextPath}/seat";
		})
		
				let seatBtn = document.createElement("button");
	//	seatBtn.setAttribute("href", "${pageContext.request.contextPath}/seat");
		//	if(reserve_mvcode!= null && reserve_thname!=null && reserve_schall != null && reserve_sctime != null){				
			seatBtn.setAttribute("onclick", "seatBtnClick()");
	//	seatBtnClick(reserve_mvcode,reserve_thname,reserve_schall,reserve_sctime);
			//}
			
		seatBtn.innerText = "좌석 예매";
		timeArea.appendChild(timeDiv);	
		timeArea.appendChild(seatBtn);	
	}
}
</script>



<script>
function movieReserve(){
	
	let loginCheck = '${sessionScope.loginMemberId}';
	//let loginCheck = '${sessionScope.loginId}'; 카카오 아이디 로그인
	if(loginCheck.length == 0){
		alert('로그인 이후 이용가능')
		location.href="${pageContext.request.contextPath}/memberLoginForm";
	}
	
	if(reserve_mvcode == null){
		alert("영화를 선택하라")
	}
	else if(reserve_thcode == null){
		alert("극장을 선택하라")
	}
	else if(reserve_scdate == null){
		alert("날짜를 선택하라")
	}
	else if(reserve_sctime == null || reserve_schall == null){
		alert("시간을 선택하라")
	}
	else{
		console.log("예매 처리 요청")
		/*console.log(reserve_mvcode)
		console.log(reserve_thcode)
		console.log(reserve_scdate)
		console.log(reserve_sctime)
		console.log(reserve_schall)
		*/
		
		
		// 1. 예매 INSERT function 호출  => 성공  
		registReserveInfo();
	// 2. 카카오 페이 API 결제 준비 요청 => 성공, 실패(INSERT 내역 삭제) 		
	}
}


function reserveResult_success(){
	// 예매 성공시 호출
	alert("예매 성공")
	location.href="${pageContext.request.contextPath}/";
}
</script>



<c:if test="${param.mvcode != null}">
<script> 
document.querySelector("#${param.mvcode}").click();
document.querySelector("#${param.mvcode}").focus();
</script>
</c:if>


<script>
function kakaoPay_ready(recode){
	console.log("카카오 페이 결제 준비");
	
	$.ajax({
		
		type:"post",
		url: "kakaoPay_ready",
		data:{
			'recode' : recode,
			'mvcode' : reserve_mvcode,
			'thcode' : reserve_thcode,
			'scdate' : reserve_scdate+" "+reserve_sctime,
			'schall' : reserve_schall,
			},
		success: function(result){
				console.log(result)
				window.open(result,"pay","width=400,height=500");
			},
		
			error:function(request, status, error){

				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

			}
	});
	
}

let reserveCode =  null;

function registReserveInfo(){
	$.ajax({
		type: "post",
		url: "registReserveInfo",
		data:{
		'mvcode' : reserve_mvcode,
		'thcode' : reserve_thcode,
		'scdate' : reserve_scdate+" "+reserve_sctime,
		'schall' : reserve_schall,
		},
		async: false, 
		dataType: "text",
		success: function(result){
			console.log('예매 처리 결과')
			
			if(result == 'login'){
				alert("로그인 하라")
				location.href="${pageContext.request.contextPath}/memberLoginForm";
			}
			else if(result.length > 0){
			console.log("에매 insert 성공")	
			reserveCode = result;
			kakaoPay_ready(result);
			}
			else{
				console.log("에매 insert 실패")	
				alert("예매 처리 실패")
			}
			
		/* 	 if(result == '1'){
				 console.log("예매 성공")
				 alert("예매 성공");
				 location.href="${pageContext.request.contextPath}/memberLoginForm";
			 	
			 }
			 else {
				 console.log("에매 실패")
			 } */

		},
		error:function(request, status, error){

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
		
	})
}

function failReserve(){
	alert("예매처리 실패")
	$.ajax({
		/*Delete from reserve where recode = ??*/
				type: "post",
				url:"kakaoPay_cancel",
				data:{
					'recode' : reserveCode,
					'mvcode' : reserve_mvcode,
					'thcode' : reserve_thcode,
					'scdate' : reserve_scdate+" "+reserve_sctime,
					'schall' : reserve_schall,
				},
				async:false,
				dataType: json,
				success:function(result){
					console.log(result)
				},
				error:function(request, status, error){

					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

				}
				
				
	})
	
	location.reload();
}
</script>




<script>
function seatBtnClick(){
	console.log("seatBtnClick(mvcode, thname, schall, sctime) 호출")
	
	//console.log(mvcode, thname, schall, sctime)
	
	$.ajax({
		type: "get",
		url: "seat",
		data:{
			"mvcode": reserve_mvcode,  
			 "thname":reserve_thname,      
			"schall":reserve_schall,
			"sctime":reserve_sctime
		},
		dataType: "json",
		success:function(result){
		console.log(result)
		},
		error:function(request, status, error){
		//	seatBtnClick(reserve_mvcode,reserve_thname,reserve_schall,reserve_sctime);
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
		});
	
	location.href="${pageContext.request.contextPath}/seat";
	// 테이블 분리 
}
</script>
</html>