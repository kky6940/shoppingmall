<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
//<!--
//
// LCC DFS 좌표변환을 위한 기초 자료
//
var RE = 6371.00877; // 지구 반경(km)
var GRID = 5.0; // 격자 간격(km)
var SLAT1 = 30.0; // 투영 위도1(degree)
var SLAT2 = 60.0; // 투영 위도2(degree)
var OLON = 126.0; // 기준점 경도(degree)
var OLAT = 38.0; // 기준점 위도(degree)
var XO = 43; // 기준점 X좌표(GRID)
var YO = 136; // 기1준점 Y좌표(GRID)
//
// LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
//


function dfs_xy_conv(code, v1, v2) {
    var DEGRAD = Math.PI / 180.0;
    var RADDEG = 180.0 / Math.PI;

    var re = RE / GRID;
    var slat1 = SLAT1 * DEGRAD;
    var slat2 = SLAT2 * DEGRAD;
    var olon = OLON * DEGRAD;
    var olat = OLAT * DEGRAD;

    var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);
    var rs = {};
    if (code == "toXY") {
        rs['lat'] = v1;
        rs['lng'] = v2;
        var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);
        var theta = v2 * DEGRAD - olon;
        if (theta > Math.PI) theta -= 2.0 * Math.PI;
        if (theta < -Math.PI) theta += 2.0 * Math.PI;
        theta *= sn;
        rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
        rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
    }
    else {
        rs['x'] = v1;
        rs['y'] = v2;
        var xn = v1 - XO;
        var yn = ro - v2 + YO;
        ra = Math.sqrt(xn * xn + yn * yn);
        if (sn < 0.0) - ra;
        var alat = Math.pow((re * sf / ra), (1.0 / sn));
        alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        if (Math.abs(xn) <= 0.0) {
            theta = 0.0;
        }
        else {
            if (Math.abs(yn) <= 0.0) {
                theta = Math.PI * 0.5;
                if (xn < 0.0) - theta;
            }
            else theta = Math.atan2(xn, yn);
        }
        var alon = theta / sn + olon;
        rs['lat'] = alat * RADDEG;
        rs['lng'] = alon * RADDEG;
    }
    return rs;
}



function getLocation() {
	// 사용자에게 위치 정보 제공 요청하기
    if (navigator.geolocation) {
        var permission = confirm("이 웹사이트에서는 현재 위치 정보를 사용합니다. 위치 정보를 허용하시겠습니까?");
        
        if (permission) { // 위치 정보 제공 요청 승인하면
        	// geolocation GPS API 실행
        	navigator.geolocation.getCurrentPosition(function(position) {
                showPosition(position); // 위치 정보를 표시하는 함수 호출
                sendLocation(position); // 날씨 API에 위치 정보 전달 함수 호출
            }, showError);
        } else {
            var locationElement = document.getElementById("location");
            locationElement.innerHTML = "사용자가 위치 정보 제공을 거부했습니다.";
            console.log("사용자가 위치 정보를 거부했습니다.");
        }
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}

// GPS API 정보 중 x(Latitude:위도)와 y(Longitude:경도) 값 추출 
function showPosition(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    
    var locationElement = document.getElementById("location");
    locationElement.innerHTML = "Latitude: " + latitude + ", Longitude: " + longitude;
}

// 위치 정보 요청을 거부 했을 경우 보이는 메세지 설정
function showError(error) {
	// 화면
    var locationElement = document.getElementById("location");
    locationElement.innerHTML = "사용자가 위치 정보 제공을 거부했습니다.";
    
    // 콘솔 
    switch(error.code) {
        case error.PERMISSION_DENIED:
            console.log("User denied the request for Geolocation.");
            break;
        case error.POSITION_UNAVAILABLE:
            console.log("Location information is unavailable.");
            break;
        case error.TIMEOUT:
            console.log("The request to get user location timed out.");
            break;
        case error.UNKNOWN_ERROR:
            console.log("An unknown error occurred.");
            break;
    }
}

// 페이지 로드 시 GPS API 및 위치 정보 가져오기 실행
window.onload = function() {
    getLocation();
};

// 날씨 API에 위치 정보 전달
function sendLocation(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    
    var convertedCoords = dfs_xy_conv("toXY", latitude, longitude);
    var convertedLatitude = convertedCoords.x; // 위도에 해당하는 x 값
    var convertedLongitude = convertedCoords.y; // 경도에 해당하는 y 값
    
    // AJAX 요청 보내기
    $.ajax({
        type: "POST",
        url: "bestproductoutweatherview",
        contentType: "application/json",
        data: JSON.stringify({ "convertedLatitude": convertedLatitude, "convertedLongitude": convertedLongitude }),
        success: function(response) {
            alert("서버로부터 응답을 받았습니다: " + response);
        },
        error: function(xhr, status, error) {
            alert("에러 발생: " + error);
        }
    });
}
</script>
<meta charset="UTF-8">
<title>베스트 상품 보기</title>
</head>
<body>
<div id="location">위치 정보를 가져오는 중...</div>

</body>
</html>
