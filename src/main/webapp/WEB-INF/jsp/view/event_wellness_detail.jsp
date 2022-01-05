<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/event_wellness_detail.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script>
	function goEventWellnessList() {
		location.href = 'event_wellness'
	}
</script>
<script>
// 이미지 슬라이더
	let imgSlider = document.querySelector('.img_slider')
	let slideImg = document.querySelectorAll('.img_slider li')
	currentIdx = 0
	slideCount = slideImg.length
	prev = document.querySelector('.prev_btn')
	next = document.querySelector('.next_btn')
	
	slideWidth = 300;
	imgSlider.style.width = sildeWidth * slideCount + 'px'
	
	function moveSlide(num) {
		imgSlider.style.left = -num * 300 + 'px'
		currentIdx = num
	}
	
	prev.addEventListener('click', function() {
		if(currentIdx !== 0) moveSlide(currentIdx - 1)
	})
	
	next.addEventListener('click', function() {
		if(currentIdx !== slideCount - 1) moveSlide(currentIdx + 1)
	})
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

	<div class="event_wellness_detail_wrap">
		<div class="event_wellness_detail_title">
			<div class="title">${e_wVO.event_wellness_title }</div>
		</div>
		<div class="event_wellness_detail_info">
			<div class="event_wellness_detail_info_date">
				<div class="date_title">작성일</div>
				<div class="date_content">${e_wVO.event_wellness_write_time }</div>			
			</div>
			<div class="event_wellness_detail_info_count">
				<div class="count_title">조회수</div>
				<div class="count_content">${e_wVO.event_wellness_count }</div>			
			</div>
		</div>
		<div class="event_wellness_detail_content">
			<div class="img_area" id="img_area">
				<ul class="img_slider">
					<c:if test="${not empty imgVO.img_path }"><li><img src="${root }/eventwellnessimg/${imgVO.img_path}"></li></c:if>
<%-- 					<li><img src="${root }/img/view/board/event_wellness_detail1.png"></li> --%>
<%-- 					<li><img src="${root }/img/view/board/event_wellness_detail1.png"></li> --%>
				</ul>
<!-- 				<div class="slider_controller"> -->
<!-- 					<div class="prev_btn">&gt;</div> -->
<!-- 					<div class="next_btn">&lt;</div> -->
<!-- 				</div> -->
			</div>
			<div class="tour_content">
				${e_wVO.event_wellness_content }
			</div>
<!-- 			<div class="tour_info"> -->
<!-- 				<p> -->
<!-- 					<span>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소 : </span> -->
<!-- 					<span>부산 서구 암남동 620-53 암남공원 안</span> -->
<!-- 				</p> -->
<!-- 				<p> -->
<!-- 					<span>연&nbsp;락&nbsp;처 : </span> -->
<!-- 					<span>051-240-4087</span> -->
<!-- 				</p> -->
<!-- 				<p> -->
<!-- 					<span>행사기간 : </span> -->
<!-- 					<span>2021.09.11 ~ 2021.09.15</span> -->
<!-- 				</p> -->
<!-- 				<p> -->
<!-- 					<span>교통정보 : </span> -->
<!-- 					<span>부산 지하철 1호선 남포역 하차 후 7번, 71번 버스 환승</span> -->
<!-- 				</p> -->
<!-- 				<p> -->
<!-- 					<span>이용요금 : </span> -->
<!-- 					<span>일반 1,000원 무료 (7세 미만, 장애의 정도가 심한 장애인 종전 1~3급, 국가유공자, 부산 서구민)</span><br> -->
<!-- 					<span>※ 해당하는 자는 신분증 또는 증빙자료 지참</span> -->
<!-- 				</p> -->
<!-- 				<p> -->
<!-- 					<span>운영 및 일시 시간 : </span> -->
<!-- 					<span>09:00~18:00(3월~9월)/입장마감시간 : 17:30 09:00~17:00(10월~2월)/입장마감시간 : 16:30</span> -->
<!-- 				</p> -->
				
<!-- 			</div> -->
		</div>
		<div class="go_event_wellness_list">
			<div class="btn" onclick="goEventWellnessList()">목록</div>
			<c:if test="${member.member_grade == 3 }">
				<div style="margin-left: 15px;" class="btn" onclick="location.href = '${root}/event_wellness_modify?no=${e_wVO.event_wellness_idx }'">수정</div>
			</c:if>
		</div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>