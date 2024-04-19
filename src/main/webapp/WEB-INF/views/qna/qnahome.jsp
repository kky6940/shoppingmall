<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');
* {
	margin: 0; 
	padding: 0; 
	box-sizing: border-box; 		
	font-family: 'Noto Sans KR', sans-serif;
	}

.container {
  text-align: center;
  margin-top: 30px;
  margin-left: auto;
  margin-right: auto;
}

h2 {
  margin-bottom: 30px;
  margin-top: 10px;
  font-family: 'Noto Sans KR', sans-serif;
}

.menu_box {
    background-color: #ffffff;
    border: 1px solid transparent;
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    position: relative;
    max-width: 600px;
    width: 90%;
    margin: 0 auto;
}

.nav {
    position: relative;
    display: flex;
    align-items: center;
}

.item {
    padding: 15px 20px;
    margin: 0 10px;
    font-size: 18px;
    color: #83818c;
    font-weight: 500;
    transition: 0.5s;
    flex-shrink: 0;
}

.item:hover {
    color: #51829B;
}

.item.active,
.item.active:hover {
    color: #35374B;
    border-bottom: 2px solid #35374B; /* 활성 메뉴에 밑줄 추가 */
}

.indicator {
    position: absolute;
    left: 0;
    bottom: 0;
    width: var(--widthJS);
    height: 5px;
    background: #B5C0D0;
    border-radius: 8px 8px 0 0;
    transform: translateX(var(--transformJS));
    transition: 0.5s;
}

.myqna {
  background-color: #EAD8C0;
  padding: 20px; 
  border-radius: 10px;
  margin-top: 20px;
  color: #222831;
}

.myqna dl {
  margin-bottom: 20px;
}

.myqna dt {
  font-weight: bold;
  margin-bottom: 20px;
}

.myqna dd {
  margin-left: 10px;
  color: #1B3C73;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<div class="menu_box">
    <nav class="nav">
        <a href="qnahome" class="item active">Home</a>
        <a href="notice" class="item">공지사항</a>
        <a href="qna" class="item">Q&A</a>
        <a href="faq" class="item">FAQ</a>
        <span class="indicator"></span>
    </nav>
</div>
    <c:choose>
        <c:when test="${loginstate == true}">
            <div class="myqna">
                <dl>
                <dt>MY문의 진행현황</dt>
                <dd>
                <span class="count">0</span>
                 건 답변완료,
                <span class="count">0</span>
                건 답변대기중 입니다.
                </dd>
                <a onclick=""></a>
                </dl>
                </div>
        </c:when>
        <c:otherwise> 
            <div class="myqna">
                <dl>
                <dt>MY문의 진행현황</dt>
                <dd>문의를 보기 위해선 로그인 해주세요.</dd>
                <a href="login">로그인</a>
                </dl>
                </div>
        </c:otherwise>
    </c:choose>
</div>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    let navItems = document.querySelectorAll(".item");
    let indicator = document.querySelector(".indicator");

    function changeIndicator(item) {
        let rect = item.getBoundingClientRect();
        indicator.style.setProperty("--transformJS", `${rect.left}px`);
        indicator.style.setProperty("--widthJS", `${rect.width}px`);
    }

    function setActiveItem(item) {
        navItems.forEach((navItem) => navItem.classList.remove("active"));
        item.classList.add("active");
    }

    navItems.forEach((item) =>
        item.addEventListener("click", () => {
            setActiveItem(item);
            changeIndicator(item); 
        })
    );

    // 초기 활성 메뉴 및 indicator 설정
    let activeLink = document.querySelector(".active");
    if(activeLink) {
        changeIndicator(activeLink);
    }
});
</script>
</body>
</html>
