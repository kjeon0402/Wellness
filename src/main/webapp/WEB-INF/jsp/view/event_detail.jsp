<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/event_detail.css">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script>
	function goEventList() {
		location.href = 'event'
	}
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

	<div class="event_detail_wrap">
		<div class="event_detail_title">
			<div class="title">${eVO.event_homepage_title }</div>
		</div>
		<div class="event_detail_info">
			<div class="event_detail_info_date">
				<div class="date_title">작성일</div>
				<div class="date_content">${eVO.event_homepage_write_time }</div>			
			</div>
			<div class="event_detail_info_count">
				<div class="count_title">조회수</div>
				<div class="count_content">${eVO.event_homepage_count }</div>			
			</div>
		</div>
		<div class="event_detail_content">
			<div class="img_area">
				<c:if test="${not empty imgVO.img_path }"><img src="${root }/eventimg/${imgVO.img_path}"></c:if>
<%-- 				<img src="${root }/img/view/board/event_thumbnail2.png"> --%>
			</div>
			<div class="little_title">이벤트설명</div>
			<div style="margin-top: 15px;">${eVO.event_homepage_content }</div>
			<div style="margin-top: 15px;">${eVO.event_homepage_start_date } ~ ${eVO.event_homepage_end_date }</div>
		</div>
		<div class="go_event_list">
			<div class="btn" onclick="goEventList()">목록</div>
			<c:if test="${member.member_grade == 3 }">
				<div style="margin-left: 15px;" class="btn" onclick="location.href = '${root}/event_modify?no=${eVO.event_homepage_idx }'">수정</div>
			</c:if>
		</div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>