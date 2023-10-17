<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                      
                      <c:forEach begin="1" end="6" step="1">
                        <div class="col-lg-4">
                            <!-- Blog post-->
                            <div class="card mb-4">
                                <a href="${pageContext.request.contextPath}/movieDetail"><img class="card-img-top" src="https://img.cgv.co.kr/Movie/Thumbnail/Poster/000087/87136/87136_320.jpg" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">개봉일</div>
                                    <h2 class="card-title h4">영화 제목 + 개봉일</h2>
                                    <a class="btn btn-danger" href="#!">예매</a>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        
                        
                    </div>
                   
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header">Search</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input class="form-control" type="text" placeholder="Enter search term..." aria-label="Enter search term..." aria-describedby="button-search" />
                                <button class="btn btn-primary" id="button-search" type="button">Go!</button>
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
                </div>
            </div>
</body>
</html>