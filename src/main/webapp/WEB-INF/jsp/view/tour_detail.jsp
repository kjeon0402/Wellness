<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/tour_detail.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<style>

</style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />
<!-- tour detail wrap -->
<div class="tour_detail_wrap">
	<!-- image wrap -->
	<div class="image_wrap wrap">
		<div class="detail_img_div">
		<c:if test="${empty detailImgVO }">
			<c:forEach items="${detailImgVOList }" var="detailImgVO_list">
				<div style="width: 100%;"><img class="slider_obj" src="${root }/tourimg/${detailImgVO_list.img_path }"></div>
			</c:forEach>
		</c:if>
		<c:if test="${not empty detailImgVO }">
				<img class="slider_obj" src="${root }/tourimg/${detailImgVO.img_path }">
		</c:if>
		</div>
	</div>
	<c:if test="${empty detailImgVO }">
		<div class="slide_controller">
			<button class="prev_btn" style="background-image: url('${root}/img/view/tour/prev_btn.svg');" onclick="prevBtn(event)"></button>
			<button class="next_btn" style="background-image: url('${root}/img/view/tour/next_btn.svg');" onclick="nextBtn(event)"></button>
<!-- 			<div class="reservation_wrap wrap"> -->
		<div class="rsv_how_div"><button onclick="popHandler()">예약방법</button></div>
		<div class="rsv_how_pop hidden">
			<div class="rsv_title">예약방법</div>
			<div class="rsv_page">
				<div class="rsv_page_address"><input id="adr" type="text" value="${detailVO.tour_site }" readonly></div>
				<div class="rsv_page_btn"><button onclick="copyABtn()">복사</button></div>
			</div>
			<div class="rsv_tel">
				<div class="rsv_tel_num"><input id="tnum" type="text" value="${detailVO.tour_tel }" readonly></div>
				<div class="rsv_tel_btn"><button onclick="copyTBtn()">복사</button></div>
			</div>
		</div>
		<div class="overlay_for_pop hidden" onclick="popHandler()"></div>
		<script>
			function popHandler() {
				var pop = document.querySelector('.rsv_how_pop')
				var overlay = document.querySelector('.overlay_for_pop')
				if(pop.classList.contains('hidden')) {
					pop.classList.remove('hidden')
					overlay.classList.remove('hidden')
				}else {
					pop.classList.add('hidden')
					overlay.classList.add('hidden')
				}
			}
			function copyABtn() {
				var obj = document.getElementById('adr');
				obj.select();
				document.execCommand("Copy");
				obj.setSelectionRange(0, 0);
				alert('클립보드에 복사되었습니다.')
			}
			function copyTBtn() {
				var obj = document.getElementById('tnum');
				obj.select();
				document.execCommand("Copy");
				obj.setSelectionRange(0, 0);
				alert('클립보드에 복사되었습니다.')
			}
		</script>
<!-- 	</div> -->
		</div>
	</c:if>
	<input type="hidden" id="slider_cnt" value="1">
	<script>
		var sliderObj = document.querySelectorAll('.slider_obj')
		var cnt = sliderObj.length
		var slider_cnt = document.getElementById('slider_cnt').value
		
		console.log('카운트' + sliderObj.length);
		
		document.querySelector('.detail_img_div').style.width = cnt + '00%'
		
		function prevBtn(event) {
			if(slider_cnt == 1) {
				document.querySelector('.detail_img_div').style.transform = 'translateX(0)'
			}else {
				document.querySelector('.detail_img_div').style.transform = 'translateX(calc(-' + (parseInt(slider_cnt) - 2) * 100 + '%/' + cnt + '))'
				slider_cnt = parseInt(slider_cnt) - 1
				document.getElementById('slider_cnt').value = slider_cnt
			}
		}
		
		function nextBtn(event) {
			if(slider_cnt != cnt) {
				document.querySelector('.detail_img_div').style.transform = 'translateX(calc(-' + slider_cnt * 100 + '%/' + cnt + '))'
				slider_cnt = parseInt(slider_cnt) + 1
				document.getElementById('slider_cnt').value = slider_cnt
			}
		}
	
		// 이미지 슬라이더
