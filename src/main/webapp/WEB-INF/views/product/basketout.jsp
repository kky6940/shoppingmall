<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
<form action="productsell" method="post"> <!-- 판매 페이지로 이동 -->
	<table border="1" width="700px" align="center">
		<tr>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>상품사이즈</th>
			<th>상품수량</th>
			<th>상품가격</th>
			<th>주문관리</th>
		</tr>
		<a href="detailview?snum=${aa.snum}">
			<div>
				<c:forEach items="${list }" var="aa">
					<tr>
						<td><img alt="" src="./image/${aa.image }" width="60px" height="60px"> </td>
						<td>${aa.sname }</td>
						<td>${aa.ssize }</td>
						<td>${aa.guestbuysu }</td>
						<td>
							${aa.totprice }
							<!-- 판매 페이지로 가져갈 데이터값 -->
							<input type="hidden" name="snum" value="${aa.snum }">
							<input type="hidden" name="stype" value="${aa.stype }">
						</td>
						<td colspan="5" align="center">
							<input type="submit" value="구매하기">
							<input type="button" value="목록삭제">
						</td>
					</tr>
				</c:forEach>
			</div>
		</a>
	</table>
</form>
</body>
</html>