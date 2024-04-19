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
}

.ordertable th {
    background-color: #333;
    color: #ffffff;
}


</style>
<meta charset="UTF-8">
<title>문의 내역</title>
</head>
<body>
<h2 style="text-align: center;">문의 내역</h2>
	<table align="center" class="ordertable">
		<tr>
			<th>문의유형</th>
			<th>제목</th>
			<th>작성일</th>
			<th>문의상태</th>
		</tr>
	<c:forEach items="${list }" var="aa">	
		<tr>
			<td><a href="qnasearchview?btitle=${aa.btitle }&bnum=${aa.bnum}">${aa.btype }</a></td>
			<td><a href="qnasearchview?btitle=${aa.btitle }&bnum=${aa.bnum}">${aa.btitle }</a></td>
			<td>${aa.bdate }</td>
			<td>${aa.qnastate }</td>
			
		</tr>
	</c:forEach>	
		
	</table>
</body>
</html>