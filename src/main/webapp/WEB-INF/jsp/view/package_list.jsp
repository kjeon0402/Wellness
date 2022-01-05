<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/package_list.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />
	
	<div class="m_cate">
		<span><a href="${root}/package_list_nature">자연교감형 패키지</a></span>
		<span><a href="${root}/package_list_ocean">해양체험형 패키지</a></span>
		<span><a href="${root}/package_list_story">스토리텔링형 패키지</a></span>
	</div>
	
	
	<div class="package_list_wrap">
		<!-- 카테고리 버튼 -->
		<div class="cate_wrap">
			<div class="btn_wrap">
				<c:if test="${empty spVO }">
					<div class="btn_div"><button class="natureBtn" onclick="location.href='${root}/package_list_nature'">자연교감형 패키지</button></div>
					<div class="btn_div"><button class="oceanBtn" onclick="location.href='${root}/package_list_ocean'">해양체험형 패키지</button></div>
					<div class="btn_div"><button class="storyBtn" onclick="location.href='${root}/package_list_story'">스토리텔링형 패키지</button></div>
				</c:if>
				<c:if test="${not empty spVO }">
					<c:if test="${empty pVOList }">
						<div><button class="natureBtn" style="width: 250px;" onclick="location.href = '${root}/'">검색 결과가 없습니다.</button></div>
					</c:if>
					<c:if test="${not empty pVOList }">
						<div><button class="natureBtn">위치 : ${spVO.locate }</button></div>
						<div><button class="oceanBtn">일정 : ${spVO.rsvdate }</button></div>
						<div><button class="storyBtn">인원 : ${spVO.cnt }</button></div>
					</c:if>
				</c:if>
			</div>
			<script>
				function wichCategory() {
					var link = window.location.href
					if(link.indexOf('ocean') != -1){
						var ocean = document.querySelector('.oceanBtn')
						ocean.style.border = '1px solid #72886C'
						ocean.style.backgroundColor = '#72886C'
						ocean.style.color = 'white'
					}else if(link.indexOf('story') != -1) {
						var story = document.querySelector('.storyBtn')
						story.style.border = '1px solid #72886C'
						story.style.backgroundColor = '#72886C'
						story.style.color = 'white'
					}else if(link.indexOf('nature') != -1) {
						var nature = document.querySelector('.natureBtn')
						nature.style.border = '1px solid #72886C'
						nature.style.backgroundColor = '#72886C'
						nature.style.color = 'white'
					}
				}
				wichCategory()
			</script>
		</div>
		<!-- 정렬(최신/인기순) -->
		<div class="sort_wrap">
			<div class="sort_span_wrap">
				<span style="font-weight: bold; color: #72886C;" class="s_span" onclick="sortNew()">최신순</span>
				<span class="s_span">|</span>
				<span style="cursor: pointer;" class="s_span" onclick="sortPop()">인기순</span>
				<script>
					function newORpop() {
						var link = window.location.href
						if(link.indexOf('pop') != -1 ){
							var wichSpan = document.querySelectorAll('.s_span')
							wichSpan[0].style.fontWeight = ''
							wichSpan[0].style.color = 'black'
							wichSpan[2].style.fontWeight = 'bold'
							wichSpan[2].style.color = '#72886C'
						}
					}
					newORpop()
					
					function sortNew() {
						var link = window.location.href
						if(link.indexOf('nature') != -1){
							location.href = '${root}/package_list_nature'
						}else if(link.indexOf('ocean') != -1) {
							location.href = '${root}/package_list_ocean'
						}else if(link.indexOf('story') != -1){
							location.href = '${root}/package_list_story'
						}
					}
					function sortPop() {
						var link = window.location.href
						if(link.indexOf('nature') != -1){
							location.href = '${root}/package_list_nature_pop'
						}else if(link.indexOf('ocean') != -1) {
							location.href = '${root}/package_list_ocean_pop'
						}else if(link.indexOf('story') != -1){
							location.href = '${root}/package_list_story_pop'
						}
					}
				</script>
			</div>
		</div>
		<!-- 리스트 -->
		<div class="package_thumbnail_wrap">
			<div class="package_list">
				<c:forEach items="${pVOList }" var="pVO_list">
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail?no=${pVO_list.package_idx}"><img src="${root }/packageimg/${pVO_list.package_thumbnail}"></a></div>
						<div class="icon_like_div">
							<c:if test="${empty member }">
								<img src="${root }/img/view/package/package_heart_clear.svg" onclick="hearFullOrClear(event)">
							</c:if>
							<c:if test="${not empty member }">
								<c:set var="checkLikeIsHere" value="0" />
								<c:forEach items="${membersLike }" var="members_like">
									<c:if test="${members_like.wish_small_category == pVO_list.package_idx }">
										<c:set var="checkLikeIsHere" value="${checkLikeIsHere + 1 }" />
									</c:if>
								</c:forEach>
								<img src="${root }/img/view/package/package_heart_${checkLikeIsHere == 0 ? 'clear' : 'full' }.svg" onclick="hearFullOrClear(event)">
							</c:if>
