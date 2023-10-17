<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <body>

        <!-- 메뉴 시작   -->
        
      <%@include file="/WEB-INF/views/includes/menu.jsp" %>
        
    
       
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">예매 내역 페이지</h1>
                    <p class="lead mb-0">영화 예매 내역 출력</p>
                </div>
            </div>
        </header>
        
   
        <!-- Page content-->
        <div class="container">
          <div class="row">
          	<div class="col">
          	
          		<table>
          			 <thead>
          				<tr>
          					<th>제목</th>
							<th>극장</th>
							<th>상영관</th>
							<th>닐짜</th>
							<th>비고</th>
          				</tr>	
          			 </thead>	
          				
          			 <tbody>
          			 <c:forEach items="${reList}" var="re">
          				<tr>
          				<td><a href="${pageContext.request.contextPath}/detailMovie?mvcode=${re.mvcode}"></a>${re.mvtitle}</td>
          				
          				<td>${re.thname}</td>
          				<td>${re.schall}</td>
          				<td>${re.scdate}</td>
          				<td><button>예매취소</button> <button>관람평작성</button></td>
          				</tr>
          			</c:forEach>
          			 </tbody>
          		</table>
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
</html>
