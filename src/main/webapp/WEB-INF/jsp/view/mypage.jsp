<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/mypage.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
</head>
<body>
<c:set var="mode" value="${param.mode }" />

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />
	<c:if test="${empty member }">
		<script>
			alert('로그인이 필요한 메뉴입니다.')
			location.href = 'login'
		</script>
	</c:if>
	<c:if test="${not empty member }">
	<div class="mypage_main_wrap">
		<div class="top_info_member">반갑습니다 ${member.member_name }님!</div>
		<div class="mypage_category">
			<ul>
				<li class="info_li"><a href="${root }/mypage?mode=info">개인정보수정</a></li>
				<li class="pw_li"><a href="${root }/mypage?mode=pw">비밀번호 수정</a></li>
				<li><a href="${root }/like_list">내 관심목록</a></li>
				<li><a href="${root }/my_reserve">${member.member_grade == 3 ? '전체 예약현황' : '나의 예약현황' }</a></li>
				<li><a href="${root }/my_posting">${member.member_grade == 3 ? '게시글 관리' : '내 게시글 관리' }</a></li>
			</ul>
			<script>
				var mode = '${mode}'
				var infoLi = document.querySelector('.info_li')
				var pwLi = document.querySelector('.pw_li')
				if (mode == 'pw') {
					infoLi.style.backgroundColor = 'white'
					infoLi.style.color = 'black'
					pwLi.style.backgroundColor = '#72886C'
					pwLi.style.color = 'white'
				}
			</script>
		</div>
		<div class="password_check_main">
			<form class="password_check_form" method="POST">
				<p>본인 확인을 위해 비밀번호를 입력해주세요.</p>
				<p>비밀번호는 타인에게 노출되지 않도록 주의해주세요.</p>
				<input type="hidden" name="member_userid" value="${member.member_userid }">
				<input type="password" name="member_password" placeholder="비밀번호를 입력하세요.">
				<input type="submit" value="확인">
			</form>
		</div>
	</div>
	</c:if>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>

<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>