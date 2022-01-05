<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/home.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<!-- 메인wrap -->
<div class="main_wrap" style="background-image: url('${root}/img/view/main/main_banner.svg');">
	<!-- 메인배너 -->
<!-- 	<div class="main_banner"></div> -->
	<!-- 위치/날짜/인원수 메뉴 -->
	<div class="search_option_bar">
		<form action="home_form_for_reservation" method="POST">
		<div class="sob_top">
			<div class="sob_each">
				<div class="sob_each_img"><img src="${root }/img/view/main/icon_locate.svg"><span onclick="whereTour()" style="cursor: pointer;">위치 선택</span></div>
				<div class="sob_each_text"><input onclick="whereTour()" id="tour_locate" name="locate" type="text" placeholder="어디를 관광하고 싶으세요?" required autocomplete="off"></div>
				<!-- 펼치기/접기 -->
				<script>
					function whereTour() {
						var where = document.querySelector('.where')
						if(where.style.display == 'none'){
							where.style.display = 'block'
							where.style.zIndex = '1'
						}else if(where.style.display == 'block'){
							where.style.display = 'none'
						}else {
							where.style.display = 'block'
							where.style.zIndex = '1'
						}
					}
				</script>
				<div class="sob_bot">
					<div class="first_balloon where" style="background-image: url('${root}/img/view/main/balloon.svg');">
						<div class="inner_balloon">
							<div class="inner_balloon_text">부산여행지</div>
							<div class="inner_balloon_loc">
							<%-- DB 출력 --%>
							<c:forEach items="${locateList }" var="locate_list">
								<img src="${root }/img/view/main/icon_locate.svg"><span class="loc_name" style="cursor: pointer;" onclick="clickLocate(event)">${locate_list }</span><br>
							</c:forEach>
							</div>
							<script>
								function clickLocate(event){
									var locValue = event.target.innerText
									var inputLocate = document.getElementById('tour_locate')
									inputLocate.value = locValue
									whereTour()
								}
							</script>
						</div>
					</div>
				</div>
			</div>
			<div class="line"></div>
			<div class="sob_each">
				<div class="sob_each_img"><img src="${root }/img/view/main/icon_callendar.svg"><span>날짜 선택</span></div>
				<div class="sob_each_text">
