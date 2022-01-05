<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/package_detail.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<script>
// 하트
	function heartClearOrFull(event) {
		var iSrc = event.target.src
		if(iSrc.indexOf('clear') !== -1) {
			event.target.src = '${root}/img/view/tour/tour_heart_full.svg'
		}else {
			event.target.src = '${root}/img/view/tour/tour_heart_clear.svg'
		}
	}
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />

	<div class="package_detail_wrap">
		<div class="package_detail_top">
			<div class="package_cetegory_icon">
				<img src="${root }/img/view/package/package_detail_icon.svg">
			</div>
			<div class="package_info">
				<div class="package_name">${pVO.package_category } 패키지</div>
				<div class="package_content">${pVO.package_name }<br><br>${pVO.package_intro }</div>
				<div class="package_price">${pVO.package_price }</div>
				<div class="package_duration">${pVO.package_start_date } ~ ${pVO.package_end_date }</div>
				<script>
					var priceDiv = document.querySelector('.package_price')
					let priceComma = priceDiv.innerText.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
					priceDiv.innerText = priceComma + ' 원'
				</script>
			</div>
			<div class="extend_line"></div>
			<form action="${root }/reserve" method="get">
				<input type="hidden" name="package_idx" value="${pVO.package_idx }">
				<button class="reserveBtn">예약하기</button>
			</form>
			<div class="package_schedule">
				<img src="${root }/packageimg/${pVO.package_schedule}">
			</div>
		</div>
		<div class="package_contents">
			<span style="color: #72866C; border-bottom: 2px solid #72866C;" class="package_content" onclick="categorySelect(event)">${pVO.tour_name1 }</span>
			<c:if test="${not empty pVO.tour_name2 }">
				<span class="line" style="padding: 20px">|</span>
				<span class="package_content" onclick="categorySelect(event)">${pVO.tour_name2 }</span>
				<c:if test="${not empty pVO.tour_name3 }">
					<span class="line" style="padding: 20px">|</span>
					<span class="package_content" onclick="categorySelect(event)">${pVO.tour_name3 }</span>
					<c:if test="${not empty pVO.tour_name4 }">
						<span class="line" style="padding: 20px">|</span>
						<span class="package_content" onclick="categorySelect(event)">${pVO.tour_name4 }</span>
						<c:if test="${not empty pVO.tour_name5 }">
							<span class="line" style="padding: 20px">|</span>
							<span class="package_content" onclick="categorySelect(event)">${pVO.tour_name5 }</span>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
		<script>
			function categorySelect(event) {
				let tnValue = event.target.innerText
				console.log(tnValue)
				location.href = '${root}/package_detail_tourname?no=${pVO.package_idx}&tourname=' + tnValue
			}		
		</script>
		<script>
			function whatTour() {
				var tname = '${tVO.tour_name}'
				var tnames = document.querySelectorAll('.package_content')
				for(let i = 0; i < tnames.length; i++) {
					tnames[i].style.color = '#707070'
					tnames[i].style.borderBottom = 'none'
					if(tname == tnames[i].innerText) {
						tnames[i].style.color = '#72866C'
						tnames[i].style.borderBottom = '2px solid #72866C'
					}
				}
			}
			whatTour()
		</script>
		</div>
		<div class="package_detail_main">
			<div class="image_area">
					<c:forEach items="${imgVOList }" var="imgVO_list">
						<div class="package_content_img">
							<img class="img_slide_object" src="${root }/tourimg/${imgVO_list.img_path}">
						</div>
					</c:forEach>
					<input type="hidden" id="slider_cnt" value="1">
<%-- 				<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
			</div>
			<div class="slider_controll_div">
				<button class="preBtn" style="background-image: url('${root}/img/view/package/preBtn.svg');" onclick="prevImgBtn()"></button>
				<button class="nxtBtn" style="background-image: url('${root}/img/view/package/nxtBtn.svg');" onclick="nextImgBtn()"></button>
			</div>
<!-- 		<div class="next_img" onclick="nextImgBtn()">&gt;</div> -->
			<script>
				var sliderObj = document.querySelectorAll('.img_slide_object')
				var cnt = sliderObj.length
				var slider_cnt = document.getElementById('slider_cnt').value
				
				console.log('카운트' + sliderObj.length);
				
				document.querySelector('.image_area').style.width = cnt + '00%'
				
				function prevImgBtn() {
					if(slider_cnt == 1) {
						document.querySelector('.image_area').style.transform = 'translateX(0)'
					}else {
						document.querySelector('.image_area').style.transform = 'translateX(calc(-' + (parseInt(slider_cnt) - 2) * 100 + '%/' + cnt + '))'
						slider_cnt = parseInt(slider_cnt) - 1
						document.getElementById('slider_cnt').value = slider_cnt
					}
				}
				
				function nextImgBtn() {
					if(slider_cnt != cnt) {
						document.querySelector('.image_area').style.transform = 'translateX(calc(-' + slider_cnt * 100 + '%/' + cnt + '))'
						slider_cnt = parseInt(slider_cnt) + 1
						document.getElementById('slider_cnt').value = slider_cnt
					}
				} 
			
			// 이미지 슬라이더
