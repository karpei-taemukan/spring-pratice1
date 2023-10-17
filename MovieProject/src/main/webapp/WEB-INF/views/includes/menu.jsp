<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        
        <c:if test="${msg !=null}">
        <script type="text/javascript">
		let msg = '${msg}';
			if(msg.length > 0){
				alert(msg);
					}
		</script>
        </c:if>
 <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">Movie Project</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/movieList">영화</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reserveMovie">예매</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">메뉴</a></li>
                          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reserveList">예매내역</a></li>
                        
                        <c:choose> 
                        <c:when test="${sessionScope.loginMemberId == null}">     
                          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberJoin">회원가입</a></li>
                         <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberLoginForm">로그인</a></li>
                                             
                       	</c:when>
                        </c:choose>
 						<li class="nav-item">
                         <a class="nav-link" href="${pageContext.request.contextPath}/memberLogout">로그아웃</a>
                         </li>
                               <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">Blog</a></li>
                    </ul>
                </div>
            </div>
        </nav>
