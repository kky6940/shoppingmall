<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
h2{
	text-align: center;
}
a{
	text-decoration: none;
	color: black;
}
.address_container{
    width: 500px;
    height: 700px;
    margin: auto;
    margin-top: 30px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 9px;
    border-top: 10px solid #000000;
    border-bottom: 10px solid #000000;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}


.addresslist{
	margin: 5px;
	padding: 10px;
	border: 1px solid gray;
	display: flex;
	justify-content: space-between;
}
.addresslist2{
	text-align: center;
    border: 1px solid gray;
    padding: 10px;
    margin: 5px
}
    
.btn_div {
    display: flex;
    justify-content: flex-end; 
    align-items: center; /* 세로 방향 중앙 정렬 */
}
.btn_div button{
	min-width: 60px; 
	height: 40px;
    padding: 0 10px;
    line-height: 28px;
    font-size: 14px;
    font-weight: 700;
    border-radius: 2px;
    background-color: #333;
    color: white;
}
.btn_input{
	border: none;
	text-align: center;
	font-size: 18px;
	background-color: white;
}
</style>


</head>
<body>
<div class="address_container">
<h2>배송지 목록</h2>

<c:forEach items="${list }" var="aa" >
<div class="addresslist">
	<div class="list_div">
	<c:set var="addressArray" value="${fn:split(aa.address, ',')}" />
	<span style="font-weight: 700; font-size: 18px;">${aa.adlistname }</span><br>
	<span>${aa.tel }</span> <br>
	<span>${addressArray[0]}</span>
	<span>${addressArray[1]}</span>
	<span>${addressArray[2]}</span> 
	</div>
	<div class="btn_div">
		<button type="button" onclick="deleteAddress(${aa.addressnum})">삭제</button>
	</div>
</div>
</c:forEach>
<div class="addresslist2">
	<div class="btn_addressInput">
		<button class="btn_input" type="button" onclick="addressInput()">+ 추가</button>
	</div>
</div>
</div>

<script type="text/javascript">
	function addressInput() {
		var popup = window.open("addressinput", "Address Popup", "width=600,height=450");
	    popup.focus();	
	}
	function deleteAddress(addressnum) {
		 $.ajax({
		        type: 'POST',
		        url: 'adderessDelete',
		        data: {"addressnum":addressnum },
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

</body>
</html>