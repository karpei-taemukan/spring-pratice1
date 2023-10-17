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
        <style>
        .movieposter{
        max-width: 70%;
        height: auto;
        border-radius: 10px;
        }
        .img-profile{
width: 100px;
 height: 100px; 
 border-radius: 50%; 
 object-fit: object-fit: cover;
 }
        </style>
    </head>
<body>

     <%@include file="/WEB-INF/views/includes/menu.jsp" %>
     
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">메인 페이지</h1>
                    <p class="lead mb-0">영화 랭킹 1위 ~ 6위 목록 출력</p>
                </div>
            </div>
        </header>
        
        <!-- 컨텐츠 시작 -->
        
        <div class="row my-4">
        <div class="col-lg-5" style="text-align: center">
        <img alt="" src="${movie.mvposter}" class="movieposter">
        </div>
        <div class="col-lg-7">
          <div class="card-body pt-5">
         <div class="small text-muted">예매율</div>
           <h2 class="card-title" style="overflow: hidden; white-space: nowrap;">${movie.mvtitle}</h2>
           <p class="card-text">김독: ${mv.mvdirector} / 배우: ${movie.mvactors}</p>
           <p class="card-text">장르: ${mv.mvgenre} / 기본정보: ${movie.mvinfo}</p>
           <p class="card-text">개봉일: ${movie.mvopendate }</p>
             <a class="btn btn-danger" href="#!">예매</a>

           </div>
        </div>
        </div>
        
     <!-- 컨텐츠 끝 -->
     
          <!--  
          관람평 시작 -->
          
          <div class="row" style="height: 200px; border: 1px solid black;">
          
          <label for="movieComments">Comments</label> 
     <c:forEach var="rv" items="${rvList}">
     
     <%-- 일반, 카카오 --%>
     <div>
     <c:if test="${rv.MSTATE == 'YC' }">
     <c:if test="${rv.MPROFILE == null}">
                             <img class="img-profile" src ="${pageContext.request.contextPath}/resources/users/memberProfile/기본이미지.jpg"/>  
     </c:if>
     <img class="rounded-circle img-profile" src="${pageContext.request.contextPath}/resources/users/memberProfile/${sessionScope.loginMemberProfile}" />
      
       </c:if>
       <textarea id="movieComments" name="movieComments" rows="5" cols="33">
		${rv.MID} : ${rv.RVCOMMENT}
		</textarea>
		</div>
          <c:if test="${sessionScope.loginMemberId == rv.MID}">
			<!-- 			
			<c:out value="${rv.RVCODE}"/>
			<button class="btn btn-danger" onclick="deleteComment(this, '${rv.RVCODE}')">Delete Comment</button>
			 -->
			<a class="btn btn-danger" href="${pageContext.request.contextPath}/deleteComment?rvcode=${rv.RVCODE}&mvcode=${param.mvcode}">Delete Comment</a>
          </c:if>
          </c:forEach>
          </div>
          
          
          <!-- 관람평 끝 -->
          
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>    

<!-- 
 <script>
function deleteComment(delObj, rvcode){
	//console.log(delObj);
	console.log(rvcode);
	
	$.ajax({
		type: "get",
		url: "deleteComment",
		data:{
			"rvcode": rvcode
		},
		async: false,
		dataType: "json",
		error:function(request, status, error){

			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}
		})
}
</script>
 -->

</html>

