<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');

body {
	width: 100%;
	margin: 0;
	overflow-x: hidden;
	font-family: "Noto Sans KR", sans-serif;
}
a{
	text-decoration: none;
}
a:hover{
	text-decoration: none;
}
p{
	margin: 0;
}
.header_inner{ 
	width: calc(100%-120px);
	min-width: 1280px;
	background: #000;
	padding: 15px 60px;
	margin: 0 auto;
	height: 110px;
	position: relative;
	z-index: 100;
}

.header_logo{
	position: relative;
	float: left;
	height: 80px;
	z-index: 500;
}
.header_logo:after{
	display: inline-block;
}
.header_logo a{
	display:block;
	width: 180px;
	height: 100%;
	background: url("resources/image/img_logo.png") no-repeat;
	vertical-align: middle;
}

.header_util{ 
	float: right;
	
}
.header_util span{ 
	display: inline-block;
	margin-left: 12px;
	padding-left: 12px;
	color: #fff;
	font-size: 13px;
}
.header_util span a{
	color: #fff;
}

.header_gnb{
	position: absolute;
	display: flex;
	justify-content: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	margin-top: 26px;
	padding: 6px; 
	width: 100%;
	text-align: center;
}
.header_gnb2{
	position: absolute;
	top: 50%;
	left: 92%;
	transform: translate(-50%, -50%);
	margin-top: 26px;
	padding: 6px; 
	width: 300px;
	text-align: center;
	padding-right: 50px;
	z-index: 1;
}

.header_gnb2 label{
	background: url("./image/ico_search.png") no-repeat center;
	display: inline-block;
	width: 30px;
	height: 27px;
	margin: 0;
	vertical-align: bottom;
	cursor: pointer;
}

.gnb_category {
	display: inline-block;
}
.gnb_category a{
	color: #fff; 
	margin-left:15px;
	padding: 17px 10px;
	font-size: 17px;
	font-weight: 600;

}
.depth2{
	position: absolute;
	top: 45px;
	left: 0;
	width: 100%;	
	padding: 20px;
	background: #fff;
    opacity: 0; /* 초기에 투명하게 설정 */
    pointer-events: none; /* 해당 요소에 마우스 이벤트 비활성화 */
} 

.gnb_category:hover .depth2 {
    opacity: 1; /* 마우스를 올릴 때 투명도를 1로 변경하여 보이도록 함 */
    pointer-events: auto; /* 마우스 이벤트 활성화 */
    
}

.depth2 a{
	color: #000;
	font-size: 14px;
	font-weight: 400;
}

.gray{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 20px;
    background: #000;
    z-index: 99;
    opacity: 0; /* 초기에 투명하게 설정 */
    display: none;
}
.fix_btn{
	position: fixed;
	z-index: 50;
	right: 0;
	bottom: 0;
	background-color: #000;
	border-radius: 20px 0 0 0;
}
.fix_btn button{
	width: 60px;
	height: 60px;
	vertical-align: middle;
	border: none;
	margin: 0 5px;
}
.rouletteBtn{
	background: url("./image/ico_roulette.png") center no-repeat;
	background-size: 35px 40px;
}
.topBtn{
	background: url("./image/ico_top.png") center no-repeat;
	background-size: 40px 40px;
}



