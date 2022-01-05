<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${root }/css/footer.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- footer wrap -->
<footer>
		<div class="menu_wrap">
			<div class="footer_menu">
				<span style="font-weight: bold;"><a href="${root }/privacy_rule">개인정보취급방침</a></span>
				<span>|</span>
				<span><a href="${root }/use_rule">이용약관</a></span>
			</div>
			<div class="link_other_page">
				<select style="cursor: pointer;" onchange="window.open(this.options[this.selectedIndex].value,'_blank')">
					<option disabled selected hidden>유관기관 바로가기</option>
					<option value="http://www.biwc.kr/">부산국제웰니스컨퍼런스</option>
					<option value="https://bto.or.kr/kor/Main.do">부산관광공사</option>
					<option value="https://www.visitbusan.net/kr/index.do">부산관광포털 비짓부산</option>
					<option value="http://busan.tourbiz.or.kr/kor/Main.do">부산관광기업지원센터</option>
				</select>
			</div>
		</div>
		<div class="info_wrap">
			<!-- 로고 -->
			<div class="footer_logo"><img src="${root }/img/view/header/wellness_logo.svg"></div>
			<!-- 정보 -->
			<div class="footer_info">
				<div class="f_address">(우)48059, 부산광역시 해운대구 센텀동로 57, 8층 803호 (우동, 부산디자인센터)</div>
				<div class="f_tel_fax">
					<span>TEL. 051-781-1990</span>
					<span>|</span>
					<span>FAX. 051-731-1951</span>
				</div>
				<div class="f_copyright">Copyright ⓒ <span>부산웰니스관광플랫폼.</span> All Rights Reserved. Designed by 더웰.</div>
			</div>
		</div>
</footer>

</body>
</html>