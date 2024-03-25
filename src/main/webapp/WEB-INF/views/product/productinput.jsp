<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 정보 입력</title>
</head>
<body>
<div class="img_parentsdiv">
<form action="productsave" method="post" enctype="multipart/form-data">
	<table border="1" width="400px" align="center">
		<caption>상품 입력</caption>
		<tr>
			<th>상품코드</th>
			<td><input type="text" name="snum"> </td>
		</tr>
		<tr>
			<th>상품명</th>
			<td><input type="text" name="sname"> </td>
		</tr>
		<tr>
			<th>상품타입</th>
			<td>
				<select name="stype">
					<option value="상의">상의</option>
					<option value="하의">하의</option>
					<option value="액세서리">액세서리</option>
				</select>	
			</td>
		</tr>
		<tr>
			<th>수량</th>
			<td><input type="text" name="su"> </td>
		</tr>
		<tr>
			<th>가격</th>
			<td><input type="text" name="price"> </td>
		</tr>
		<tr>
			<th>사이즈</th>
			<td>
				<select name="ssize">
					<option value="xs">XS</option>
					<option value="s">S</option>
					<option value="m">M</option>
					<option value="l">L</option>
					<option value="xl">XL</option>
					<option value="2xl">2XL</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>상품이미지</th>
			<td><input type="file" name="image"> </td>
		</tr>
		<tr>
			<th>상품설명</th>
			<td><textarea rows="5" cols="30" name="intro"></textarea> </td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="전송">
				<input type="reset" value="취소">
				<input type="button" value="메인으로" onclick="location.href='./main'">
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>