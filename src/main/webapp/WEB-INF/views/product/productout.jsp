<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	a{
		text-decoration-line: none;
		
	}
	td{
		border: 0;
		color: #000000;
	}
</style>
<meta charset="UTF-8">
<title>상품 출력</title>
</head>
<body>
<c:forEach items="${list }" var="aa">
	<a href="detailview?snum=${aa.snum}">
		<div>
			<table border="1" width="200px" align="center">
				<tr>
					<td>
						<input type="hidden" name="snum" value="${aa.snum }">
						<img alt="" src="./image/${aa.image }" width="100px" height="100px">
					</td>
				</tr>
				<tr>
					<td>${aa.sname }</td>
				</tr>
				<tr>	
					<td><f:formatNumber value="${aa.price }" pattern="#,###원"/> </td>
				</tr>
			</table>
		</div>
	</a>
</c:forEach>

</body>
</html>