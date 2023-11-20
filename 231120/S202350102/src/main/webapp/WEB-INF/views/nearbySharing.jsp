<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
      .map_wrap,
      .map_wrap * {
        margin: 0;
        padding: 0;
        font-size: 12px;
      }
      .map_wrap a,
      .map_wrap a:hover,
      .map_wrap a:active {
        color: #000;
        text-decoration: none;
      }
      .map_wrap {
        position: relative;
        width: 100%;
        height: 500px;
      }

      #menu_wrap {
        top: 0;
        left: 0;
        bottom: 0;
        width: 80%;
        display: inline-block;
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        overflow-y: auto;
        background: rgba(255, 255, 255, 0.7);
        z-index: 1;
        font-size: 12px;
        border-radius: 10px;
      }
      .bg_white {
        background: #fff;
      }
      #menu_wrap hr {
        display: block;
        height: 1px;
        border: 0;
        border-top: 2px solid #5f5f5f;
        margin: 3px 0;
      }
      #menu_wrap .option {
        text-align: center;
      }
      #menu_wrap .option p {
        margin: 10px 0;
      }
      #menu_wrap .option button {
        margin-left: 5px;
      }
      #placesList {
        padding-left: 0px;
      }
      #placesList li {
        list-style: none;
      }
      #placesList .item {
        position: relative;
        border-bottom: 1px solid #888;
        overflow: hidden;
        cursor: pointer;
        min-height: 65px;
      }
      #placesList .item span {
        display: block;
        margin-top: 4px;
      }
      #placesList .item h5,
      #placesList .item .info {
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
      }
      #placesList .item .info {
        padding: 10px 0 10px 55px;
      }
      #placesList .info .gray {
        color: #8a8a8a;
      }
	      #placesList .info .jibun {
        padding-left: 26px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
          no-repeat;
      }
      #placesList .info .tel {
        color: #009900;
      }
      #placesList .item .markerbg {
        float: left;
        width: 36px;
        height: 37px;
        margin: 10px 0 0 10px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
          no-repeat;
      }
      #placesList .item .marker_1 {
        background-position: 0 -10px;
      }
      #placesList .item .marker_2 {
        background-position: 0 -56px;
      }
      #placesList .item .marker_3 {
        background-position: 0 -102px;
      }
      #placesList .item .marker_4 {
        background-position: 0 -148px;
      }
      #placesList .item .marker_5 {
        background-position: 0 -194px;
      }
      #placesList .item .marker_6 {
        background-position: 0 -240px;
      }
      #placesList .item .marker_7 {
        background-position: 0 -286px;
      }
      #placesList .item .marker_8 {
        background-position: 0 -332px;
      }
      #placesList .item .marker_9 {
        background-position: 0 -378px;
      }
      #placesList .item .marker_10 {
        background-position: 0 -423px;
      }
      #placesList .item .marker_11 {
        background-position: 0 -470px;
      }
      #placesList .item .marker_12 {
        background-position: 0 -516px;
      }
      #placesList .item .marker_13 {
        background-position: 0 -562px;
      }
      #placesList .item .marker_14 {
        background-position: 0 -608px;
      }
      #placesList .item .marker_15 {
        background-position: 0 -654px;
      }
      #pagination {
        margin: 10px auto;
        text-align: center;
      }
      #pagination a {
        display: inline-block;
        margin-right: 10px;
      }
      #pagination .on {
        font-weight: bold;
        cursor: default;
        color: #777;
      }
      #keyword {
        padding: 12px;
        border-radius: 16px;
        border: none;
      }
      .button{
        padding: 12px;
        border-radius: 16px;
        border: none;
        background: linear-gradient(to bottom right, blue, pink);
        color: #ffffff;
      }
    </style>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9fb99f45a47c1c87ebbcfc532e1f831f&libraries=services"></script>
</head>
<body>


    <!-- HEADER -->
    <section class=" pb-8">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-12 col-md-10 col-lg-8 col-xl-6">

            <!-- Heading -->
            <h3 class="mb-5 text-center">내주변 쉐어링</h3>
			<p class="mb-0 text-muted">검색어를 입력하면 지도 상에서 해당 지역에 등록된 물품이 마커로 표시됩니다.</p>
            <!-- Search -->
            
          </div>
        </div>
      </div>
    </section>
<body style="width: 100%; height: 100%; margin: 0 0 0 0">
    <div
      class="side_bar"
      style="
        width: 30%;
        height: 100%;
        background-color: white;
        float: left;
        text-align: center;
      "
    >
    <button onclick="getLocation()">내 위치</button>

<p id="pos"></p>
      <div id="menu_wrap" class="bg_white">
        <div class="option">
          <div>
            <form onsubmit="searchPlaces(); return false;">
              <div class="input-group input-group-merge">
              <input class="form-control" type="search" id="keyword" name="keyword" placeholder="검색어를 입력해주세요.">
              <div class="input-group-append">
                <button class="btn btn-outline-border" type="submit" style="margin-left: 0px;">
                  <i class="fe fe-search"></i>
                </button>
              </div>
            </div>
            </form>
          </div>
        </div>
        <hr />
        <ul id="placesList"></ul>
        <div id="pagination"></div>
      </div>
    </div>

    <div
      class="map_wrap"
      id="map"
      style="width: 65%; height: 100%; position: relative; overflow: hidden"
    ></div>


<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.5605672, 126.9433486), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 마커생성
var markerPosition  = new kakao.maps.LatLng(37.5605672, 126.9433486); 

var marker = new kakao.maps.Marker({
    position: markerPosition
});

//마커 지도에 추가


// 마커 배열에 추가
markers.push(marker);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});


</script>	



<script>
var x = document.getElementById("pos");
var map = null;

function getLocation() {
    navigator.geolocation.getCurrentPosition(showPosition);
}

function showPosition(position) {
    x.innerHTML = "Latitude: " + position.coords.latitude + 
    "<br>Longitude: " + position.coords.longitude;

    // 지도에 마커 표시
    if (!map) {
        // 지도를 생성할 때 한 번만 실행
        map = new kakao.maps.Map(document.getElementById('map'), {
            center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude),
            level: 15 // 지도의 확대 레벨
        });
    }

    var markerPosition = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);

    // 기존 마커 제거
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.BICYCLE);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.HYBRID);
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.USE_DISTRICT);

    // 새로운 마커 추가
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커 지도에 추가
    marker.setMap(map);
}
</script>
</script>
	
	


</body>
<%@ include file="footer.jsp" %>
</html>