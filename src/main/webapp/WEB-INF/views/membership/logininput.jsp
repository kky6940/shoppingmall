<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
/* 전체 폼 컨테이너 스타일 */
.form-container {
    width: 500px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f0f0f0; /* 전체 배경색을 그레이로 설정 */
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1); /* 그림자 효과 추가 */
}

/* 폼 제목 스타일 */
.form-title {
    margin-bottom: 20px;
    text-align: center;
    color: #333; /* 제목 텍스트를 어두운 그레이로 설정 */
}

/* 입력 필드 스타일 */
.form-input {
    width: 100%;
    margin-bottom: 10px;
    padding: 10px;
    border: 1px solid #ccc; /* 입력 필드 테두리를 연한 그레이로 설정 */
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
    
}

.form-button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    background-color: #555;
    color: #fff;
    cursor: pointer;
}

/* 버튼 호버 효과 */
.form-button:hover {
    background-color: #0056b3; /* 호버 시 배경색을 진한 파란색으로 변경 */
}


</style>
</head>
<div class="img_parentsdiv">
<div class="form-container">
    <h2 class="form-title">로그인</h2>
    <form action="logingoing" method="post" >
        <input type="text" name="id" class="form-input" id="id" placeholder="아이디" required>
        <input type="password" name="pw" class="form-input" placeholder="비밀번호" required>
        
        <button type="submit" class="form-button" >로그인</button>
    </form>
</div>
</div>
</body>
</html>