<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${root }/css/header_platform.css">
<meta charset="UTF-8">
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
		<div class="bar_inner b"><div style="width: 100%; display: flex; justify-content: space-between;"><span>부산웰니스관광플랫폼</span><span><img src="${root }/img/view/header/downV.svg"></span></div></div>
		<div class="bar_inner c"><div style="width: 100%; display: flex; justify-content: space-between;"><span id="small_category"></span><span><img src="${root }/img/view/header/downV.svg"></span></div></div>
	</div>
</div>

<script>
var link = window.location.href
var substring = 'intro_wellness'
var smallCategory = document.getElementById('small_category')
if(link.indexOf(substring) !== -1) {
	console.log('포함됨')
	smallCategory.innerText = '부산웰니스관광 소개'
}else if(link.indexOf('privacy') !== -1) {
	smallCategory.innerText = '개인정보취급방침'
}else if(link.indexOf('use_rule') !== -1) {
	smallCategory.innerText = '이용약관'
}else {
	console.log('안됨')
	smallCategory.innerText = '플랫폼 소개'
}
</script>

</body>
</html>