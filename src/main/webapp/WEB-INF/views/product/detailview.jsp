<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function totalprice() {
    var price = document.getElementById("price").value;
    var su = document.getElementById("su").value;
    var totprice = parseInt(price) * parseInt(su);
    
    document.getElementById("totprice").innerText = numbercommas(totprice) + "원"; // 결과값 끝에 0을 붙임
    
    function numbercommas(a) {
        return a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 0,000원 결과값을 만들기 위한 정규식
    }
}

// 페이지 로드 후에 이벤트 리스너 등록, 수량을 변경할 때마다 총 금액이 갱신되게 만듬
window.addEventListener("load", function() {
    document.getElementById("su").addEventListener("change", totalprice);
});
	
</script>
<meta charset="UTF-8">
<title>상품 내용</title>
</head>
<body>
<form action="productsell" method="post" enctype="multipart/form-data">
	<c:forEach items="${list }" var="aa">
		<table border="1" width="300px">
			<tr>
				<td>
					<img alt="" src="./image/${aa.image }">
					<input type="hidden" name="image" value="${aa.image }">
				</td>
			</tr>
			<tr>
		</table>
		
		<table border="1" width="300px">	
			<tr>
				<th>상품명</th>
				<td>
					${aa.sname }
					<input type="hidden" name="sname" value="${aa.sname }"> 
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<f:formatNumber value="${aa.price }" pattern="#,###원" />
					<input type="hidden" name="price" value="${aa.price }" id="price"> 
				</td>
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
				<th>수량</th>
				<td>
					<input type="number" name="guestbuysu" min="1" max="3" id="su">
					<input type="hidden" name="su" value="${aa.sname }"> 
				</td>
			</tr>
			<tr>
				<th>총 상품 금액</th>
				<td id="totprice">0원</td>
			</tr>
	
			<tr>
				<td> 
					<input type="submit" value="구매하기">
					<input type="reset" value="취소">
					<input type="button" value="장바구니" onclick="location.href='./basket'">
				</td>
			</tr>
		</table>
	</c:forEach>
</form>
</body>
</html>