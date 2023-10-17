<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<body style="background-color: green;">
<h1>회원 가입 페이지</h1>

	<div class="card mb-4 mx-auto" style="width:500px; height: 500px;">
		<div class="card-body" style="display: flex; flex-direction: column;">
			<div class="card-title">
				회원 가입 
			</div>
			<form action="${pageContext.request.contextPath}/memberJoinRequest"
			enctype="multipart/form-data"
			 method="post" style="display: flex; flex-direction: column;"
			 onsubmit="return formCheck(obj);"
			 >
				<div class="row m-1">
				<input type="text" onkeyup="idCheck(this)" name="mid" placeholder="아이디" style="border-radius: 10px;">
				</div>
				<div class="row m-1" id="idCheckMsg">
				중복 아이디 체크
				</div>
				<div class="row m-1">
				<input type="text" name="mpw" placeholder="비밀번호" style="border-radius: 10px;">
				</div>
				<div class="row m-1">
				<input type="text" name="mname" placeholder="이름" style="border-radius: 10px;">
				</div>
				<div class="row m-1">
				<input type="text" name="memail" placeholder="이메일" style="border-radius: 10px;">
				@
				<input type="text" id="domain" name="memailDomain" placeholder="이메일 도메인">
				<select>
				<option value="">직접입력</option>
				
				
				
				
				
				
				
				<option value="naver.com">네이버</option>
				<option value="google.com">구글</option>
				</select>
				</div>
				<div class="row m-1">
					<input type="file" name="mfile">
				</div>
			
				<div class="row m-1">
				<input type="submit" value="회원가입" class="btn btn-dark">
				</div>
			</form>
		</div>
	</div>        
      
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>

let idChecked = false; // 아이디 중복 확인 

function idCheck(inputObj){
let msgEl = document.getElementById("idCheckMsg");
	
	$.ajax({
		
		type:"get",
		url: "memberIdCheck",
		data: {
			"inputId":inputObj.value
		},
		success:function(checkResult){
			//console.log(checkResult)	
			if(checkResult.length > 0){
			msgEl.innerText = "중복아이디";
			msgEl.style.color="red";
			idChecked = false;
			}
		else {
			msgEl.innerText="사용 가능 아이디";
			msgEl.style.color="blue";
			idChecked = true;
			
		}
		}
	});
}
</script>

<script>
function formCheck(obj){
	let inputId = obj.mid;
	let inputPw= obj.mpw;
	let inputName = obj.mname;
	
	if(inputId.value.length == 0){
		alert("아이디 입력하라");
		inputId.focus();
		return false;
	}
	
	if(!idChecked){
	alert("아이디 중복 확인 하라");
	inputId.focus();
	return false;
	}
	
	if(inputPw.value.length == 0){
		alert("비밀번호 입력하라");
		inputPw.focus();
		return false;
	}
	if(inputName.value.length == 0){
		alert("이름 입력하라");
		inputName.focus();
		return false;
	}
}
</script>


<script>
let select = document.querySelector("select");
let option = document.querySelector("option");
let domain = document.querySelector("#domain");

select.addEventListener("change", (e) => {

	domain.value=e.target.value;
})
</script>

</html>