<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.bankDiv{ 
	text-align: center;
    border: 2px solid gray;
    width: 700px;
    top: 30%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 24px;
    position: absolute;
    padding: 10px 10px;
}
h2{
	margin: 0;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="bankDiv">
	<c:forEach items="${list }" var="aa">
		<h2 align="center">${aa.name } 님의 마일리지는 현재 <f:formatNumber pattern="#,###M" value="${aa.point }"></f:formatNumber> 입니다.</h2>
	</c:forEach>
</div>
</body>
</html>