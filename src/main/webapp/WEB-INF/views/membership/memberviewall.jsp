<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
<table border="1" width="1000px" align="center">
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>주민번호</th>
			<th>주소</th>
			<th>회원등급</th>
		</tr>
		
	<c:forEach items="${list }" var="aa">	
		<tr>
			<td>${aa.id }</td>
			<td>${aa.pw }</td>
			<td>${aa.name }</td>
			<td>${aa.tel }</td>
			<td>${aa.email }</td>
			<td>${aa.pid }</td>
			<td>${aa.address }</td>
			<td>${aa.rank }</td>
		</tr>
	</c:forEach>
	
		<tr>
			<td colspan="8" align="center">
				<input type="button" value="이전 화면으로" onclick="history.back()">
			</td>
		</tr>
</table>
</body>
</html>