<!-- 					<input onclick="whenTour()" type="text" id="testDatepicker" placeholder="언제 관광하고 싶으세요?" required> -->
					<input class="input_date" type="date" name="rsvdate" data-placeholder="언제 관광하고 싶으세요?" required>
				</div>
				<!-- 펼치기/접기 -->
				<script>
					function whenTour() {
						var when = document.querySelector('.when')
						if(when.style.display == 'none'){
							when.style.display = 'block'
							when.style.zIndex = '1'
						}else if(when.style.display == 'block'){
							when.style.display = 'none'
						}else {
							when.style.display = 'block'
							when.style.zIndex = '1'
						}
					}
				</script>
			</div>
			<div class="line"></div>
			<div class="sob_each">
				<div class="sob_each_img"><img src="${root }/img/view/main/icon_people.svg"><span>인원 수 선택</span></div>
				<div class="count_people"><img src="${root }/img/view/main/icon_minus.svg" onclick="minusHandler()"><input id="cntPeople" name="cnt" type="number" value="1" min="1" max="99999"><img src="${root }/img/view/main/icon_plus.svg" onclick="plusHandler()"></div>
				<!-- 인원수 핸들러 -->
				<script>
					function minusHandler() {
						var cntPeople = document.getElementById('cntPeople')
						if(cntPeople.value <= 1){
							alert('인원 수는 1명 이상이어야합니다.')
						}else {
							console.log(cntPeople.value)
							cntPeople.value = parseInt(cntPeople.value) - 1
						}
					}
					function plusHandler() {
						var cntPeople = document.getElementById('cntPeople')
						if(cntPeople.value >= 99999){
							alert('인원 수는 99999명 이하여야합니다.')
						}else {
							console.log(cntPeople.value)
							cntPeople.value = parseInt(cntPeople.value) + 1
						}
					}
				</script>
			</div>
			<div class="sob_each"><input style="background-image: url('${root}/img/view/main/icon_search.svg');" type="submit" value=""></div>
		</div>
		
		
		
		</form>
	</div>
	<!-- 관광지종류 아이콘 -->
	<div class="category_div">
		<div class="icon_category_div">
			<div class="icon_category"><img onclick="location.href = '${root}/tour_list_nature'" class="ic_img" src="${root }/img/view/main/icon_nature.svg"></div>
			<div>자연교감</div>
		</div>
		<div class="icon_category_div">
			<div class="icon_category"><img onclick="location.href = '${root}/tour_list_ocean'" class="ic_img" src="${root }/img/view/main/icon_beach.svg"></div>
			<div>오션레저</div>
		</div>
		<div class="icon_category_div">
			<div class="icon_category"><img onclick="location.href = '${root}/tour_list_cosmetic'" class="ic_img" src="${root }/img/view/main/icon_cosmetic.svg"></div>
			<div>뷰티&헬스,스파</div>
		</div>
		<div class="icon_category_div">
			<div class="icon_category"><img onclick="location.href = '${root}/tour_list_meal'" class="ic_img" src="${root }/img/view/main/icon_meal.svg"></div>
			<div>영양&식당</div>
		</div>
		<div class="icon_category_div">
			<div class="icon_category"><img onclick="location.href = '${root}/tour_list_hotel'" class="ic_img" src="${root }/img/view/main/icon_hotel.svg"></div>
			<div>호텔&리조트</div>
		</div>
		<script>
