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
body {
	width: 100%;
	padding: 0;
	margin: 0;
    font-family: 'Nanum Gothic', sans-serif;
}
.header_wrap {
	width: 100%;
	height: 200px;
/* 	margin: 100px 0 0 0; */
	padding: 0;
/* 	position: absolute; */
	z-index: -1;
}
.banner {
	width: 100%;
	height: 150px;
	background-image: url("${root}/img/view/header/header_tourist.svg");
	background-size: 100%;
}
.banner_menu_bar {
	width: 100%;
	height: 50px;
	background-color: #D9D9D9;
	display: flex;
}
.bar_inner {
	border-right: 1px solid #707070;
}
.a {
	width: 5%;
	margin-left: 10%;
	text-align: center;
	padding: 15px 0 0 15px;
}
.b, .c {
	width: 10%;
	padding-top: 15px;
	text-align: center;
}
select {
	outline: none;
	background-color: #D9D9D9;
	border: none;
}
</style>
			
</head>
<body>
<!-- 메뉴별 헤더 -->
<div class="header_wrap">
	<!-- 배너 -->
	<div class="banner"></div>
	<!-- 메뉴바 -->
	<div class="banner_menu_bar">
		<div class="bar_inner a"><img src="${root }/img/view/header/banner_menu_bar_home.svg"></div>
		<div class="bar_inner b">
			<select id="big_category" onchange="showSmall()">
				<option value="a">부산웰니스관광플랫폼</option>
				<option value="b" selected>부산웰니스관광지</option>
				<option value="c">관광/체험 예약</option>
				<option value="d">소식</option>
				<option value="e">로그인</option>
				<option value="f">마이페이지</option>
			</select>
		</div>
		<div class="bar_inner c">
			<select id="small_category" onchange="smallValue()"></select>
		</div>
	</div>
</div>