<%-- 						<img src="${root }/img/view/package/package_heart_clear.svg" onclick="hearFullOrClear(event)"> --%>
						</div>
					</div>
					<div class="package_info">
						<div class="package_title">${pVO_list.package_name }</div>
						<div class="package_price">${pVO_list.package_price }</div>
						<div class="package_duration">${pVO_list.package_start_date } ~ ${pVO_list.package_end_date }</div>
						<div class="package_btn">
							<a href="${root }/package_detail?no=${pVO_list.package_idx}"><button>자세히보기</button></a>
							<a href="${root }/reserve?package_idx=${pVO_list.package_idx}"><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				</c:forEach>
				<script>
					var priceDiv = document.querySelectorAll('.package_price')
					for(let i = 0; i < priceDiv.length; i++){
						let priceString = priceDiv[i].innerText
						let priceComma = priceString.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
						priceDiv[i].innerText = priceComma + '원'
					}
				</script>
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
						var tour_title = event.target.parentNode.parentNode.parentNode.getElementsByTagName('div')[4].innerText
// 						관광지 제목 받기
// 						console.log(tour_title)
						
						if(iSrc.indexOf('clear') !== -1) {
							event.target.src = '${root}/img/view/package/package_heart_full.svg'
							
							// 좋아요 + 1
							$.ajax({
								type : "GET",
								url : "ajax_package_like_plus",
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
							event.target.src = '${root}/img/view/package/package_heart_clear.svg'
								
								// 좋아요 - 1
								$.ajax({
									type : "GET",
									url : "ajax_package_like_minus",
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
					
<!-- 				<div class="package_thumbnail"> -->
<!-- 					<div class="thumbnail_img"> -->
<%-- 						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div> --%>
<%-- 						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					</div> -->
<!-- 					<div class="package_info"> -->
<!-- 						<div class="package_title">자연교감형 패키지 A</div> -->
<!-- 						<div class="package_price">250,000원</div> -->
<!-- 						<div class="package_duration">2021.09.11 ~ 2021.09.15</div> -->
<!-- 						<div class="package_btn"> -->
<%-- 							<a href="${root }/package_detail"><button>자세히보기</button></a> --%>
<!-- 							<a href=""><button class="reserve">예약하기</button></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="package_thumbnail"> -->
<!-- 					<div class="thumbnail_img"> -->
<%-- 						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div> --%>
<%-- 						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					</div> -->
<!-- 					<div class="package_info"> -->
<!-- 						<div class="package_title">자연교감형 패키지 A</div> -->
<!-- 						<div class="package_price">250,000원</div> -->
<!-- 						<div class="package_duration">2021.09.11 ~ 2021.09.15</div> -->
<!-- 						<div class="package_btn"> -->
<%-- 							<a href="${root }/package_detail"><button>자세히보기</button></a> --%>
<!-- 							<a href=""><button class="reserve">예약하기</button></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="package_thumbnail"> -->
<!-- 					<div class="thumbnail_img"> -->
<%-- 						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div> --%>
<%-- 						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					</div> -->
<!-- 					<div class="package_info"> -->
<!-- 						<div class="package_title">자연교감형 패키지 A</div> -->
<!-- 						<div class="package_price">250,000원</div> -->
<!-- 						<div class="package_duration">2021.09.11 ~ 2021.09.15</div> -->
<!-- 						<div class="package_btn"> -->
<%-- 							<a href="${root }/package_detail"><button>자세히보기</button></a> --%>
<!-- 							<a href=""><button class="reserve">예약하기</button></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="package_thumbnail"> -->
<!-- 					<div class="thumbnail_img"> -->
<%-- 						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div> --%>
<%-- 						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					</div> -->
<!-- 					<div class="package_info"> -->
<!-- 						<div class="package_title">자연교감형 패키지 A</div> -->
<!-- 						<div class="package_price">250,000원</div> -->
<!-- 						<div class="package_duration">2021.09.11 ~ 2021.09.15</div> -->
<!-- 						<div class="package_btn"> -->
<%-- 							<a href="${root }/package_detail"><button>자세히보기</button></a> --%>
<!-- 							<a href=""><button class="reserve">예약하기</button></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="package_thumbnail"> -->
<!-- 					<div class="thumbnail_img"> -->
<%-- 						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div> --%>
<%-- 						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					</div> -->
<!-- 					<div class="package_info"> -->
<!-- 						<div class="package_title">자연교감형 패키지 A</div> -->
<!-- 						<div class="package_price">250,000원</div> -->
<!-- 						<div class="package_duration">2021.09.11 ~ 2021.09.15</div> -->
<!-- 						<div class="package_btn"> -->
<%-- 							<a href="${root }/package_detail"><button>자세히보기</button></a> --%>
<!-- 							<a href=""><button class="reserve">예약하기</button></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<script>
					function heartClearOrFull(event) {
						var iSrc = event.target.src
						if(iSrc.indexOf('clear') !== -1) {
							event.target.src = '${root}/img/view/tour/tour_heart_full.svg'
						}else {
							event.target.src = '${root}/img/view/tour/tour_heart_clear.svg'
						}
					}
				</script>
			</div>
		</div>
		<!-- 검색 -->
		<div class="search_wrap">
			<div class="search_div_wrap">
				<form style="display: flex;">
				<div class="search_div"><input type="search" name="search_keyword" placeholder="제목으로 입력해주세요."><img src="${root }/img/view/package/package_icon_search.svg"></div>
				<div class="search_btn"><input type="submit" value="검색"></div>
				</form>
			</div>
		</div>
		
		<script>
			var link = window.location.href
			if(link.indexOf('home_form_for_reservation') != -1) {
				var searchWrap = document.querySelector('.search_wrap')
				searchWrap.remove()			
			}
		</script>
		
		<!-- 페이징 -->
		<div class="paging">
			<c:if test="${paging.nowPage != 1 }">
				<a href="notice?nowPage=1&cntPerPage=${paging.cntPerPage }">&lt;&lt;</a>
				<a href="notice?nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<div class="num">${p }</div>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="notice?nowPage=${p }&cntPerPage=${paging.cntPerPage }">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }">
				<a href="notice?nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }">&gt;</a>
				<a href="notice?nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }">&gt;&gt;</a>
			</c:if>
		</div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
	
	<script>
		var link = window.location.href
		if(link.indexOf('home_form_for_reservation') != -1) {
			var paging = document.querySelector('.paging')
			paging.style.display = 'none'
		}
	</script>
</body>
</html>