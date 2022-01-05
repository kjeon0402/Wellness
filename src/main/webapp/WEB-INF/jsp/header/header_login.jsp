<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${root }/css/header_login.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 메뉴별 헤더 -->
<div class="header_wrap">
	<!-- 배너 -->
	<div class="banner"><img src="${root}/img/view/header/header_login.svg"></div>
	<!-- 메뉴바 -->
	<div class="banner_menu_bar">
		<div class="bar_inner a"><a href="${root }/"><img src="${root }/img/view/header/banner_menu_bar_home.svg"></a></div>
		<div class="bar_inner b"><span>로그인</span><span><img src="${root }/img/view/header/downV.svg"></span></div>
<%-- 		<div class="bar_inner c"><span id="small_category"></span><span><img src="${root }/img/view/header/downV.svg"></span></div> --%>
	</div>
</div>


</body>
</html>