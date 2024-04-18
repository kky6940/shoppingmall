<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{  
  
  padding: 0;
  margin: 0;
  width: 100%;
  height: 100%;
}
h3{
	text-align: center;
}
input[type="text"],
input[type="number"]{
    width: 330px;
    padding: 4px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    display: inline-block;
    margin-bottom: 5px;
}

.product_sellform2 input[type="text"],
.product_sellform2 input[type="number"]{
    width: 200px;
    padding: 4px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    display: inline-block;
    margin-bottom: 5px;
}


label{
	display: block;
    max-width: 100%;
    margin: 2px 0 2px 0;
    font-weight: 700;	
    vertical-align: middle;
    
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.product_sell{
 	margin-top: 24px;
	width: 100%; 
	min-width:1650px;
	position:absolute;
	display:flex;
    justify-content: center;
}
.product_sellform{
  	background-color: #fff;
	border-radius: 9px;
  	width: 706px;
  	height: auto;
	border:1px solid #808080;
	position: relative;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	padding: 0 20px 0 20px;
	margin-bottom: 100px;
}
.product_sellform2{
  	background-color: #fff;
	border-radius: 9px;
  	width: 300px; 
  	height: 420px;
	border:1px solid #808080;
	position: relative;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	padding: 0 20px 0 20px;
	margin-left: 20px;
	
}
.product_view{
	display: flex;
	margin: 7px 0;
}
.product_view p{
	margin: 7px;
	font-size: 16px;
}
.input_group{
	margin: 8px 0; 
}

.btn1{ 
	min-width: 80px; 
	height: 30px;
    padding: 0 10px;
    line-height: 28px;
    font-size: 12px;
    border-radius: 2px;
    background-color: #333;
    color: white;
}
#submit_btn{
	min-width: 150px; 
	height: 40px;
    padding: 0 10px;
    line-height: 28px;
    border-radius: 2px;
    background-color: #333;
    color: white;
    position: absolute;
    bottom: 12px;
    left: 74px;
    font-size: 17px;
    font-weight: 500;
}
#savepoint, #price, #saleprice,
#totprice, #availablePoint{
	background-color: white; 
	border: none;
}
#point {
	width: 250px; 
}
#address1, #address2{
	min-width: 430px;
}
.request{
	width: 300px;
	height: 30px;
}
#payment{
	display: inline-block;
	font-weight: 400;
	margin-top: -5px;
	font-size: 15px;
	margin-right: 10px;
}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<form action="productsell" method="post">
<div class="product_sell">
  <div class="product_sellform">
      <h3>주문 / 결제</h3>
      <div class="input_group">
          	  <button type="button" class="btn1" onclick="openAddressPopup()">배송지 목록</button>
      
      	  <input type="hidden" value="${rank }" id="rank">
      	  <label for="name">이름</label> 
      	  <input type="text" name="name" id="name" >
      	  <label for="tel">연락처</label>
      	  <input type="text" name="tel" id="tel" >
	      <label for="snum">배송지</label>
	      
	      <input type="text" name="postcode" class="form-input3" id="postcode" placeholder="우편번호">
		  <input type="button" class="btn1" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
		  <input type="text" name="address1" class="form-input" id="address1" placeholder="주소"><br>
		  <input type="text" name="address2" class="form-input" id="address2" placeholder="상세주소">
      </div>
     
     <div class="input_group">
     	<label>주문시 요청사항</label>
		<select name="request" class="request">
			<option value="부재">부재시 연락주세요</option>
			<option value="경비실">경비실에 보관해주세요</option>
			<option value="문앞">문앞에 놓아주세요</option>
		</select>
     </div>
     
    <div class="input_group">
	      <label>주문상품</label>
	      <c:forEach items="${list }" var="aa">
	      <div class="product_view">
	      <div>
		  	<c:set var="imageArray" value="${fn:split(aa.productdto.image, ', ')}" />
						<c:forEach items="${imageArray}" var="imageName" varStatus="loop">
		   					<c:if test="${loop.index == 0}">
		       					<img alt="" src="./image/${imageName}" width="70px" height="70px">
		   					</c:if>
			</c:forEach>
		  	</div>
		  	<div>
		  	<p>${aa.productdto.getSname() }</p>
		  	<p style="font-size: 14px; color: gray;">색상 : ${aa.color} / 사이즈 : ${aa.psize} / 수량 : ${aa.guestbuysu} </p>
	      	
	      	</div>
	      </div>
	      </c:forEach>
      </div>
      <div class="input_group">
	      <label>쿠폰</label>
	      <div class="coupon">
	      	<input type="text" name="useCoupon" id="useCoupon" onchange="couponPrice()" value="쿠폰사용안함" readonly="readonly"> 
	      	<button type="button" class="btn1" onclick="openCouponPopup()">쿠폰 목록</button>
	      </div>
	      <label>포인트</label>
	      <div class="point">
	      	<p>보유 포인트 : <input type="text" id="availablePoint" value="${point }" readonly="readonly"> </p>
			<p style="display: inline-block;">사용 포인트 : <input type="text" id="point" name="point"  oninput="pointsPrice()" onchange=""></p>
	      	<button type="button" class="btn1" onclick="allPointsPrice()">전액 사용</button>
	      </div>
      </div>
      
  </div>
  <div class="product_sellform2">
  	 <div class="input_group">
	      <div class="sell">
		        <label>주문 금액</label>	      
	      		<input type="text" value="${totprice }" id="totprice" name="totprice" readonly="readonly" >
	      		<label>할인 금액</label>
	      		<input type="text" value="0" id="saleprice" name="saleprice" readonly="readonly">
	      		
	      		<div id="detailSale"></div>
	      		
	      		<label>최종 금액</label>
	      		<input type="text" value="${totprice }" id="price" name="price" readonly="readonly" >
	      		<label>포인트 적립</label>
	      		<input type="text" value="" id="savepoint" name="savepoint" readonly="readonly">
	     		<label for="">결제방식</label>	     			
					<input type="radio" id="bank" value="무통장입금" name="payment" style="width: 17px;">
					<label for="bank" id="payment">무통장입금</label>
					<input type="radio" id="kakaopay" value="카카오페이" name="payment" style="width: 17px;">
					<label for="kakaopay" id="payment"><img alt="" src="./image/ico_kakaopay.png" width="52px" height="23px">카카오페이</label>
				<br>
				<input type="submit" value="결 제" id="submit_btn">
      	  </div>
  </div> 
