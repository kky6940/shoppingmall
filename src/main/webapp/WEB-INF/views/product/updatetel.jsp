<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../../../../resources/css/update_file.css">
<script type="text/javascript">

function submitUpdatedtel() {
	var tel1 = document.getElementById("tel1").value;
    var tel2 = document.getElementById("tel2").value;
    var updatedTel = "010-" + tel1 + "-" + tel2;

	var updatedTelData = {
            
			updatedTel: updatedTel
            
        };
        
    window.opener.postMessage({ type: 'telUpdate', data: updatedTelData }, '*');
}
</script>
<meta charset="UTF-8">
<title>구매창 연락처 수정</title>
</head>
<body>
<div class="member">
<b><수정할 전화번호를 입력해주세요></b>
<div class="field tel-number">
		<b>휴대전화</b>
    	<input type="text" value="010" readonly="readonly" class="textbox1">
   		<span style="font-size: 20px; font-weight: bold; vertical-align: middle;">-</span>
   		<input type="text" name="tel1" maxlength="4" class="textbox1" id="tel1">
   		<span style="font-size: 20px; font-weight: bold; vertical-align: middle;">-</span>
   		<input type="text" name="tel2" maxlength="4" class="textbox1" id="tel2">
</div>
<input type="button" value="연락처 수정" onclick="submitUpdatedtel()">
</div>
</body>
</html>