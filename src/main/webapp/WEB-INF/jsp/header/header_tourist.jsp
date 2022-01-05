<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${root }/css/header_tourist.css">
<title>Insert title here</title>
</head>
<body>
<!-- 메뉴별 헤더 -->
<div class="header_wrap">
	<!-- 배너 -->
	<div class="banner"><img src="${root}/img/view/header/header_platform.svg"></div>
	<!-- 메뉴바 -->
	<div class="banner_menu_bar">
		<div class="bar_inner a"><a href="${root }/"><img src="${root }/img/view/header/banner_menu_bar_home.svg"></a></div>
		<div class="bar_inner b"><span>부산웰니스관광지</span><span><img src="${root }/img/view/header/downV.svg"></span></div>
		<div class="bar_inner c"><span id="small_category"></span><span><img src="${root }/img/view/header/downV.svg"></span></div>
	</div>
</div>

<script>
var link = window.location.href
var smallCategory = document.getElementById('small_category')
if(link.indexOf('tour_list_nature') !== -1) {
	smallCategory.innerText = '자연교감'
}else if(link.indexOf('tour_list_ocean') !== -1) {
	smallCategory.innerText = '오션레져'
}else if(link.indexOf('tour_list_cosmetic') !== -1) {
	smallCategory.innerText = '뷰티&헬스,스파'
}else if(link.indexOf('tour_list_meal') !== -1) {
	smallCategory.innerText = '영양&식당'
}else if(link.indexOf('tour_list_hotel') !== -1) {
	smallCategory.innerText = '호텔&리조트'
}

if(link.indexOf('category=nature') !== -1) {
	smallCategory.innerText = '자연교감'
}else if(link.indexOf('category=ocean') !== -1) {
	smallCategory.innerText = '오션레져'
}else if(link.indexOf('category=cosmetic') !== -1) {
	smallCategory.innerText = '뷰티&헬스,스파'
}else if(link.indexOf('category=meal') !== -1) {
	smallCategory.innerText = '영양&식당'
}else if(link.indexOf('category=hotel') !== -1) {
	smallCategory.innerText = '호텔&리조트'
}

if(link.indexOf('package_list_nature') !== -1) {
	smallCategory.innerText = '자연교감형 패키지'
}else if(link.indexOf('package_list_ocean') !== -1) {
	smallCategory.innerText = '해양체험형 패키지'
}else if(link.indexOf('package_list_story') !== -1) {
	smallCategory.innerText = '스토리텔링형 패키지'
}

if('${pVO.package_category}' == '자연교감형') {
	smallCategory.innerText = '자연교감형 패키지'
}
if('${pVO.package_category}' == '해양체험형') {
	smallCategory.innerText = '해양체험형 패키지'
}
if('${pVO.package_category}' == '스토리텔링형') {
	smallCategory.innerText = '스토리텔링형 패키지'
}

if(link.indexOf('category=&') !== -1) {
	var removeDiv = document.querySelector('.c')
	removeDiv.remove();
}

if(link.indexOf('home_form_for_reservation') !== -1) {
	var removeDiv = document.querySelector('.c')
	removeDiv.remove();
}



</script>

</body>
</html>