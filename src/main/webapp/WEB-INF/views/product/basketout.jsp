<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
<form id="formselect" method="post"> <!-- 하단 버튼과 자바스크립트로 form 장소 선택 -->
    <table border="1" width="700px" align="center">
        <tr>
            <th>선택</th>
            <th>상품이미지</th>
            <th>상품명</th>
            <th>상품사이즈</th>
            <th>상품수량</th>
            <th>상품가격</th>
            <th>주문관리</th>
        </tr>
            <div>
                <c:forEach items="${list }" var="aa">
                    <tr>
                        <td>
                            <input type="checkbox" name="item" value="${aa.basketnum }">
                            <input type="hidden" name="basketnum" value="${aa.basketnum }">
                        </td>
                        
                        <td>
                            <a href="detailview?snum=${aa.snum}">
                            <img alt="" src="./image/${aa.image }" width="60px" height="60px">
                            </a>
                            <input type="hidden" name="image" value="${aa.image }"> 
                        </td>
                        <td>
                        	<a href="detailview?snum=${aa.snum}">
                            <span>${aa.sname }</span>
                            </a>
                            <input type="hidden" name="sname" value="${aa.sname }">
                            
                        </td>
                        <td>
                            <span>${aa.ssize }</span>
                            <input type="hidden" name="ssize" value="${aa.ssize }">
                        </td>
                        <td>
                            <span>${aa.guestbuysu }</span>
                            <input type="hidden" name="guestbuysu" value="${aa.guestbuysu }">
                        </td>
                        <td>
                            <span><f:formatNumber value="${aa.totprice }" pattern="#,###원"/></span>
                            <input type="hidden" name="totprice" value="${aa.totprice }">
                            <input type="hidden" name="snum" value="${aa.snum }">
                            <input type="hidden" name="stype" value="${aa.stype }">
                        </td>
                       <td align="center">
	                		<input type="button" value="목록삭제" onclick="submitbasketdelete()">
	                		<input type="button" value="구매하기" onclick="submitbasketsell()">
	                	</td>
                    </tr>
                    </c:forEach>
                    <tr>
                    	<td colspan="7" align="left">
                    		<input type="button" value="전체 선택" onclick="toggleCheckboxtrue()">
							<input type="button" value="전체 해제" onclick="toggleCheckboxfalse()">
                    	</td>
                    </tr>
               </div>     
	 </table>    
				
            <div>
		    <!-- 페이징처리 -->
			<table align="center">
				<tr style="border-left: none;border-right: none;border-bottom: none">
				   <td colspan="7" style="text-align: center;">
				   
				   <c:if test="${paging.startPage!=1 }"> 
				      <a href="basketout?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a> 
				      
				   </c:if>   
				   
				      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
				         <c:choose>
				            <c:when test="${p == paging.nowPage }"> 
				               <b><span style="color: red;">${p}</span></b>
				            </c:when>   
				            <c:when test="${p != paging.nowPage }"> 
				               <a href="basketout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
				            </c:when>   
				         </c:choose>
				      </c:forEach>
				     
				      <c:if test="${paging.endPage != paging.lastPage}">
				      <a href="basketout?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
				   </c:if>
				   
				   </td>
				</tr>
			</table>
			<!-- 페이징처리 -->
			</div>
   
    
   <script>
	   // 각각 다른 submit을 실행 하기 위한 자바스크립트문
		function submitbasketdelete() {
			if (confirm("정말로 삭제하시겠습니까?")) {
			    var form = document.getElementById('formselect');
			    form.action = 'basketdelete';
			    form.submit();
			}
		}
		
		function submitbasketsell() {
		    var form = document.getElementById('formselect');
		    form.action = 'basketsell';
		    form.submit();
		}
		
		// 체크박스 전체 선택 및 해제
		function toggleCheckboxtrue() {
		    var checkbox = document.querySelectorAll('input[type="checkbox"]');
		    var selectAllCheckbox = document.querySelector('input[value="전체 선택"]');
		    
		    if (selectAllCheckbox.value === "전체 선택") {
		        for (var i = 0; i < checkbox.length; i++) {
		            checkbox[i].checked = true;
		        }
		    } 
		}
		
		function toggleCheckboxfalse() {
			 var checkbox = document.querySelectorAll('input[type="checkbox"]');
			 var selectAllCheckbox = document.querySelector('input[value="전체 해제"]');
			 
			 if (selectAllCheckbox.value === "전체 해제") {
			        for (var i = 0; i < checkbox.length; i++) {
			        	checkbox[i].checked = false;
			        }
			 }
		}
		
	</script>

</form>
</body>
</html>
