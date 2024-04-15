<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../../../../resources/css/update_file.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#pw_check').on('input', function() {
        var pw = $('#pw').val();
        var pwCheck = $(this).val();

        if (pw !== pwCheck) {
            $('#pw_error').text('비밀번호가 일치하지 않습니다.');
        } else {
            $('#pw_error').text('비밀번호가 일치합니다.');
        }
    });
});

function submitUpdatedPw() {
    var updatedPw = document.getElementById('pw').value;

	var updatedPwData = {
            
			updatedPw: updatedPw
            
        };
        
    // 수정된 이름을 부모 창으로 전달
    window.opener.postMessage({ type: 'pwUpdate', data: updatedPwData }, '*');
}
</script>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
</head>
<body>
<div class="member">

<b><수정할 비밀번호를 입력해주세요></b>
<div class="field">
    <b>비밀번호</b>
	<input type="password" id="pw" name="pw" value="${aa.pw }">
	
</div>
<div class="field">
    <b>비밀번호 재확인</b>
    <input type="password" id="pw_check"><br>
    <span id="pw_error" class="error-message"></span>
</div>
<input type="button" value="비밀번호 수정" onclick="submitUpdatedPw()">
</div>
</body>
</html>