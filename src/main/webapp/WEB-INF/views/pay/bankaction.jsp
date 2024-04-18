<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.bankDiv{ 
	text-align: center;
    border: 2px solid gray;
    width: 400px;
    top: 30%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 24px;
    position: absolute;
    padding: 10px 10px;
}
</style>
</head>
<body>

<div class="bankDiv">
	<p>${bankChoice}은행</p>	
	<p>${account} 입금부탁드립니다.</p>
	<p>ㅠㅠㅠ</p>
</div>
</body>
</html>