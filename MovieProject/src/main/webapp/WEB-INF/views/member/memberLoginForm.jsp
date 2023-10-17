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
    </head>
    <style>
    input[type="text"]:focus{
    border: 1px solid green
    }
    </style>
    <body>

        <!-- 메뉴 시작   -->
        
      <%@include file="/WEB-INF/views/includes/menu.jsp" %>
        
       <!-- 메뉴 끝 -->
       
       
       
       
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">로그인 페이지</h1>
                    <p class="lead mb-0">로그인을 위한 아이디, 비밀번호 입력 페이지</p>
                </div>
            </div>
        </header>
        
        

	<div class="card mb-4 mx-auto" style="width:500px; height: 500px;">
		<div class="card-body" style="display: flex; flex-direction: column;">
			<div class="card-title">
				로그인
			</div>
			<form action="${pageContext.request.contextPath}/memberLogin" onsubmit="return formCheck(this);" method="post" enctype="multipart/form-data" style="display: flex; flex-direction: column;">
				<div class="row m-1">
				<input type="text" name="userId" placeholder="아이디" style="border-radius: 10px;">
				</div>
				<div class="row m-1">
				<input type="text" name="userPw" placeholder="비밀번호" style="border-radius: 10px;">
				</div>
				<div class="row m-1">
				<input type="submit" value="로그인" class="btn btn-dark">
				</div>
			</form>
			<div class="row m-1">
				<button class="btn btn-warning" onclick="memberLogin_kakao()">카카오 로그인</button>
			</div>
		</div>
	</div>        
      

        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
       
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
       <!-- 카카오 로그인 JS -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>   

<p id="token-result"></p>

<script>
function formCheck(obj){
let inputId = obj.userId;
let inputPw = obj.userPw;

if(inputId.value.length == 0){
	alert("아이디 입력하라");
	inputId.focus();
	return false;
}

if(inputPw.value.length == 0){
	alert("비밀번호 입력하라");
	inputPw.focus();
	return false;
}


}
</script>


<script>
Kakao.init('069b6076801e896f15c9bc93486d4e47');
Kakao.isInitialized();
console.log(Kakao.isInitialized());

function memberLogin_kakao(){
console.log("카카오 로그인 호출")	



Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8082/MovieProjectController/memberLoginForm',
    });
}
let authCode ="${param.code}";
console.log("authCode: "+ authCode);
    if(authCode.length > 0){
    	console.log("카카오 인가 코드 있음");
    	console.log("인증 토큰 요청");
    	
    $.ajax({
    	
    	type:"post",
    	url: "https://kauth.kakao.com/oauth/token",
    	contentType: "application/x-www-form-urlencoded;charset=utf-8",
    	data:{
    		"grant_type": "authorization_code",
    		"client_id":"51850a9ce196cbeb518d199ece2632b7",
    		 "redirectUri": 'http://localhost:8082/MovieProjectController/memberLoginForm',
    		 "code":authCode
    	},
    	success:function(res){
    		//console.log(res)
    		console.log("인증토큰: "+res.access_token)
    		Kakao.Auth.setAccessToken(res.access_token);
    		Kakao.API.request({
    			  url: '/v2/user/me',
    			})
    			  .then(function(res) {
    				 console.log("카카오 계정 정보")
    				 console.log(res);
    			     console.log("id: "+res.id);
    				 console.log("email: "+res.kakao_account.email);
    				 console.log("nickname: "+res.properties.nickname);
    				 console.log("profile_image: "+res.properties.profile_image);
    				 
    				 /*카카오 계정 정보가 members 테이블에서 조회*/
  						
    				 $.ajax({
    					type: "get", 
    					url: "memberLogin_kakao",
    					data:{
    					"id": res.id,
    					},
    					success: function(checkMember_kakao){
    						if(checkMember_kakao === "Y"){
    							alert("로그인 됨");
    							location.href="${pageContext.request.contextPath}/";
    						}
    						else{
    				 let check = confirm("가입 정보 없음\n 카카오 계정으로 가입하라");
								if(check){
								console.log("카카오 회원 가입 기능 호출");
								memberJoin_kakao(res);
								
								}    							
    						}
    					}
    				 });
  
    				 
    				 
    			  		 /* 스크립트에서 컨트롤러로 데이터 보내기
    			  		 location.href=""
    			  		 $.ajax({
    			  			 
    			  			 success:function(){
    			  				 location.href="/~~"
    			  			 }
    			  		 })
    			  		 */
    			  })
    			  .catch(function(error) {
    			    console.log(error);
    			  });
    	}
    });
    }
    
</script>
<script>
function memberJoin_kakao(res){
	console.log(res);
	$.ajax({
		type:"get",
		url: "memberJoin_kakao",
		data:{
			"mid":res.id,
			"mname":res.properties.nickname,
			"memail":res.kakao_account.email,
			"mprofile":res.properties.profile_image
			},
		success:function(joinResult){
			alert("카카오 계정으로 화원 가입. \n 다시 로그인 하라");
			location.href="${pageContext.request.contextPath}/member/memberLoginForm";
		}
	});
}
</script>


</body>

</html>