<script>
// 페이지를 처음 불러왔을때
var bigCategoryValue = document.getElementById('big_category').value;
var smallCategory = document.getElementById('small_category');
switch(bigCategoryValue) {
case 'a' : 
	var optionA = document.createElement('option');
	var optionB = document.createElement('option');
	optionA.innerText = '부산웰니스관광 소개';
	optionA.value = '${root}/intro_wellness';
	optionB.innerText = '플랫폼 소개';
	optionB.value = '${root}/intro_platform';
	var smallVal = sessionStorage.getItem('headerValue');
	switch(smallVal){
	case '${root}/intro_wellness' :
		optionA.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/intro_platform' :
		optionB.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	}
	smallCategory.append(optionA);
	smallCategory.append(optionB);
	break;
case 'b' :
	var optionA = document.createElement('option');
	var optionB = document.createElement('option');
	var optionC = document.createElement('option');
	var optionD = document.createElement('option');
	var optionE = document.createElement('option');
	optionA.innerText = '자연교감';
	optionA.value = "#";
	optionB.innerText = '오션레저';
	optionB.value = "#";
	optionC.innerText = '뷰티&헬스/스파';
	optionC.value = "#";
	optionD.innerText = '영양/식당';
	optionD.value = "#";
	optionE.innerText = '호텔/리조트';
	optionE.value = "#";
	var smallVal = sessionStorage.getItem('headerValue');
	switch(smallVal){
	case '${root}/#' :
		optionA.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/#' :
		optionB.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/#' :
		optionC.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/#' :
		optionD.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/#' :
		optionE.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	}
	smallCategory.append(optionA);
	smallCategory.append(optionB);
	smallCategory.append(optionC);
	smallCategory.append(optionD);
	smallCategory.append(optionE);
	break;
case 'c' :
	var optionA = document.createElement('option');
	var optionB = document.createElement('option');
	optionA.innerText = '예약하기';
	optionA.value = '#';
	optionB.innerText = '나의 예약현황';
	optionB.value = '#';
	var smallVal = sessionStorage.getItem('headerValue');
	switch(smallVal){
	case '${root}/intro_wellness' :
		optionA.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/intro_platform' :
		optionB.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	}
	smallCategory.append(optionA);
	smallCategory.append(optionB);
	break;	
case 'd' : 
	var optionA = document.createElement('option');
	var optionB = document.createElement('option');
	var optionC = document.createElement('option');
	optionA.innerText = '공지/이벤트';
	optionA.value = "#";
	optionB.innerText = '웰니스갤러리';
	optionB.value = "#";
	optionC.innerText = '웰니스행사소식';
	optionC.value = "#";
	var smallVal = sessionStorage.getItem('headerValue');
	switch(smallVal){
	case '${root}/intro_wellness' :
		optionA.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/intro_platform' :
		optionB.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	case '${root}/intro_platform' :
		optionC.selected = true;
		sessionStorage.removeItem('headerValue')
		break;
	}	
	smallCategory.append(optionA);
	smallCategory.append(optionB);
	smallCategory.append(optionC);
	break;
case 'e' :
	var secondSelectDiv = document.querySelector('.c');
	secondSelectDiv.parentNode.removeChild(secondSelectDiv);
	break;
case 'f' :
	var secondSelectDiv = document.querySelector('.c');
	secondSelectDiv.parentNode.removeChild(secondSelectDiv);
	break;
}
// 큰 카테고리가 변경되었을 때
function showSmall() {
	var bigValue = document.getElementById('big_category').value;
	var smallCategory = document.getElementById('small_category');
	var smallOption = document.getElementById('small_category').querySelectorAll('option');
	switch(bigValue) {
	case 'a' :
		for(let i = 0; i < smallOption.length; i++) {
			smallCategory.removeChild(smallOption[i]);
		}
		var optionA = document.createElement('option');
		var optionB = document.createElement('option');
		optionA.innerText = '부산웰니스관광 소개';
		optionA.value = '${root}/wellness_intro';
		optionB.innerText = '플랫폼 소개';
		optionB.value = '${root}/platform_intro';
		smallCategory.append(optionA);
		smallCategory.append(optionB);
		break;
	case 'b' :
		for(let i = 0; i < smallOption.length; i++) {
			smallCategory.removeChild(smallOption[i]);
		}
		var optionA = document.createElement('option');
		var optionB = document.createElement('option');
		var optionC = document.createElement('option');
		var optionD = document.createElement('option');
		var optionE = document.createElement('option');
		optionA.innerText = '자연교감';
		optionA.value = "#";
		optionB.innerText = '오션레저';
		optionB.value = "#";
		optionC.innerText = '뷰티&헬스/스파';
		optionC.value = "#";
		optionD.innerText = '영양/식당';
		optionD.value = "#";
		optionE.innerText = '호텔/리조트';
		optionE.value = "#";
		smallCategory.append(optionA);
		smallCategory.append(optionB);
		smallCategory.append(optionC);
		smallCategory.append(optionD);
		smallCategory.append(optionE);
		break;
	case 'c' :
		for(let i = 0; i < smallOption.length; i++) {
			smallCategory.removeChild(smallOption[i]);
		}
		var optionA = document.createElement('option');
		var optionB = document.createElement('option');
		optionA.innerText = '예약하기';
		optionA.value = '#';
		optionB.innerText = '나의 예약현황';
		optionB.value = '#';
		smallCategory.append(optionA);
		smallCategory.append(optionB);
		break;	
	case 'd' : 
		for(let i = 0; i < smallOption.length; i++) {
			smallCategory.removeChild(smallOption[i]);
		}
		var optionA = document.createElement('option');
		var optionB = document.createElement('option');
		var optionC = document.createElement('option');
		optionA.innerText = '공지/이벤트';
		optionA.value = "#";
		optionB.innerText = '웰니스갤러리';
		optionB.value = "#";
		optionC.innerText = '웰니스행사소식';
		optionC.value = "#";
		smallCategory.append(optionA);
		smallCategory.append(optionB);
		smallCategory.append(optionC);
		break;
	case 'e' :
		location.href = '${root}/#';
		break;
	case 'f' :
		location.href = '${root}/#';
		break;
	}
}
// 소분류 선택시 이동 및 세션에 값추가
function smallValue() {
	var smallCategory = document.getElementById('small_category').value;
	switch(smallCategory) {
	case '${root}/intro_wellness' :
		sessionStorage.setItem('headerValue', smallCategory);
		location.href = smallCategory;
		break;
	case '${root}/intro_platform' :
		sessionStorage.setItem('headerValue', smallCategory);
		location.href = smallCategory;
		break;
	}
}
</script>


</body>
</html>