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
<form action="basketsell" method="post"> <!-- 판매 페이지로 이동 -->
    <table border="1" width="700px" align="center">
        <tr>
            <th>선택</th>
            <th>순번</th>
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
                        </td>
                        <td>
                            <span>${aa.basketnum }</span>
                        </td>
                        <td>
                            <a href="detailview?snum=${aa.snum}">
                            <img alt="" src="./image/${aa.image }" width="60px" height="60px">
                            <input type="hidden" name="image" value="${aa.image }"> 
                        </td>
                        <td>
                            <span>${aa.sname }</span>
                            <input type="hidden" name="sname" value="${aa.sname }">
                            </a>
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
                        <td colspan="5" align="center">
                            <input type="submit" value="구매하기">
                            <input type="button" value="목록삭제">
                        </td>
                    </tr>
                </c:forEach>
            </div>
            <div>
		    <!-- 페이징처리 -->
			
				<tr style="border-left: none;border-right: none;border-bottom: none">
				   <td colspan="8" style="text-align: center;">
				   
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
			
			<!-- 페이징처리 -->
			</div>
    </table>
    
</form>
</body>
</html>
