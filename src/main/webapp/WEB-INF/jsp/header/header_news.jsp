<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${root }/css/header_news.css">
<title>Insert title here</title>
</head>
<body>
<!-- 메뉴별 헤더 -->
<div class="header_wrap">
	<!-- 배너 -->
	<div class="banner"><img src="${root}/img/view/header/header_news.svg"></div>
	<!-- 메뉴바 -->
	<div class="banner_menu_bar">
		<div class="bar_inner a"><a href="${root }/"><img src="${root }/img/view/header/banner_menu_bar_home.svg"></a></div>
		<div class="bar_inner b"><span>소식</span><span><img src="${root }/img/view/header/downV.svg"></span></div>
		<div class="bar_inner c"><span id="small_category"></span><span><img src="${root }/img/view/header/downV.svg"></span></div>
	</div>
</div>

<script>
var link = window.location.href
var smallCategory = document.getElementById('small_category')
if(link.indexOf('notice') !== -1) {
	smallCategory.innerText = '공지사항'
}
if(link.indexOf('event') !== -1) {
	smallCategory.innerText = '이벤트'
}
if(link.indexOf('event_wellness') !== -1) {
	smallCategory.innerText = '웰니스행사소식'
}
if(link.indexOf('gallery') !== -1) {
	smallCategory.innerText = '웰니스갤러리'
}

</script>

</body>
</html>