</style>
</head>
<body>
<div class="header_inner">
	<div class="header_logo">
		<a href="main"></a>
	</div>
	<div class="header_util">
		<c:choose>
			<c:when test="${loginstate == false }">
				<span><a href="login">로그인</a></span>
				<span><a href="membershipjoin2">회원가입</a></span>
				<span><a href="login">장바구니</a></span>
				<span><a href="qnahome">고객센터</a></span>
			</c:when>
			<c:otherwise>
				<span><a href="logout">로그아웃</a></span>
				<span><a href="mypage">마이페이지</a></span>
				<span><a href="basketout">장바구니</a></span>
				<span><a href="qnahome">고객센터</a></span>
				<c:if test="${id eq 'admin' }">
					<span><a href="adminpagemain">관리자페이지</a></span>
				</c:if>		
			</c:otherwise>	
		</c:choose>

	</div>
	<div class="header_gnb">
		<div class="gnb_category">
			<a href="">인기</a>
		</div>
		<div class="gnb_category">
			<a href="product_list?stype=상의" class="gnb_categorylist">상의</a>
			<div class="depth2">
				<a href="" class="depth2_list">맨투맨</a>
				<a href="" class="depth2_list">후드티</a>
				<a href="" class="depth2_list">반소매 티셔츠</a>
				<a href="" class="depth2_list">셔츠/블라우스</a>
			</div>
		</div>
		<div class="gnb_category">
			<a href="">바지</a>
			<div class="depth2">
				<a href="" class="depth2_list">데님팬츠</a>
				<a href="" class="depth2_list">쇼트팬츠/슬랙스</a>
				<a href="" class="depth2_list">트레이닝/조거팬츠</a>
				<a href="" class="depth2_list">숏팬츠</a>
			</div>
		</div>
		<div class="gnb_category">
			<a href="">아우터</a>
			<div class="depth2">
				<a href="" class="depth2_list">후드집업</a>
				<a href="" class="depth2_list">카디건</a>
				<a href="" class="depth2_list">코트</a>
				<a href="" class="depth2_list">블루종</a>
			</div>
		</div>
		
		<div class="gnb_category">
			<a href="">모자</a>
			<div class="depth2">
				<a href="" class="depth2_list">캡/야구모자</a>
				<a href="" class="depth2_list">비니</a>
				<a href="" class="depth2_list">헌팅캡/베레모</a>
				<a href="" class="depth2_list">페도라</a>
			</div>
		</div>
		
		<div class="gnb_category">
			<a href="">입력</a>
			<div class="depth2">
				<a href="productinput" class="depth2_list" >입력</a>
				<a href="productout" class="depth2_list">출력</a>
				<a href="bestproductout" class="depth2_list">베스트상품</a>
				<a href="recommendout" class="depth2_list">추천상품</a>
			</div>
		</div>
	</div>
	<form action="gnb_search" method="get">
		<div class="header_gnb2">
			<div class="gnb_category">
				<input type="text" name="sname" class="gnb_searchBar">
				<label for="gnb_submit"> </label>
				<input type="submit" id="gnb_submit" value="전송" style="display: none;">
			</div>
		</div>
	</form>
</div>
<div class="gray"></div>

<div class="fix_btn">
	<button type="button" onclick="location.href='roulette'" class="rouletteBtn"></button>
	<button type="button" onclick="gotop()" class="topBtn"></button>
</div>
<script>
    // JavaScript로 hover 이벤트 처리
    var gnbCategories = document.querySelectorAll('.gnb_category');
    var grayDivs = document.querySelectorAll('.gray');
    var timer;

    // 각 카테고리에 대한 이벤트 리스너 등록
    gnbCategories.forEach(function(category) {
        category.addEventListener('mouseenter', function() {
            // 불투명도 변경을 지연시킵니다.
            clearTimeout(timer);
            timer = setTimeout(function() {
                grayDivs.forEach(function(grayDiv) {
                    grayDiv.style.opacity = '0.7';
                    grayDiv.style.display = 'block';
                    
                });
            }); // 필요한 만큼 지연 시간을 조절합니다.
        });

        category.addEventListener('mouseleave', function() {
            // 불투명도 변경을 지연시킵니다.
            clearTimeout(timer);
            timer = setTimeout(function() {
                grayDivs.forEach(function(grayDiv) {
                    grayDiv.style.opacity = '0';
                    grayDiv.style.display = 'none';

                });
            }, 100); // 필요한 만큼 지연 시간을 조절합니다.
        });
    });
    
    function gotop() {
    	window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
	}
</script>
</body>
</html>