// 			function selectThis(event) {
// 				event.target.style.opacity = '1.0'
// 				event.target.parentNode.style.border = '1px solid #72886C'
// 				var icimg = document.querySelectorAll('.ic_img')
// 				var ic = document.querySelectorAll('.icon_category')
// 				for(let i = 0; i < icimg.length; i++){
// 					if(icimg[i] != event.target) {
// 						icimg[i].style.opacity = ''
// 						ic[i].style.border = ''
// 					}
// 				}
// 			}
		</script>
	</div>
	
	<div class="mobile_line"></div>
	
	<!-- 인기관광명소 -->
	<div class="popular_tourist">
		<div class="popular_tourist_title">인기 관광명소</div>
		<div class="popular_tourist_subtitle">인기 많은 관광명소를 탐험해봐요</div>
		<div class="thumbnail_tourist">
		<c:forEach items="${top_six_tourist }" var="TopSixList" varStatus="st">
			<div class="each_tourist">
				<div class="each_thumbnail"><a href="${root }/tour_detail?category=&no=${TopSixList.idx}"><img src="${root }/tourimg/${top_six_image[st.index].img_path }"></a></div>
				<div class="each_tourist_title">
					<a><span>${TopSixList.name }</span></a>
					<span>
						<c:if test="${empty member }">
							<img src="${root }/img/view/main/icon_heart_clear.svg" onclick="hearFullOrClear(event)">
						</c:if>
						<c:if test="${not empty member }">
							<c:set var="checkLikeIsHere" value="0" />
							<c:forEach items="${membersLike }" var="members_like">
								<c:if test="${members_like.wish_small_category == TopSixList.idx }">
									<c:set var="checkLikeIsHere" value="${checkLikeIsHere + 1 }" />
								</c:if>
							</c:forEach>
							<img src="${root }/img/view/main/icon_heart_${checkLikeIsHere == 0 ? 'clear' : 'full' }.svg" onclick="hearFullOrClear(event)">
						</c:if>
					</span>
				</div>
				<div class="hashtag_text">
					<c:forEach items="${hashTagVOList }" var="hashTagForBest">
						<c:if test="${hashTagForBest.hash_tag_category ==  TopSixList.idx }">
							${hashTagForBest.hash_tag_content }
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
<!-- 			<div> -->
<%-- 				<div class="each_thumbnail"><img src="${root }/img/view/main/sample_tourist_0222.svg"></div> --%>
<%-- 				<div class="each_tourist_title"><a><span>웰미웰니스솔루션</span></a><span><img src="${root }/img/view/main/icon_heart_clear.svg" onclick="hearFullOrClear(event)"></span></div> --%>
<!-- 				<div class="hashtag_text">#요가요트#웰니스관광#웰니스솔루션</div> -->
<!-- 			</div> -->
			<script>
				function hearFullOrClear(event) {
					// 로그인 여부 확인 시작 ####################
					var memberInfo = '${member.member_idx}'
					if(memberInfo == '') {
						alert('로그인이 필요한 기능입니다.')
						return
					}
					// 로그인 여부 확인 종료 ####################
					var iSrc = event.target.src
					var tour_title = event.target.parentNode.parentNode.innerText
// 					관광지 제목 받기
// 					console.log(tour_title)
					
					if(iSrc.indexOf('clear') !== -1) {
						event.target.src = '${root}/img/view/main/icon_heart_full.svg'
						
						// 좋아요 + 1
						$.ajax({
							type : "GET",
							url : "ajax_home_like_plus",
							data : { "tour_title" : tour_title,
									"member_idx" : memberInfo	
							},
							success : function(result) {
								console.log('좋아요 + 1')
							},
							error : function(a, b, c){
								console.log('Err a : ' + a)
								console.log('Err b : ' + b)
								console.log('Err c : ' + c)
								console.log('ERROR msg : ' + a + b + c)
							}
						})
					}else {
						event.target.src = '${root}/img/view/main/icon_heart_clear.svg'
							
							// 좋아요 - 1
							$.ajax({
								type : "GET",
								url : "ajax_home_like_minus",
								data : { "tour_title" : tour_title,
									"member_idx" : memberInfo	
								},
								success : function(result) {
									console.log('좋아요 - 1')
								},
								error : function(a, b, c){
									console.log('Err a : ' + a)
									console.log('Err b : ' + b)
									console.log('Err c : ' + c)
									console.log('ERROR msg : ' + a + b + c)
								}
							})
					}
				}
			</script>
		</div>
		
		<div class="swiper-container swiper1">
			<div class="swiper-wrapper">
				<c:forEach items="${top_six_tourist }" var="TopSixList" varStatus="st">
					<div class="swiper-slide">
						<a href="${root }/tour_detail?category=&no=${TopSixList.idx}"><img src="${root }/tourimg/${top_six_image[st.index].img_path }"></a><br>
						${TopSixList.name }
					</div>
				</c:forEach>
			</div>
			<div class="swiper-pagination"></div>
		</div>
		<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
		<script>
			const swiper = new Swiper('.swiper1', {
				spaceBetween: 50,
				loop: true, 
				pagination: { 
					el: '.swiper-pagination' 
				},
				navigation: { 
					nextEl: '.swiper-next',
					prevEl: '.swiper-prev'
				}
			})
		</script>


		<div class="tourist_more">
			<a href="${root }/tour_list_nature"><button class="tourist_more_btn"><span>관광지 더보기</span> <span>></span></button></a>
		</div>
	</div>
	
	<div class="mobile_line"></div>
	<!-- 패키지 관광명소 -->
	<!-- 이미지 슬라이드 필요 -->
	<div class="package_tourist">
		<!-- 패키지 설명 -->
		<div class="package_tourist_div">
			<!-- event -->
			<div class="package_tourist_event"><span>EVENT</span></div>
			<!-- 제목 -->
			<div class="package_tourist_title">자연교감형 패키지</div>
			<!-- 설명1 -->
			<div class="package_tourist_text1">숲 치유 웰니스 관광지&한국전통문화체험</div>
			<!-- 설명2 -->
			<div class="package_tourist_text2">산림속에서 자연을 있는 그대로 느끼고 정서적 안녕과 자신을 찾아가는 활동이 목적</div>
			<!-- 자세히보기/예약하기 버튼 -->
			<div class="package_tourist_btn1"><button class="more_info" onclick="location.href = '${root}/package_list_nature'">자세히보기</button><!-- <button class="reservation">예약하기</button>  --></div>
			<!-- pre/next btn -->
			<div class="package_tourist_btn2"><button class="preview" style="background-image: url('${root}/img/view/main/previewBtn.svg');" onclick="preBtn(event)"></button><button class="next" style="background-image: url('${root}/img/view/main/nextBtn.svg');" onclick="nextBtn(event)"></button></div>
		</div>
		<div class="package_tourist_div hidden">
			<!-- event -->
			<div class="package_tourist_event"><span>EVENT</span></div>
			<!-- 제목 -->
			<div class="package_tourist_title">해양체험형 패키지</div>
			<!-- 설명1 -->
			<div class="package_tourist_text1">부산 대표 관광 명소&해양레저 스포츠</div>
			<!-- 설명2 -->
			<div class="package_tourist_text2">해양체험을 통해 인간의 신체적 건강과 배움 그리고 힐링이 목적</div>
			<!-- 자세히보기/예약하기 버튼 -->
			<div class="package_tourist_btn1"><button class="more_info" onclick="location.href = '${root}/package_list_ocean'">자세히보기</button><!-- <button class="reservation">예약하기</button> --></div>
			<!-- pre/next btn -->
			<div class="package_tourist_btn2"><button class="preview" style="background-image: url('${root}/img/view/main/previewBtn.svg');" onclick="preBtn(event)"></button><button class="next" style="background-image: url('${root}/img/view/main/nextBtn.svg');" onclick="nextBtn(event)"></button></div>
		</div>
		<div class="package_tourist_div hidden">
			<!-- event -->
			<div class="package_tourist_event"><span>EVENT</span></div>
			<!-- 제목 -->
			<div class="package_tourist_title">스토리텔링형 패키지</div>
			<!-- 설명1 -->
			<div class="package_tourist_text1">부산 유니크 베뉴&원도심 갈맷길 걷기</div>
			<!-- 설명2 -->
			<div class="package_tourist_text2">길, 마을 등 부산의 역사가 담겨있는 곳에서 부산만이 전할 수 있는 재미와 몸과 마음의 위로, 치유를 경험함이 목적</div>
			<!-- 자세히보기/예약하기 버튼 -->
			<div class="package_tourist_btn1"><button class="more_info" onclick="location.href = '${root}/package_list_story'">자세히보기</button><!-- <button class="reservation">예약하기</button> --></div>
			<!-- pre/next btn -->
			<div class="package_tourist_btn2"><button class="preview" style="background-image: url('${root}/img/view/main/previewBtn.svg');" onclick="preBtn(event)"></button><button class="next" style="background-image: url('${root}/img/view/main/nextBtn.svg');" onclick="nextBtn(event)"></button></div>
		</div>
			<script>
				function preBtn(event){
						var cDiv = document.querySelectorAll('.package_tourist_div')
						var imgObject = document.querySelectorAll('.img_object')
						console.log(cDiv)
						console.log(event.target.parentNode.parentNode)
						var controlDiv = event.target.parentNode.parentNode
// 						let minus = '-'
						let su = 871
						let px = 'px'
						for(let i = 0; i < cDiv.length; i++) {
							let pxMove = su + px
							console.log(pxMove)
							if(controlDiv == cDiv[i]) {
								console.log('this is!')
								if(i == 0) {
									cDiv[i].classList.add('hidden')
									cDiv[cDiv.length - 1].classList.remove('hidden')
									imgObject[i].style.transition = 'left 400ms linear'
									imgObject[cDiv.length - 1].style.transition = 'left 400ms linear'
									let cnt = 0
									for(let j = 0; j < cDiv.length; j++) {
										imgObject[j].style.left = '-1742px'
									}
								}else {
									cDiv[i].classList.add('hidden')
									cDiv[i - 1].classList.remove('hidden')
									imgObject[i].style.transition = 'left 400ms linear'
									imgObject[i - 1].style.transition = 'left 400ms linear'
									imgObject[i].style.left = pxMove
									imgObject[i - 1].style.left = pxMove
								}
							}else {
								console.log('this is not!')
								if(i == 0) {
									console.log('i is 0')
								}
							}
							su = su - 871
						}
				}
				function nextBtn(){
					var cDiv = document.querySelectorAll('.package_tourist_div')
					var imgObject = document.querySelectorAll('.img_object')
					console.log(cDiv)
					console.log(event.target.parentNode.parentNode)
					var controlDiv = event.target.parentNode.parentNode
					let minus = '-'
					let su = 871
					let px = 'px'
					for(let i = 0; i < cDiv.length; i++) {
						let pxMove = minus + su + px
						console.log(pxMove)
						if(controlDiv == cDiv[i]) {
							console.log('this is!')
							if(i == cDiv.length - 1) {
								cDiv[i].classList.add('hidden')
								cDiv[0].classList.remove('hidden')
								imgObject[i].style.transition = 'left 400ms linear'
								imgObject[0].style.transition = 'left 400ms linear'
								for(let j = 0; j < cDiv.length; j++) {
									imgObject[j].style.left = '0'
								}
							}else {
								cDiv[i].classList.add('hidden')
								cDiv[i + 1].classList.remove('hidden')
								imgObject[i].style.transition = 'left 400ms linear'
								imgObject[i + 1].style.transition = 'left 400ms linear'
								imgObject[i].style.left = pxMove
								imgObject[i + 1].style.left = pxMove
							}
						}else {
							console.log('this is not!')
							if(i == cDiv.length) {
								console.log('i is 0')
							}
						}
						su = su + 871
					}
				}
			</script>
		<div class="img_slide_div">
			<div class="overflow_control">
				<div class="img_object1 img_object" style="background-image: url('${root}/img/view/main/img_object1.svg');"></div>
				<div class="img_object2 img_object" style="background-image: url('${root}/img/view/main/img_object2.svg');"></div>
				<div class="img_object2 img_object" style="background-image: url('${root}/img/view/package/sample_package_story.svg');"></div>
			</div>
		</div>
	</div>
	
	<div class="mobile_package_info">
		<div class="mpi_title">패키지 관광</div>
		<div class="swiper-container swiper2">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<a href="${root}/package_list_nature"><img src="${root}/img/view/main/img_object1.svg"></a>
					<div class="ss_text">
						<span style="font-size: 14px; font-weight: bold;">자연교감형 패키지</span><br>
						<span style="font-size: 13px;">숲 치유 웰니스 관광지&한국전통문화체험</span>
					</div>
				</div>
				<div class="swiper-slide">
					<a href="${root}/package_list_ocean"><img src="${root}/img/view/main/img_object2.svg"></a>
					<div class="ss_text">
						<span style="font-size: 14px; font-weight: bold;">해양체험형 패키지</span><br>
						<span style="font-size: 13px;">부산 대표 관광 명소&해양레저 스포츠</span>
					</div>
				</div>
				<div class="swiper-slide">
					<a href="${root}/package_list_story"><img src="${root}/img/view/package/sample_package_story.svg"></a>
					<div class="ss_text">
						<span style="font-size: 14px; font-weight: bold;">스토리텔링형 패키지</span><br>
						<span style="font-size: 13px;">부산 유니크 베뉴&원도심 갈맷길 걷기</span>
					</div>
				</div>
			</div>
			<div class="swiper-pagination2"></div>
		</div>
	</div>
	<script>
			const swiper2 = new Swiper('.swiper2', {
				spaceBetween: 50,
				loop: true, 
				pagination: { 
					el: '.swiper-pagination2' 
				},
				navigation: { 
					nextEl: '.swiper-next2',
					prevEl: '.swiper-prev2'
				}
			})
		</script>

	<div class="mobile_line"></div>
	
	<c:if test="${not empty top_six_gallery }">
	<!-- 갤러리 -->
	<div class="gallery_wrap">
		<div class="gallery_inner_wrap">
			<!-- 갤러리 타이틀 -->
			<div class="mg_title">갤러리</div>
			<!-- 갤러리 서브타이틀 -->
			<div class="mg_subtitle">인기많은 관광명소를 탐험해봐요</div>
			<!-- 갤러리 리스트 -->
			<div class="mg_list_wrap">
				<c:forEach items="${top_six_gallery }" var="TopSixGallery" varStatus="st">
				<!-- 개별 -->
				<div class="mg_each">
					<!-- 갤러리사진 -->
					<div class="mg_image_div">
						<c:forEach items="${top_six_gallery_img }" var="topSixGalleryImg">
							<c:if test="${topSixGalleryImg.img_small_category == TopSixGallery.gallery_idx}">
								<a href="${root }/gallery_detail?no=${TopSixGallery.gallery_idx}"><img class="mg_image isHereImg${st.index }" src="${root }/gallery_file/${topSixGalleryImg.img_path }"></a>
							</c:if>
						</c:forEach>
						<c:forEach items="${top_six_gallery_video }" var="topSixGalleryVideo">
							<c:if test="${topSixGalleryVideo.video_small_category == TopSixGallery.gallery_idx}">
								<a href="${root }/gallery_detail?no=${TopSixGallery.gallery_idx}"><video class="mg_image isHereVideo${st.index }" src="${root }/gallery_file/${topSixGalleryVideo.video_path}"></video></a>
								<div><img id="play_btn_home" class="isHerePlayBtn${st.index }" id="play_btn" src="${root }/img/view/gallery/play_btn.svg"></div>
							</c:if>
						</c:forEach>
					</div>
					<script>
						function removeHomeThumbnailV(){
							var isHereI = document.querySelector('.isHereImg${st.index}')
							console.log(isHereI)
							if(isHereI != null){
								var isHereV = document.querySelector('.isHereVideo${st.index}')
								isHereV.remove();
								var isHerePB = document.querySelector('.isHerePlayBtn${st.index}')
								isHerePB.remove();
							}
						}
						removeHomeThumbnailV()
					</script>
					<!-- 좋아요 -->
<%-- 					<div class="mg_like_div"><img class="mg_like_icon" src="${root }/img/view/main/icon_like_clear.svg" onclick="likeFullOrClear(event)"></div> --%>
				</div>
				</c:forEach>
<!-- 				<div class="mg_each"> -->
					<!-- 갤러리사진 -->
<%-- 					<div class="mg_image_div"><img class="mg_image" src="${root }/img/view/main/sample_gallery02.svg"></div> --%>
					<!-- 좋아요 -->
<%-- 					<div class="mg_like_div"><img class="mg_like_icon" src="${root }/img/view/main/icon_like_clear.svg" onclick="likeFullOrClear(event)"></div> --%>
<!-- 				</div> -->
				<script>
					function likeFullOrClear(event) {
						var iSrc = event.target.src
						if(iSrc.indexOf('clear') !== -1) {
							event.target.src = '${root}/img/view/main/icon_like_full.svg'
						}else {
							event.target.src = '${root}/img/view/main/icon_like_clear.svg'
						}
					}
				</script>
			</div>
		</div>
	</div>
	</c:if>
</div>
<!-- 메인wrap END-->
<!-- <div class="sizeModal"> -->
<!-- 	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div> -->
<!-- </div> -->
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>