<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>

<script>
let payResult = '${payResult}';
if(payResult === 'Y'){
/*
  insert 성공, 결제 성공 
  부모창에 예매성공 출력
 */
 // opener => 팝업창을 연 부모창
 window.opener.location.href="${pageContext.request.contextPath}/";
//window.opener.reserveResult_success();
}else{
	/*
	  insert 성공, 결제 실패 
	  부모창에 예매실패 출력 -> delete 
	  */
	window.opener.failReserve();
}
window.close();
</script>
</html>