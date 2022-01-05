<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${root }/css/intro_platform.css">
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_platform.jsp" />
	
	<div class="intro_platform_wrap">
		<div class="page_title">플랫폼 소개</div>
		<div class="represent_img" style="background-image: url('${root}/img/view/intro/intro_platform.svg');"></div>
		<div class="content">
			<p>부산웰니스관광의 성공을 위해 단순한 정보제공 및 예약과 관리 및 사후 평가까지 <span>종합적 서비스</span>를 제공하는 독자적인 플랫폼 구축이 필요합니다.</p>
			<p>부산 웰니스 관광을 즐기기 위한 목적으로 관광객이 방문한다고 가정했을 때, 무엇보다 한 번에 여행 시작에서 마무리 단계가지 해결해 줄 수 있는 <span>원스톱 서비스</span>가 필요합니다.</p>
			<p>그리고 웰니스 관광은 건강과 휴식 등 <span>특수 목적 관광(Special Interesting Tourism: SIT)</span>과 유사함을 고려할 때 전문가를 통한 여행의 플랜이 수립되어야 합니다.</p>
			<p>따라서 부산웰니스관광 플랫폼은 부산웰니스관광은 물론이고 관련 인프라를 연계시키는 플랫폼을 구축할 것입니다. <br> 2021년에는 웹사이트를 개발하고 향후 플랫폼화하는 사업을 진행할 것입니다.</p>
		</div>
	</div>
<!-- <div class="sizeModal"> -->
<!-- 	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div> -->
<!-- </div> -->

<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
</html>