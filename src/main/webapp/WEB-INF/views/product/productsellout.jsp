<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
function kakaopay() {
	var formData = {
			snum: $('#snum').val(),
            sname: $('#sname').val(),
            guestbuysu: $('#guestbuysu').val(),
            totprice: $('#totprice').val()
        };
	
    $.ajax({
        type: 'POST',
        url: 'payready',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function (response) {
            // Ajax 요청이 성공하면 다음 페이지로 리디렉션
        	window.location.href = response;
            
        },
        error: function (xhr, status, error) {
            // 에러 처리
            console.error(error);
        }
    });
}
</script>
<meta charset="UTF-8">
<title>구매 페이지</title>
</head>
<body>
	<div>
		<table border="1" width="500px" align="center">
		<c:forEach items="${list }" var="aa">
			<tr>
				<th>배송지</th> 
				<td colspan="4">
					<span>${aa.address }</span>
					<input type="hidden" name="address" value="${aa.address }"> 
				</td>
				<td>
					<input type="button" value="수정">
				</td>
			</tr>
			<tr>
				<th>이름</th> 
				<td colspan="4">
					<span>${aa.name }</span>
					<input type="hidden" name="name" value="${aa.name }"> 
				</td>
				<td>
					<input type="button" value="수정">
				</td>
			</tr>
			<tr>
				<th>연락처</th> 
				<td colspan="4">
					<span>${aa.tel }</span>
					<input type="hidden" name="tel" value="${aa.tel }"> 
				</td>
				<td>
					<input type="button" value="수정">
				</td>
			</tr>
			<tr>
				<th>Email</th> 
				<td colspan="4">
					<span>${aa.email }</span>
					<input type="hidden" name="email" value="${aa.email }"> 
				</td>
				<td>
					<input type="button" value="수정">
				</td>
			</tr>
			<tr>
				<th>배송 요청사항</th>
				<td colspan="5">
					<select name="request">
						<option value="부재">부재시 연락주세요</option>
						<option value="경비실">경비실에 보관해주세요</option>
						<option value="문앞">문앞에 놓아주세요</option>
					</select>
				</td>
			</tr>
	</div>
	
	<div>
			<tr>
				<th>상품이미지</th>
				<th>상품명</th>
				<th>상품사이즈</th>
				<th>상품색상</th>
				<th>상품수량</th>
				<th>상품가격</th>
			</tr>
			<tr>
				<td>
					<img alt="" src="./image/${aa.image }" width="60px" height="60px">
					<input type="hidden" name="image" value="${aa.image }"> 
				</td>
				<td>
					<span>${aa.sname }</span>
					<input type="hidden" name="sname" value="${aa.sname }" id="sname">
				</td>
				<td>
					<span>${aa.ssize }</span>
					<input type="hidden" name="ssize" value="${aa.ssize }">
				</td>
				<td>
					<span>${aa.color }</span>
					<input type="hidden" name="ssize" value="${aa.color }">
				</td>
				<td>
					<span>${aa.guestbuysu }</span>
					<input type="hidden" name="guestbuysu" value="${aa.guestbuysu }" id="guestbuysu">
				</td>
				<td>
					<span><f:formatNumber value="${aa.totprice }" pattern="#,###원"/></span>
					<input type="hidden" name="totprice" value="${aa.totprice }" id="totprice">
					<input type="hidden" name="snum" value="${aa.snum }" id="snum">
					<input type="hidden" name="stype" value="${aa.stype }">
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">
					<button onclick="kakaopay()"><f:formatNumber value="${aa.totprice }" pattern="#,###원" /> 구입하기</button>
				</td>
			</tr>
		</table>	
		</c:forEach>
	</div>

</body>
</html>