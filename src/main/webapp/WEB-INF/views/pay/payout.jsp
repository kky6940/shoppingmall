<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구입 결과</title>
</head>
<body>
<table border="1" width="700px" align="center">
	<c:forEach items="${list }" var="aa">
	<tr>
		<th>주문번호</th>
		<th>상품명</th>
		<th>구입수량</th>
		<th>금액</th>
		<th>결재시간</th>
		<th>상태</th>
		<th>비고</th>
	</tr>
	<tr>
		<td>${aa.orderid }</td>
		<td>${aa.sname }</td>
		<td>${aa.paynum }</td>
		<td>${aa.totprice }</td>
		<td>${aa.payendtime }</td>
		<td>결재완료</td>
		<td>
			<input type="button" value="환불하기">
			<input type="button" value="교환하기">
		</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>