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
    .card:hover{
   	transition: transform 1s ease-in-out 1s; 
   transform: translateY(-2.1rem);
    }
    
   .ageInfo{
     position: absolute;
    text-align: center;
    padding: 5px;
    border-radius: 10px;
    font-style: bold;
   } 
.gradeAll{
 background: green;
}
.grade12{
 background: gold;
}
.grade15{
 background: coral;
}
.grade18{
 background: red;
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

.img-profile{
width: 100px;
 height: 100px; 
 border-radius: 50%; 
 object-fit: object-fit: cover;
 }
    
 .loginInfo{
display: flex;
align-items: center;
 }
 .card-title{
margin-left: 20px;
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
                    <h1 class="fw-bolder">메인 페이지</h1>
                    <p class="lead mb-0">영화 랭킹 1위 ~ 6위 목록 출력</p>
                </div>
            </div>
        </header>
        
        
        
        
        <!-- Page content-->
        <div class="container">
           <!-- 컨텐츠 시작  -->
           
             <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                      
                      <c:forEach items="${rankList}" var="mv" varStatus="st">
                        <div class="col-lg-4 col-md-6">

							
							<div class="rankMov">
							No.${st.index+1}
							</div>                            
                            
                            
                            <div class="card mb-4">
                                <a href="${pageContext.request.contextPath}/movieDetail?mvcode=${mv.mvcode}">
                                <img class="card-img-top" src="${mv.mvposter}" alt="..." />
                                </a>
                                <span class="ageInfo grade${mv.mvgrade }">${mv.mvgrade }</span>
                                <div class="card-body">
                                	
                                    <div class="small text-muted">예매율: ${mv.recount}%</div>
                                    <h2 class="card-title h4" title="${mv.mvtitle}" style="overflow: hidden; white-space: nowrap;">${mv.mvtitle}+${mv.mvopendate}</h2>
                                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/reserveMovie?mvcode=${mv.mvcode}">예매</a>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        
                        
                    </div>
                   
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    
                    <c:choose>
                    <c:when test="${sessionScope.loginMemberId == null && sessionScope.loginId == null}">
                          <div class="card mb-4">
                        <div class="card-header" style="text-align: center">로그인 후 이용</div>
                        <div class="card-body">
                            <div class="input-group">
                              <c:if test="${sessionScope.loginMemberId == null}">
                                <a href="${pageContext.request.contextPath}/memberLoginForm" class="btn btn-primary" id="button-search" type="button" style="width: 100%">로그인</a>
                           		        </c:if>
                            <c:if test="${sessionScope.loginMemberId != null}">
                            <h1>${sessionScope.loginMemberId}</h1>
                            <img src ="${sessionScope.profile}"/>
                            </c:if>
                           
                            </div>
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                          <div class="card mb-4">
                        <div class="card-header" style="text-align: center">로그인 후 이용</div>
                        <div class="card-body">
                            <div class="input-group">
                        
                          <c:if test="${sessionScope.loginId != null}">
                            <div class="loginInfo">
                        
                            <img class="img-profile" src ="${loginProfile}"/>                            
                            
                            <h1 class="card-title">${sessionScope.loginName}</h1>
                            </div>
                            </c:if>
                        	
                        	<c:if test="${sessionScope.loginId == null && sessionScope.loginMemberProfile == null}">
                        	<div class="loginInfo">
                        
                            <img class="img-profile" src ="${pageContext.request.contextPath}/resources/users/memberProfile/기본이미지.jpg"/>                            
                            
                            <h1 class="card-title">${sessionScope.loginMemberName}</h1>
                            </div>
                        	</c:if>
                        	
                            <c:if test="${sessionScope.loginMemberId != null && sessionScope.loginMemberProfile != null}">
                            <div class="loginInfo">
                        
                            <img class="img-profile" src ="${pageContext.request.contextPath}/resources/users/memberProfile/${sessionScope.loginMemberProfile}"/>                            
                            
                            <h1 class="card-title">${sessionScope.loginMemberName}</h1>
                            </div>
                            </c:if>
                           
                            </div>
                            
                            
                        </div>
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">회원메뉴</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">예매내역</a></li>
                                        <li><a href="#!">HTML</a></li>
                                        <li><a href="#!">Freebies</a></li>
                                    </ul>
                                </div>
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">회원정보</a></li>
                                        <li><a href="#!">로그아웃</a></li>
                                        <li><a href="#!">Tutorials</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">Side Widget</div>
                        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use, and feature the Bootstrap 5 card component!</div>
                    </div>
                    </c:otherwise>
                    </c:choose>
                    
              
              
                </div>
            </div>
           <!-- 컨텐츠 끝  -->
           
           
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
    </body>
</html>
