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
<link rel="stylesheet" type="text/css" href="${root }/css/intro_wellness.css">
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_platform.jsp" />
	
	<div class="m_title">부산웰니스관광 소개</div>
	<div class="m_sub_title">문체부 지정 국내 첫 '국제관광도시' 부산</div>
	<div class="intro_wellness_wrap">
		<div class="left_content">
			<div class="title">부산웰니스관광 소개</div>
			<div class="content_wrap">			
				<div class="little_title">문체부 지정 국내 첫 '국제관광도시' 부산</div>
				<div class="content_area">
					<p>
						부산은 풍부한 도시관광자원과 함께 이색적인 해양및 자연문화 콘텐츠를 다수 보유하고 있으며
						국제적 도시기반시설과 풍부한 생활, 문화 기반 이야기 자원을 보유하고 있고,
						국내 최초의 국제 관광도시로서 다양한 관광사업 및 인프라 구축이 추진되며
						아시아최고여행지 1위를 하기도 한 세계적으로 관광휴양지 기반이
						잘 갖추어져 있으며 해양레저도시로도 알려지고 있습니다.
					</p>
					<p>
						웰니스관광은 개인의 건강(Healthy)과 행복(Happiness) 그리고 삶의 질(Quality of Life)을 향상시키기 위한
						고차원의 종합적 목적의 관광형태로 치유관광, 건강관광, 힐링관광, 웰빙관광 등과 유사하나
						이 모든 관광을 포괄할 수 있는 가치를 추구하는 관광입니다.
					</p>
					<p>
						웰니스관광산업은 웰니스구성요소를 충족하는 시설 및 프로그램이 단위사업으로 규정되기보다는
						숙박, 체험, 식사 등 핵심 산업군과 결합된 형태로
						웰니스관광산업의 활성화는 여러 산업분야에 유의미한 영향이 있으며
					</p>
					<p> 부산 MICE관광의 활성화에도 기여할 것입니다.</p>
					<p> 부산은 글로벌 웰니스관광도시로 다시 한 번 도약할 것입니다.</p>
				</div>
			</div>
		</div>
		<div class="represent_img" style="background-image: url('${root}/img/view/intro/intro_wellness.svg');"></div>
	</div>

<!-- <div class="sizeModal"> -->
<!-- 	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div> -->
<!-- </div> -->
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>