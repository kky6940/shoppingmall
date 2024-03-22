<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
document.getElementById("formchoice").onsubmit = function() {
    var form = document.getElementById("formchoice");
    var formData = new FormData(form);
    var selectedItems = [];
    
 // 선택된 checkbox를 가져와서 선택된 항목을 찾습니다.
    var checkboxes = document.getElementsByName('selectedItems');
    checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) { // checkbox가 선택된 경우
            selectedItems.push(checkbox.value); // checkbox의 값을 선택된 항목 배열에 추가합니다.
        }
    });

    // 선택된 checkbox만 form 데이터에 추가합니다.
    selectedItems.forEach(function(value) {
        formData.append('selectedItems', value); // form 데이터에 선택된 항목을 추가합니다.
    });

    // 선택된 데이터를 가지고 submit
    form.submit();
    
    return false; // 기본 제출 동작 방지
};

</script>

<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
<form action="productsell" method="post" id="formchoice"> <!-- 판매 페이지로 이동 -->
	<table border="1" width="700px" align="center">
		<tr>
			<th>선택</th>
			<th>순번</th>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>상품사이즈</th>
			<th>상품수량</th>
			<th>상품가격</th>
			<th>주문관리</th>
		</tr>
			<div>
				<c:forEach items="${list }" var="aa">
					<tr>
						<td>
							<input type="checkbox" name="item" value="${aa.basketnum }">
						</td>
						<td>
							<span>${aa.basketnum }</span>
						</td>
						<td>
							<a href="detailview?snum=${aa.snum}">
							<img alt="" src="./image/${aa.image }" width="60px" height="60px">
							<input type="hidden" name="image" value="${aa.image }"> 
						</td>
						<td>
							<span>${aa.sname }</span>
							<input type="hidden" name="sname" value="${aa.sname }">
							</a>
						</td>
						<td>
							<span>${aa.ssize }</span>
							<input type="hidden" name="ssize" value="${aa.ssize }">
						</td>
						<td>
							<span>${aa.guestbuysu }</span>
							<input type="hidden" name="guestbuysu" value="${aa.guestbuysu }">
						</td>
						<td>
							<span><f:formatNumber value="${aa.totprice }" pattern="#,###원"/></span>
							<input type="hidden" name="totprice" value="${aa.totprice }">
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
		
	</table>
</form>
</body>
</html>