// 		let minus = '-'
// 		let su = 0
// 		let px = 'px'
// 		function nextBtn(event) {
// 			var sliderObj = document.querySelectorAll('.detail_img_div')
// 			if(su == 951.5 * (sliderObj.length - 1)){
// 				return;
// 			}
// 			su = su + 951.5
// 			let pxMove = minus + su + px
// 			for(let i = 0; i < sliderObj.length; i++){
// 				sliderObj[i].style.transition = 'left 400ms linear'
// 				sliderObj[i].style.left = pxMove
// 			}
// 		}
// 		function prevBtn(event) {
// 			var sliderObj = document.querySelectorAll('.detail_img_div')
// 			if(su == 0){
// 				return;
// 			}
// 			su = su - 951.5
// 			let pxMove = minus + su + px
// 			for(let i = 0; i < sliderObj.length; i++){
// 				sliderObj[i].style.transition = 'left 400ms linear'
// 				sliderObj[i].style.left = pxMove
// 			}
// 		}
	</script>
	<!-- reservation wrap -->
	
	<!-- text content wrap -->
	<div class="text_content_wrap wrap">
		<div class="tc_title">${detailVO.tour_name }</div>
		<div class="tc_content">
			${detailVO.tour_content }
		</div>
	</div>
	<!-- hashtag wrap -->
	<div class="hashtag_wrap wrap">
		<div class="hashtag_img"><button>해시태그</button></div>
		<div class="hashtag_div">
			<c:forEach items="${detailHashVO }" var="hashList">
			${hashList.hash_tag_content }
			</c:forEach>
		</div>
	</div>
	<!-- how to or map menu wrap -->
	<div class="detail_menu_wrap wrap">
		<div><span class="use_info" onclick="useInfo(event)">이용안내</span></div>
		<div><span class="loc_info" onclick="locInfo(event)">위치안내</span></div>
	</div>
	<!-- how to or map wrap -->
	<div class="menu_content_wrap wrap">
		<div class="mcw_inner">
			<c:if test="${not empty detailVO.tour_address }">
				<div class="mcw_inner_text"><span>주소 : </span>${detailVO.tour_address } ${detailVO.tour_address_detail }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_tel}">
				<div class="mcw_inner_text"><span>연락처 : </span>${detailVO.tour_tel }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_holiday }">
				<div class="mcw_inner_text"><span>휴무일 : </span>${detailVO.tour_holiday }</div>
				<div class="mcw_inner_text">※ 기상상황(강풍, 폭우 등)에 따라 임시휴장 가능 (사전 문의 필요)</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_transportation }">
				<div class="mcw_inner_text"><span>교통정보 : </span>${detailVO.tour_transportation }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_fee1 }">
				<div class="mcw_inner_text"><span>이용요금 : </span>${detailVO.tour_fee1 }</div>
<!-- 				<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div> -->
			</c:if>
			<c:if test="${not empty detailVO.tour_fee2 }">
				<div class="mcw_inner_text">${detailVO.tour_fee2 }</div>
<!-- 				<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div> -->
			</c:if>
			<c:if test="${not empty detailVO.tour_fee3 }">
				<div class="mcw_inner_text">${detailVO.tour_fee3 }</div>
				<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_site }">
				<div class="mcw_inner_text"><span>홈페이지 : </span><a href="${detailVO.tour_site }" target="_blank">${detailVO.tour_site }</a></div>
			</c:if>
			<c:if test="${not empty detailVO.tour_how }">
				<div class="mcw_inner_text"><span>이용방법 : </span>${detailVO.tour_how }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_promotion_link }">
				<div class="mcw_inner_text"><span>홍보자료/링크 :  </span><a href="${detailVO.tour_promotion_link }" target="_blank">${detailVO.tour_promotion_link }</a></div>
			</c:if>
			<c:if test="${not empty detailVO.tour_operation1 }">
				<div class="mcw_inner_text"><span>운영 및 일시 시간 : </span>${detailVO.tour_operation1 }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_operation2 }">
				<div class="mcw_inner_text">${detailVO.tour_operation2 }</div>
			</c:if>
			<c:if test="${not empty detailVO.tour_operation3 }">
				<div class="mcw_inner_text">${detailVO.tour_operation3 }</div>
			</c:if>
		</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5dd040eaca27eadfa31c73a8507b8f44&libraries=services"></script>
		<script>
			function locInfo(event){
				var use_info = document.querySelector('.use_info')
				var mcw_inner_text = document.querySelectorAll('.mcw_inner_text')
				var mcw_inner_loc = document.querySelector('.mcw_inner_loc')
				use_info.style.color = 'black'
				event.target.style.color = '#72886C'
				for(let i = 0; i < mcw_inner_text.length; i++) {
					mcw_inner_text[i].classList.add('hidden')
				}
				var map = document.createElement('div')
				map.classList.add('mcw_inner_loc')
				map.id = 'map'
				map.style.width = '100%'
				map.style.height = '350px'
				map.style.marginTop = '15px'
				var mcw_inner = document.querySelector('.mcw_inner')
				mcw_inner.append(map)
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3 // 지도의 확대 레벨
				};

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${detailVO.tour_address}', function(result, status) {
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
							map : map,
							position : coords
						});
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						var infowindow = new kakao.maps.InfoWindow({
							content : '<div style="width:150px;text-align:center;padding:6px 0;">${detailVO.tour_name}</div>'
						});
						infowindow.open(map, marker);
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
					}
				});
			}
			
			function useInfo(event){
				var loc_info = document.querySelector('.loc_info')
				loc_info.style.color = 'black'
				event.target.style.color = '#72886C'
				var map = document.getElementById('map')
				map.remove();
				var mcw_inner_text = document.querySelectorAll('.mcw_inner_text')
				for(let i = 0; i < mcw_inner_text.length; i++) {
					mcw_inner_text[i].classList.remove('hidden')
				}
			}
		</script>
		<!-- go to list -->
	<div class="go_list_wrap wrap">
		<c:choose>
		<c:when test="${detailVO.tour_category eq '자연교감'}"><c:set var="category_name" value="nature"/></c:when>
		<c:when test="${detailVO.tour_category eq '오션레저'}"><c:set var="category_name" value="ocean"/></c:when>
		<c:when test="${detailVO.tour_category eq '뷰티&헬스스파'}"><c:set var="category_name" value="cosmetic"/></c:when>
		<c:when test="${detailVO.tour_category eq '영양식당'}"><c:set var="category_name" value="meal"/></c:when>
		<c:when test="${detailVO.tour_category eq '호텔리조트'}"><c:set var="category_name" value="hotel"/></c:when>
		</c:choose>
		<a href="${root }/tour_list_${category_name}"><button>목록</button></a>
	</div>
</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
</html>