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
   	transition: transform .1s ease-in-out .1s; 
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
    </style>
    <body>

        <!-- 메뉴 시작   -->
        
      <%@include file="/WEB-INF/views/includes/menu.jsp" %>
        
        
       <!-- 메뉴 끝 -->
       
       
       
       
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">영화 목록 페이지</h1>
                    <p class="lead mb-0">예매 가능한 영화 목록 출력</p>
                </div>
            </div>
        </header>
        
        
        
        
        <!-- Page content-->
        <div class="container">
           <!-- 컨텐츠 시작  -->
           
             <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-12">
                
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                      
                      <c:forEach items="${movieList}" var="mv">
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <!-- Blog post-->
                            <div class="card mb-4">
                                <a href="${pageContext.request.contextPath}/movieDetail?mvcode=${mv.mvcode}">
                                <img class="card-img-top" src="${mv.mvposter}" alt="..." />
                                </a>
                                <span class="ageInfo grade${mv.mvstate }">${mv.mvstate }</span>
                                
                                <div class="card-body">
                                    <div class="small text-muted">장르: ${mv.mvgenre}</div>
                                    <h2 class="card-title h4" title="${mv.mvtitle}" style="overflow: hidden; white-space: nowrap;">${mv.mvtitle}+${mv.mvopendate}</h2>
                                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/movieDetail?mvcode=${mv.mvcode}">예매</a>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        
                        
                    </div>
                   
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
