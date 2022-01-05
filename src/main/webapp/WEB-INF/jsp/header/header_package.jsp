<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* body { */
/* 	width: 100%; */
/* 	padding: 0; */
/* 	margin: 0; */
/*     font-family: 'Nanum Gothic', sans-serif; */
/* } */
.header_wrap {
	width: 100%;
/* 	height: 200px; */
/* 	margin: 100px 0 0 0; */
	padding: 0;
/* 	position: absolute; */
	z-index: -1;
}
.banner {
	width: 100%;
	line-height: 0;
/* 	height: 150px; */
/* 	background-image: url("${root}/img/view/header/header_login.svg"); */
/*  	background-size: 100%; */
/* 	background-repeat: no-repeat; */
}
.banner img {
	width: 100%;
}
.a {
	width: 5%;
	margin-left: 10%;
	text-align: center;
	padding: 9px 0 0 9px;
}
.b, .c {
	width: 10%;
	padding-top: 7px;
	text-align: center;
}
.big_cate, .small_cate {
	outline: none;
	background-color: #D9D9D9;
	border: none;
	color: black;
	font-weight: bold;
}
.bar_inner span:first-child {
	font-size: 13px;
	float: left;
	margin-left: 10px;
	margin-top: 3px;
}
.bar_inner span:last-child {
	float: right;
	margin-right: 10px;
}
</style>
			
</head>
<body>
<!-- 메뉴별 헤더 -->
<div class="header_wrap">
	<!-- 배너 -->
	<div class="banner"><img src="${root}/img/view/header/header_tourist.svg"></div>
	<!-- 메뉴바 -->
	<div class="banner_menu_bar">
		<div class="bar_inner a"><a href="${root }/"><img src="${root }/img/view/header/banner_menu_bar_home.svg"></a></div>
		<div class="bar_inner b"><span>관광/체험 예약</span><span><img src="${root }/img/view/header/downV.svg"></span></div>
		<div class="bar_inner c"><span id="small_category"></span><span><img src="${root }/img/view/header/downV.svg"></span></div>
	</div>
</div>

<script>
var link = window.location.href
var substring = 'intro_wellness'
var smallCategory = document.getElementById('small_category')
if(link.indexOf(substring) !== -1) {
	console.log('포함됨')
	smallCategory.innerText = '부산웰니스관광 소개'
}else {
	console.log('안됨')
	smallCategory.innerText = '플랫폼 소개'
}
</script>

</body>
</html>