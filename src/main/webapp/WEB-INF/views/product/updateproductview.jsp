<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정화면</title>
</head>
<body>
<form action="updateproduct" method="post" enctype="multipart/form-data">
	<table border="1" width="400px" align="center">
		<caption>상품 입력</caption>
		<c:forEach items="${list }" var="aa">
		<tr>
			<th>상품코드</th>
			<td>
				<input type="text" name="newsnum" value="${aa.snum }"> 
				<input type="hidden" name="snum" value="${aa.snum }">	
			</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>
				<input type="text" name="sname" value="${aa.sname }">
			</td>
		</tr>
		<tr>
			<th>상품타입</th>
			<td>
				<select name="stype">
					<option value="상의" ${aa.stype == '상의' ? 'selected' : ''}>상의</option>
					<option value="하의" ${aa.stype == '하의' ? 'selected' : ''}>하의</option>
					<option value="액세서리" ${aa.stype == '액세서리' ? 'selected' : ''}>액세서리</option>
				</select>	
				<input type="hidden" name="stype" value="${aa.stype }">
			</td>
		</tr>
		<tr>
			<th>수량</th>
			<td><input type="text" name="su" value="${aa.su }"> </td>
		</tr>
		<tr>
			<th>가격</th>
			<td><input type="text" name="price" value="${aa.price }"> </td>
		</tr>
		<tr>
			<th>사이즈</th>
			<td>
				<select name="ssize">
					<option value="xs" ${aa.ssize == 'xs' ? 'selected' : ''}>XS</option>
					<option value="s" ${aa.ssize == 's' ? 'selected' : ''}>S</option>
					<option value="m" ${aa.ssize == 'm' ? 'selected' : ''}>M</option>
					<option value="l" ${aa.ssize == 'l' ? 'selected' : ''}>L</option>
					<option value="xl" ${aa.ssize == 'xl' ? 'selected' : ''}>XL</option>
					<option value="2xl" ${aa.ssize == '2xl' ? 'selected' : ''}>2XL</option>
				</select>
				<input type="hidden" name="ssize" value="${aa.ssize }">
			</td>
		</tr>
		
		<tr>
			<th>색상</th>
			<td>
				<select name="color">
					<option value="red" ${aa.color == 'red' ? 'selected' : ''}>red</option>
					<option value="blue" ${aa.color == 'blue' ? 'selected' : ''}>blue</option>
					<option value="green" ${aa.color == 'green' ? 'selected' : ''}>green</option>
				</select>
				<input type="hidden" name="color" value="${aa.color }">
			</td> 
		</tr>
		<tr>
			<th>상품이미지</th>
			<td>
				<span>메인 이미지</span>
				<img alt="" src="./image/${aa.image }" width="50px" height="50px">
				<input type="file" name="newimage">
				<input type="hidden" name="image" value="${aa.image }">
				 
				
				<span>사이드 이미지1</span>
				<img alt="" src="./image/${aa.sideimage1 }" width="50px" height="50px">
				<input type="file" name="newsideimage1">
				<input type="hidden" name="sideimage1" value="${aa.sideimage1 }">
				
				
				<span>사이드 이미지2</span>
				<img alt="" src="./image/${aa.sideimage2 }" width="50px" height="50px">
				<input type="file" name="newsideimage2">
				<input type="hidden" name="sideimage2" value="${aa.sideimage2 }">
				
				
				<span>사이드 이미지3</span>
				<img alt="" src="./image/${aa.sideimage3 }" width="50px" height="50px">
				<input type="file" name="newsideimage3">
				<input type="hidden" name="sideimage3" value="${aa.sideimage3 }">
				
				
			</td>
		</tr>
		<tr>
			<th>상품설명</th>
			<td>
				<textarea rows="5" cols="30" name="intro" style="resize: none;">${aa.intro }</textarea> 
				<input type="hidden" name="intro" value="${aa.intro }">
			</td>
		</tr>
		<tr>
			<th>베스트상품지정</th>
			<td>
				<select name="best">
					<option value="0" ${aa.best == '0' ? 'selected' : ''}>일반상품</option>
					<option value="1" ${aa.best == '1' ? 'selected' : ''}>베스트상품</option>
				</select>
				<input type="hidden" name="best" value="${aa.best }">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정하기">
				<input type="button" value="메인으로" onclick="location.href='./main'">
			</td>
		</tr>
		</c:forEach>
	</table>
</form>
</body>
</html>