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
    width: 30%;
    margin-top:20px;
    border-collapse: collapse;
    text-align: center;
}

.ordertable th, .ordertable td {
    padding: 8px;
    border: 1px solid #dddddd;
    background-color: #ffffff;
    text-align: center;
}

.ordertable th {
    background-color: #333;
    color: #ffffff;
}


</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 style="text-align: center;">상품리뷰</h2>
	<table align="center" class="ordertable">
		<tr>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>제목</th>
			<th>작성일</th>
			<th>평가</th>
		</tr>
	<c:forEach items="${list }" var="bb">	
		<tr>
			<td><a href="reviewproductview?snum=${bb.snum }&sname=${bb.sname}">${bb.image }</a></td>
			<td><a href="reviewproductview?snum=${bb.snum }&sname=${bb.sname}">${bb.sname }</a></td>
			<td>${bb.btitle }</td>
			<td>${bb.bdate }</td>
			<td>${bb.productrank } / 5</td>
			
		</tr>
	</c:forEach>	
		
	</table>
</body>
</html>