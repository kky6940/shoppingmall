<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
.admintd a {
    text-decoration: none;
    color: #3B5249;
    transition: color 0.3s ease, text-decoration 0.3s ease;
}

.admintd a:hover {
    text-decoration: underline;
    color: #1D2D50;
}

a{
	text-decoration: none;
	color: black;
}
.bottomline{
	padding-bottom: 3px;
	border-bottom: 1px solid black;
}



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
.product_list{
	position: relative;
 	margin-top: 3%;
	width: 1920px; 
	padding-left: 5%;
	padding-right: 5%;	
}
.product_list h3{
	float: left;
	margin-left: 47%;
	margin-top:0;
	margin-bottom: 30px;
}
.product_list p{
	float: right;
	margin-bottom: 10px;
	margin-top: 15px;
}
.box{
	overflow: auto;
}
.clear{ 
	clear: both;
}
.product{ 
	list-style:none;
	width: 280px;
	float: left;
	margin-bottom: 30px;
	
}
.product img{
	width: 100%;
	margin-bottom: 10px;
}
.product .name{
	font-weight: bold;
	font-size: 18px;
}
.product .price{
	font-size: 14px;
}

.paging {
    margin-top: 20px;
    text-align: center;
}

.paging ul {
    list-style: none;
    padding: 0;
}

.paging ul li {
    display: inline;
    margin-right: 5px;
}

.paging ul li a {
    text-decoration: none;
}

.paging ul li b {
    color: red;
}

.selected {
    font-weight: bold;
}
</style>
<meta charset="UTF-8">
<title>마이 페이지 메인</title>
</head>
<body>
<c:forEach items="${list }" var="aa">
	<div>
		<div class="gray"></div>
		<div class="amdinline"></div>


		<table width="200px" align="left" class="admintable">
			<tr>
				<th class="adminth"><a href="mypage">MYPAGE</a></th>
			</tr>
			
			
			<tr>
				<th class="adminth">쇼핑정보</th>
			</tr>
			<tr>
				<td class="admintd"><a href="guestpayoutview">주문/배송</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="refundview">환불/교환/취소</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="basketout">장바구니</a></td>
			</tr>
			
			
			<tr>
				<th class="adminth">혜택정보</th>
			</tr>
			<tr>
				<td class="admintd"><a href="couponview">쿠폰</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="mileageview">마일리지</a></td>
			</tr>
			
			
			<tr>
				<th class="adminth">참여 & 문의</th>
			</tr>
			<tr>
				<td class="admintd"><a href="qnalist">문의 내역</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="myproductreview">상품 리뷰</a></td>
			</tr>
			<tr>
				<td class="admintd">이벤트 응모내역</td>
			</tr>
			
				
			<tr>
				<th class="adminth">회원정보</th>
			</tr>
			<tr>
				<td class="admintd"><a href="membershipupdateview">회원정보 수정</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="mypageaddresslist">배송지 관리</a></td>
			</tr>
			<tr>
				<td class="admintd"><a href="membershipdeleteview">회원 탈퇴</a></td>
			</tr>
		</table>
		
		<div>
			<table width="700px" align="center">
				<tr>
					<th>${aa.id}(${aa.membershipdto.name})님의 현재 회원 등급은 ${aa.membershipdto.stringrank } 입니다.</th>
					<th class="admintd"><a href="rankgift">등급별 혜택</a></th>
				</tr>
				
			</table>
			
			<table width="400px" align="center">
				<tr>
					<th>쿠폰</th>
					<th>마일리지</th>
				</tr>
				<tr>
					<td class="admintd"><a href="couponview">${aa.couponnum }</a></td>
					<td class="admintd"><a href="mileageview">${aa.membershipdto.point }M</a></td>
				</tr>
			</table>
			
			<table width="800px" align="center">
				<tr align="center">
					<th colspan="2" class="bottomline">최근 주문 상품(1달 이내)</th>
				</tr>
			</table>
		
			<table width="1000px" align="center" class="ordertable">
			
				<tr>
				    <c:choose>
				        <c:when test="${not empty list2}">
				            <div id="datatrue">
				                <tr>
				                    <th>주문번호</th>
				                    <th>상품명</th>
				                    <th>구입수량</th>
				                    <th>금액</th>
				                    <th>결재시간</th>
				                    <th>상태</th>
				                    <th>비고</th>
				                </tr>
				                <c:forEach items="${list2}" var="bb">
				                    <tr>
				                        <td>${bb.orderid}</td>
				                        <td>${bb.sname}</td>
				                        <td>${bb.paynum}</td>
				                        <td><f:formatNumber value="${bb.totprice}" pattern="#,###"/></td>
				                        <td>${bb.payendtime}</td>
				                        <td>${bb.paystate}</td>
				                        <td class="admintd" style="width: 180px; text-align: center;">
				                            <a href="paycancel?tid=${bb.tid}"><input type="button" value="환불하기"></a>
				                            <input type="button" value="교환하기">
				                        </td>
				                    </tr>
				                </c:forEach>
				            </div>
				        </c:when>
				        <c:otherwise>
				            <div id="datafalse">
				                <td colspan="2" id="top">최근 주문 내역이 없습니다.</td>
				            </div>
				        </c:otherwise>
				    </c:choose>
				</tr>
				
				
			</table>
			
			<table width="400px" align="center">
				<tr>
					<th class="admintd"><a href="guestpayoutview">주문 배송 조회</a></th>
					<th class="admintd"><a href="refundview">환불/교환/취소 조회</a></th>
				</tr>
			
			</table>
		
			<table width="400px" align="center">
				<tr>
					<div class="product_list">
					<div class="box">
						<h3>베스트 상품</h3>
					<div class="clear"></div>
				 		<c:forEach items="${list3 }" var="cc">
							<ul class="product">
								<li><a href="detailview?snum=${cc.snum}"> 
									<c:set var="imageArray" value="${fn:split(cc.image, ',')}" />
										<c:forEach items="${imageArray}" var="imageName" varStatus="loop">
						   					<c:if test="${loop.index == 0}">
						       					<img alt="" src="./image/${imageName}" width="300px" height="360px">
						   					</c:if>
										</c:forEach>
								</a></li>
								<li class="name"><a href="detailview?snum=${cc.snum}">${cc.sname}</a></li>
								<li class="price"><a href="detailview?snum=${cc.snum}"><f:formatNumber value="${cc.price }" pattern="#,###"/></a></li>
								<li class="intro"><a href="detailview?snum=${cc.snum}">${cc.intro }</a></li>
								<li class="review"><a href="detailview?snum=${cc.snum}">.리뷰갯수</a></li>
							</ul>
						</c:forEach>
					</div>
					</div>
				</tr>
			</table>
		</div>
	</div>	
</c:forEach>
</body>
</html>