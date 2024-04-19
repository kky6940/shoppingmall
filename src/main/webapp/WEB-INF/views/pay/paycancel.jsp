<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

h2{
  text-align:center;
  margin:0;
}
.order_list{
	margin-top: 24px;
    width: 72%;
    min-width:1360px;
    left:330px;
    position: absolute;
}
.ordertable {
    width: 50%;
    margin-top:20px;
    border-collapse: collapse;
}

.ordertable th, .ordertable td {
    padding: 8px;
    border: 1px solid #dddddd;
    background-color: #ffffff;
}

.ordertable th {
    background-color: #333;
    color: #ffffff;
}


</style>

<script type="text/javascript">
function kakaopaycancel() {
	var formData = {
			tid: $('#tid').val(),
			totprice: $('#totprice').val()
        };
	
    $.ajax({
        type: 'POST',
        url: 'paycancelrequest',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function (response) {
            alert('환불이 완료되었습니다.');
        	window.location.href = 'main';
            
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}
</script>
<meta charset="UTF-8">
<title>결제환불</title>
</head>
<body>
<table align="center" class="ordertable">
	<tr>
		<th>주문번호</th>
		<th>상품명</th>
		<th>구입수량</th>
		<th>금액</th>
		<th>결재시간</th>
	</tr>
	<tr>
		<c:forEach items="${list }" var="aa">
			<td>${aa.orderid }</td>
			<td>${aa.sname }</td>
			<td>${aa.paynum }</td>
			<td>
				${aa.totprice }
				<input type="hidden" name="totprice" value="${aa.totprice }" id="totprice">
			</td>
			<td>
				${aa.payendtime }
				<input type="hidden" name="tid" value="${aa.tid }" id="tid">	
			</td>	
			
		</c:forEach>
		
	</tr>	
	<tr>
		<td colspan="5" align="center"><span>정말로 환불하시겠습니까?</span></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<button onclick="kakaopaycancel()">환불하기</button>
		</td>
	</tr>
	
	
</table>
</body>
</html>