// 			let minus = '-'
// 			let su = 0
// 			let px = 'px'
// 			function nextImgBtn() {
// 				var sliderObj = document.querySelectorAll('.package_content_img')
// 				if(su == 989 * (sliderObj.length - 1)){
// 					return;
// 				}
// 				su = su + 989
// 				let pxMove = minus + su + px
// 				for(let i = 0; i < sliderObj.length; i++){
// 					sliderObj[i].style.transition = 'left 400ms linear'
// 					sliderObj[i].style.left = pxMove
// 				}
// 			}
// 			function prevImgBtn() {
// 				var sliderObj = document.querySelectorAll('.package_content_img')
// 				if(su == 0){
// 					return;
// 				}
// 				su = su - 989
// 				let pxMove = minus + su + px
// 				for(let i = 0; i < sliderObj.length; i++){
// 					sliderObj[i].style.transition = 'left 400ms linear'
// 					sliderObj[i].style.left = pxMove
// 				}
// 			}
			</script>
			</div>
			<div class="package_content_info">
				<div class="package_content_name">${tVO.tour_name }</div>
				<div class="package_content_info2">
					${tVO.tour_content }
				</div>
				<div class="package_content_hashtag">
					<span class="hashtag_title">해시태그</span>
					<span>
						<c:forEach items="${hVOList }" var="hVO_list">
							${hVO_list.hash_tag_content }
						</c:forEach>
					</span>
				</div>
			</div>
			<div class="use_location">
				<div class="use_info" style="color: #72866C;" onclick="useInfo(event)">이용안내</div>
				<div class="loc_info" onclick="locInfo(event)">위치안내</div>
			</div>
			<div class="menu_content_wrap wrap">
				<div class="mcw_inner">
					<c:if test="${not empty tVO.tour_address }">
					<div class="mcw_inner_text"><span>주소 : </span>${tVO.tour_address } ${tVO.tour_address_detail }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_tel }">
					<div class="mcw_inner_text"><span>연락처 : </span>${tVO.tour_tel }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_holiday }">
					<div class="mcw_inner_text"><span>휴무일 : </span>${tVO.tour_holiday }</div>
					<div class="mcw_inner_text">※ 기상상황(강풍, 폭우 등)에 따라 임시휴장 가능 (사전 문의 필요)</div>
					</c:if>
					<c:if test="${not empty tVO.tour_transportation }">
					<div class="mcw_inner_text"><span>교통정보 : </span>${tVO.tour_transportation }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_fee1 }">
						<div class="mcw_inner_text"><span>이용요금 : </span>${tVO.tour_fee1 }</div>
	<!-- 					<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div> -->
						<c:if test="${not empty tVO.tour_fee2 }">
						<div class="mcw_inner_text">${tVO.tour_fee2 }</div>
	<!-- 					<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div> -->
						</c:if>
						<c:if test="${not empty tVO.tour_fee3 }">
						<div class="mcw_inner_text">${tVO.tour_fee3 }</div>
						</c:if>
						<div class="mcw_inner_text">※ 해당하는 자는 신분증 또는 증빙자료 지참</div>
					</c:if>
					<c:if test="${not empty tVO.tour_site }">
					<div class="mcw_inner_text"><span>홈페이지 : </span><a target="_blank" href="${tVO.tour_site }">${tVO.tour_site }</a></div>
					</c:if>
					<c:if test="${not empty tVO.tour_how }">
					<div class="mcw_inner_text"><span>이용방법 : </span>${tVO.tour_how }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_promotion_link }">
					<div class="mcw_inner_text"><span>홍보자료/링크 :  </span><a target="_blank" href="${tVO.tour_promotion_link }">${tVO.tour_promotion_link }</a></div>
					</c:if>
					<c:if test="${not empty tVO.tour_operation1 }">
					<div class="mcw_inner_text"><span>운영 및 일시 시간 : </span>${tVO.tour_operation1 }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_operation2 }">
					<div class="mcw_inner_text">${tVO.tour_operation2 }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_operation3 }">
					<div class="mcw_inner_text">${tVO.tour_operation3 }</div>
					</c:if>
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
						geocoder.addressSearch('${tVO.tour_address}', function(result, status) {
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
									content : '<div style="width:150px;text-align:center;padding:6px 0;">${tVO.tour_name}</div>'
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
		</div>
		<div class="go_back_package_list">
			<c:if test="${pVO.package_category == '자연교감형' }">
				<c:set var="categoryForList" value="nature" />
			</c:if>
			<c:if test="${pVO.package_category == '해양체험형' }">
				<c:set var="categoryForList" value="ocean" />
			</c:if>
			<c:if test="${pVO.package_category == '스토리텔링형' }">
				<c:set var="categoryForList" value="story" />
			</c:if>
			<a href="${root }/package_list_${categoryForList}"><button>목록</button></a>
		</div>
	</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>