</div>
</div>
</form>
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
    // 임의의 총 가격 값, 실제 사용 시에는 서버로부터 받아오거나 계산하여 설정
    var totPrice = document.getElementById('totprice').value;
    var availablePoint = document.getElementById('availablePoint').value;
    var rank = document.getElementById('rank').value;
    var savepoint = totPrice * 0.01;
    
    var  rankdiscount = rankDiscount(totPrice, rank);
    var  finalPrice = totPrice - rankdiscount;

    // 입력 필드에 값을 설정
    document.getElementById('totprice').value = numberWithCommas(totPrice);
    document.getElementById('price').value = numberWithCommas(totPrice);
    document.getElementById('availablePoint').value = numberWithCommas(availablePoint);
    document.getElementById('savepoint').value = numberWithCommas(savepoint);
    document.getElementById('saleprice').value = numberWithCommas(rankdiscount);
    document.getElementById('price').value = numberWithCommas(finalPrice);
    
    if(rankdiscount>0){
	    document.getElementById('detailSale').innerHTML = "<p>&nbsp;ㄴ 등급할인 -" + numberWithCommas(rankdiscount) + " </p>";
    }
    
});
//rank ,totPrice전역변수
var rank = document.getElementById('rank').value;   
var totPrice = document.getElementById('totprice').value;


document.getElementById('point').addEventListener('focus', function() {
    if (this.value === '0') {
        this.value = '';
    }
});

