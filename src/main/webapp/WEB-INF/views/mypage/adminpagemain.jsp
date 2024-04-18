<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	border: none;
	margin-left: auto; 
	margin-right: auto;

}
th{
	text-align: center;
	padding-top: 25px;
	padding-bottom: 10px;
}
td{
	text-align: center;
	padding-bottom: 5px;
}
.bottomline{
	align-content: center;
	text-align: center;
	padding-bottom: 3px;
	border-bottom: 1px solid black;
}
#top{
	padding-top: 7px;
}
tr{
	text-align: center;
}
a{
	text-align: center;
}
#sidemenu{
	width: 250px;
	border-right: 1px;
	border-right-color: gray;
}

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
.amdinline{ 
	position: fixed;
	left:300px;
	top: 0;
	height: 100vh;
	border-right: 2px solid #eeeeee;
}
.admintable{
	border: none;
	z-index: 999;
	position: relative;
  	width: 300px;
}
.adminth{
	padding-top: 25px;
	padding-bottom: 10px;
	text-align: center;
	
}
.admintd{
	padding-bottom: 5px;
	text-align: center;
	color: gray;
}
.admintd a{
	text-decoration:none;
	color: gray;
}
.bottomline{
	padding-bottom: 3px;
	border-bottom: 1px solid black;
}
</style>
<meta charset="UTF-8">
<title>관리자 페이지 메인</title>
</head>
<body>
<div class="gray"></div>
<div class="amdinline"></div>
<table width="300px" align="left" class="admintable">
	<tr>
		<th class="adminth">상품 주문 현황</th>
	</tr>
	<tr>
		<td class="admintd"><a href="payoutview">현재 주문 목록 보기</a></td>
	</tr>
	<tr>
		<td class="admintd">환불 목록 보기</td>
	</tr>
	<tr>
		<td class="admintd">교환 목록 보기</td>
	</tr>
	
	<tr>
		<th class="adminth">회원 가입 현황</th>
	</tr>
	<tr>
		<td class="admintd"><a href="memberviewall">회원 목록</a></td>
	</tr>
</table>
</body>
</html>