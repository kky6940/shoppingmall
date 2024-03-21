<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function numbercommas(a) {
    return a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 0,000원 결과값을 만들기 위한 정규식
}

function totalprice() {
    var price = document.getElementById("price").value;
    var su = document.getElementById("su").value;
    var totprice = parseInt(price) * parseInt(su);
    
    document.getElementById("totpriceid").value = totprice; // hidden 총 금액
    document.getElementById("totpriceview").innerText = numbercommas(totprice) + "원"; // 사용자에게 보여지는 총 금액, 위의 정규식 포함 결과값 끝에 원을 붙임
}

// 페이지 로드 후에 이벤트 리스너 등록, 수량을 변경할 때마다 총 금액이 갱신되게 만듬
window.addEventListener("load", function() {
    document.getElementById("su").addEventListener("change", totalprice);
    totalprice();
});
	

function submitfrom(action) {
	var form = document.getElementById('formchoice');
	
	form.action = action;
	form.submit();
}
	
</script>
<meta charset="UTF-8">
<title>상품 내용</title>
</head>
<body>
<form id="formchoice" method="post" enctype="multipart/form-data">
	<c:forEach items="${list }" var="aa">
		<div>
			<table border="1" width="300px" align="center">
				<tr>
					<td>
						<img alt="" src="./image/${aa.image }">
						<input type="hidden" name="image" value="${aa.image }"> <!-- 구매 확인을 위한 hidden -->
					</td>
				</tr>
				<tr>
			</table>
		</div>
		<div>
			<table border="1" width="300px" align="center">	
				<tr>
					<th>상품명</th>
					<td>
						<span>${aa.sname }</span>
						<input type="hidden" name="sname" value="${aa.sname }"> 
						<input type="hidden" name="snum" value="${aa.snum }">
						<input type="hidden" name="stype" value="${aa.stype }">
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
						<input type="number" name="guestbuysu" min="1" max="3" id="su" value="1">
					</td>
				</tr>
				<tr>
					<th>총 상품 금액</th>
					<td>
						<span id="totpriceview">0원</span> 
						<input type="hidden" name="totprice" id="totpriceid" value="0원" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"> 
						<input type="button" value="구매하기" onclick="submitfrom('./productsell')">
						<input type="button" value="장바구니" onclick="submitfrom('./basket')">
					</td>
				</tr>
			</table>
		</div>
	</c:forEach>
</form>
</body>
</html>