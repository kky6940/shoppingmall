<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
/* Google web font CDN*/
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

*{
    box-sizing: border-box; /*전체에 박스사이징*/
    outline: none; /*focus 했을때 테두리 나오게 */
}

body{
    font-family: 'Noto Sans KR', sans-serif;
    font-size:14px;
    background-color: #f5f6f7;
    line-height: 1.5em;
    color : #222;
    margin: 0px;
}

a{
    text-decoration: none;
    color: #222;
}

.member{
  	width: 400px;
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

.member .field{
    margin :15px 0;
}

.member b{
    display: block;
    margin-bottom: 5px;
}

.member input:focus, .member select:focus{
    border: 1px solid #2db400;
}

.field.tel-number div {
    display: flex;
}

.placehold-text{
   display: inline-block;
   position:relative;
   border: 1px solid #000; 
} 

.placehold-text:before{
   position:absolute;
   right : 20px; 
   top:13px; 
   pointer-events: none;
} 

.field.address input[type="text"]{
	margin-bottom: 5px;
}

.member-footer {
    text-align: center;
    font-size: 12px;
    margin-top: 20px;
}

.member-footer div a:hover{
    text-decoration: underline;
    color:#2db400;
}

.member-footer div a:after{
    content:'|';
    font-size: 10px;
    color:#bbb;
    margin-right: 5px;
    margin-left: 7px;
    display: inline-block;
    transform: translateY(-1px);
}

.submitgo{
	display: inline-block;
	margin-right: 20px auto; /* 버튼 간격 조절을 위해 추가 */
}

.textbox1{
    width: 100px; 
}

@media (max-width:768px) {
    .member{
        width: 100%;
    }
form{
    	margin-top: 50px;
    	padding: 0px;
    }
}

input[type="text"],
input[type="password"]
{
  border-radius: 4px;
	height: 25px;
	border: 1px solid #ccc;
	padding: 8px;
	font-size: 14px;
}
.member input[type=button]{ 
	border-radius: 5px;
	background-color: #16222A; 
 	color: #fff;
 	border: 1px solid;
 }

.submitgo {
    border-radius: 5px;
    background-color: #333;
    color: #fff;
    border: none;
    padding: 8px 20px;
    font-size: 14px;
    cursor: pointer;
}
.submitgo:hover {
  background: #000000;
}
.buttonmove{
	padding-left: 70px;
	padding-top : 30px;
}
</style>
<script type="text/javascript">
function confirmDelete() {
    return confirm("정말로 탈퇴하시겠습니까?");
}
</script>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
<form id="deleteForm" action="membershipdelete" method="post" onsubmit="return confirmDelete()">
	
	<div class="member">
	<c:forEach items="${list }" var="aa">	
    <!-- 필드 id, 비밀번호, 비밀번호 재확인 -->
    <h2 style="text-align: center;">회원 탈퇴</h2>
    <div class="field">
    <b>아이디</b>
    <input type="text" name="id" id="id" class="placehold-text" value=${aa.id } readonly>
	</div>
	
	<div class="field">
	<b>이름</b>
	<input type="text" name="name" id="name" value="${aa.name }" readonly>
    </div>
    
    <!-- 전화번호 -->
    <div class="field tel-number">
		<b>연락처</b>
		<input type="text" name="tel" id="tel" value="${aa.tel }" readonly>
   		</div>
   	
   	<!-- 이메일 -->
   	<div class="field email">
	<b>이메일</b>
	<input type="text" name="email" id="email" value="${aa.email }" readonly>
	</div>
	
	<!-- 주민번호 -->
	<div class="field birth">
	<b>주민번호</b>
	<input type="text" name="pid" id="pid" value="${aa.pid }">
	</div>
	
	<!-- 주소 -->
	<div class="field address">
	<b>주소</b>
		<input type="text" name="address" id="address" value="${aa.address }" readonly>
	</div>
	</c:forEach>
	<div class="buttonmove">
	 <button type="submit" class="submitgo">탈퇴하기</button> 
	 <button type="button" class="submitgo" onclick="window.history.back();">이전 화면으로</button>
	</div>
</div>
	
	<!-- 푸터 -->
        <div class="member-footer">
            <div>
                <a href="#none">이용약관</a>
                <a href="#none">개인정보처리방침</a>
                <a href="#none">책임의 한계와 법적고지</a>
                <a href="#none">회원정보 고객센터</a>
            </div>
            <span><a href="#none">Snack Closet.</a></span>
         </div>
</form>
</body>
</html>