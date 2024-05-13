<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

h2{
  text-align:center;
  margin-top:40px;
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
    text-align: center;
}

.ordertable th, .ordertable td {
    padding: 8px;
    border: 1px solid #dddddd;
    background-color: #ffffff;
    text-align: center;
    font-size: 15px;
}

.ordertable th {
    background-color: #333;
    color: #ffffff;
    text-align: center;
    font-size: 16px;
}

.ordertable1{
    font-size : 20px;
    margin-top : 30px;
    margin-bottom : 30px;
    text-align: center;
}


</style>
<meta charset="UTF-8">
<title>등급별 혜택</title>
</head>
<body>
<h2 style="text-align: center;">등급별 혜택</h2>
	<table align="center" class="ordertable1">
		<c:forEach items="${list }" var="aa">
		<tr>
			<th>${aa.id}(${aa.membershipdto.name})님의 현재 회원 등급은 ${aa.membershipdto.stringrank } 입니다.</th>
		</tr>
		</c:forEach>
	</table>
	<table align="center" class="ordertable">
		<tr>
			<th>등급</th>
			<th>매월 쿠폰 지급</th>
			<th>마일리지 혜택</th>
			<th>무료 배송 쿠폰 지급</th>
		</tr>	
		<tr>
			<td>패밀리</td>
			<td>10% 할인 쿠폰 : 1장</td>
			<td>1%</td>
			<td>무료 배송 쿠폰 : 1장</td>
		</tr>
		<tr>
			<td>실버</td>
			<td>10% 할인 쿠폰 : 2장</td>
			<td>2%</td>
			<td>무료 배송 쿠폰 : 2장</td>
		</tr>
		<tr>
			<td>골드</td>
			<td>10% 할인 쿠폰 : 2장<br>
				20% 할인 쿠폰 : 1장</td>
			<td>3%</td>
			<td>무료 배송 쿠폰 : 3장</td>
		</tr>
		<tr>
			<td>VIP</td>
			<td>10% 할인 쿠폰 : 3장<br>
				20% 할인 쿠폰 : 2장</td>
			<td>5%</td>
			<td>무료 배송 쿠폰 : 3장</td>
		</tr>
		
	</table>
</body>
</html>