function rankDiscount(price, rank) {
    const discounts = {1: 0, 2: 0.02, 3: 0.03, 4: 0.04, 5: 0.05};
    return price * discounts[rank];
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function pointsPrice() {
    var availablePoint = parseInt(document.getElementById('availablePoint').value.replace(/,/g, ''), 10);
    var pointInput = document.getElementById('point').value;
    var usedPoint = pointInput.replace(/,/g, '').trim(); // 콤마 제거 및 양쪽 공백 제거
    
    if (usedPoint === '' || isNaN(usedPoint)) {
        usedPoint = 0;
        document.getElementById('point').value = '0'; // 입력 필드에 '0' 표시
    } else {
        usedPoint = parseInt(usedPoint, 10);
    }

    // 사용 가능 포인트를 초과하지 않도록 조정
    if (usedPoint > availablePoint) {
        usedPoint = availablePoint;
    }
    
    document.getElementById('point').value = numberWithCommas(usedPoint);
   
    var rankdiscount = rankDiscount(totPrice, rank);
    var coupondiscount = couponPrice();
  	var salePrice = coupondiscount
  	salePrice += rankdiscount;
    
    var maxUsablePoints = totPrice - salePrice;
    if (usedPoint > maxUsablePoints) {
        usedPoint = maxUsablePoints;
    }
    document.getElementById('point').value = numberWithCommas(usedPoint);

    salePrice += usedPoint;
    var finalPrice = totPrice - salePrice;
    
    
    // 할인 금액과 최종 금액 업데이트
    document.getElementById('saleprice').value = numberWithCommas(salePrice);
    document.getElementById('price').value = numberWithCommas(finalPrice);
    if(rankdiscount>0){
	    document.getElementById('detailSale').innerHTML = "<p>&nbsp;ㄴ 등급할인 -" + numberWithCommas(rankdiscount) + " </p>";
    }
    if(coupondiscount>0){
    	document.getElementById('detailSale').innerHTML += "<p>&nbsp;ㄴ 쿠폰할인 -" + numberWithCommas(coupondiscount) + " </p>";    	
    }
    if(usedPoint>0){
    	document.getElementById('detailSale').innerHTML += "<p>&nbsp;ㄴ 포인트할인 -" + numberWithCommas(usedPoint) + " </p>";    	    	
    }
    

}


function allPointsPrice() {
	var salePrice = 0;
	var availablePoint = parseInt(document.getElementById('availablePoint').value.replace(/,/g, ''), 10);
	var usedPoint = availablePoint; // 바로 숫자로 사용
    var totPrice = parseInt(document.getElementById('totprice').value.replace(/,/g, ''), 10);
	console.log(salePrice);
	
	 var rankdiscount = rankDiscount(totPrice, rank);
	 var coupondiscount = couponPrice();
	 salePrice = coupondiscount
	 salePrice += rankdiscount;
    // 최대 사용 가능 포인트 계산
    var maxUsablePoints = totPrice - salePrice;
    if (usedPoint > maxUsablePoints) {
        usedPoint = maxUsablePoints;
    }
    document.getElementById('point').value = numberWithCommas(usedPoint);

    salePrice += usedPoint;
    var finalPrice = totPrice - salePrice;

    // 할인 금액과 최종 금액 업데이트
    document.getElementById('saleprice').value = numberWithCommas(salePrice);
    document.getElementById('price').value = numberWithCommas(finalPrice);
    if(rankdiscount>0){
	    document.getElementById('detailSale').innerHTML = "<p>&nbsp;ㄴ 등급할인 -" + numberWithCommas(rankdiscount) + " </p>";
    }
    if(coupondiscount>0){
    	document.getElementById('detailSale').innerHTML += "<p>&nbsp;ㄴ 쿠폰할인 -" + numberWithCommas(coupondiscount) + " </p>";    	
    }
    if(usedPoint>0){
    	document.getElementById('detailSale').innerHTML += "<p>&nbsp;ㄴ 포인트할인 -" + numberWithCommas(usedPoint) + " </p>";    	    	
    }
    
}
	
function couponPrice() {
    var totPrice = parseInt(document.getElementById('totprice').value.replace(/,/g, ''), 10); // 콤마 제거 후 정수 변환
    var couponValue = document.getElementById('useCoupon').value;
    var discount = 0;

    if (couponValue.endsWith('% 할인쿠폰')) {
        var percentage = parseInt(couponValue);
        console.log(percentage);
        discount = totPrice * (percentage / 100);
    } else if (couponValue.endsWith('원 할인쿠폰')) {
        discount = parseInt(couponValue);
    }
    else if (couponValue.endsWith('적용안함')) {
        discount = 0
    }
    return discount;
}

function openAddressPopup() {
    var popup = window.open("addressPopup", "Address Popup", "width=600,height=400");
    popup.focus();
}
function openCouponPopup() {
    var popup = window.open("couponPopup", "Coupon Popup", "width=550,height=500");
    popup.focus();
}

//주소API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

        

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>
</body>
</html>