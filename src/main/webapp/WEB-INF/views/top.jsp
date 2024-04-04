<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"  href="resources/css/test.css">

<script type="text/javascript">
	function toggle() {
		var menu = document.querySelector(".header_menu");
		var login = document.querySelector(".header_login");
	    menu.classList.toggle('active');
	    login.classList.toggle('active');
	}
</script>

</head>
<body>
<nav class="header">
 	<div class="header_logo">
 		<h1><a href="#"><img alt="" src="resources/img/img_logo.png">Snack Closet</a></h1>
 	</div>	
	<ul class="header_menu">
		<li><a href="productinput">입력</a></li>
		<li><a href="productout">출력</a></li>
		<li><a href="#">KIDS</a></li>
		<li><a href="#">BOARD</a></li>
	</ul>
	<ul class="header_login">
		<!-- 로그인 상태에 따라 로그아웃  -->
		<c:choose>
	    	<c:when test="${loginstate == true}">
				<li><a href="mypage">MyPage</a></li>
				<li><a href="logout">LogOut</a></li>
			</c:when>
			<c:otherwise>
				<a href="membershipjoin2" class="btn_mypage">SignUp</a> 
				<a href="login" class="btn_mypage">LogIn</a> 
			</c:otherwise>
		</c:choose>
		<!-- 장바구니 추가예정 -->
	</ul>
	<a class="header_togglebtn" onclick="toggle()">
		<img alt="" src="resources/img/img_togglebtn.jpg">
	</a>
</nav>
 	
</body>
</html>