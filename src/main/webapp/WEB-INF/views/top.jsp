<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>top.jsp</title>
</head>
<body>
<header>
<img alt="" src="./image/KakaoTalk_20240320_145815898.jpg">
</header>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#"></a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="main">Home</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Top<span class="caret"></span></a>
        <ul class="dropdown-menu">
         <li><a href="productinput">입력</a></li>
          <li><a href="productout">니트</a></li>
          <li><a href="#">맨투맨/후드</a></li>
          <li><a href="#">반팔티</a></li>
          <li><a href="#">긴팔티</a></li>
        </ul>
      </li>
    </ul>
    <ul class="nav navbar-nav">
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">??? <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">Page1</a></li>
          <li><a href="#">Page1</a></li>
          <li><a href="#"></a></li>
        </ul>
    </ul>
    
    <ul class="nav navbar-nav navbar-right">
    <c:choose>
    <c:when test="${loginstate == true}">
        <li><a href="#"><span style="color: #5B67A2;"></span>${membership.id }님 반갑습니다.</a></li>
        <li><a href="cart"><span class="glyphicon glyphicon-user"></span>장바구니</a></li>
        <li><a href="mypage"><span class="glyphicon glyphicon-user"></span>마이페이지</a></li>
        <li><a href="logout"><span class="glyphicon glyphicon-log-in"></span> 로그아웃</a></li>
    </c:when>
    <c:otherwise>
        <li><a href="membershipjoin2"><span class="glyphicon glyphicon-user"></span>회원가입</a></li>
        <li><a href="login"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
    </c:otherwise>
</c:choose>
    </ul>
  </div>
</nav>
</body>
</html>