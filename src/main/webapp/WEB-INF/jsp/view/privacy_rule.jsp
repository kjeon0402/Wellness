<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/privacy_rule.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_platform.jsp" />


<div class="privacy_wrap">
	<div class="privacy_title">개인정보 취급방침</div>
	<div class="privacy_content">
		<span>개인정보 수집 및 이용</span><br>

개인정보보호법에 따라 ‘부산웰니스관광 플랫폼’에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.<br>
<br>
<span>1. 수집∙이용 목적</span><br>
회원가입, 서비스 이용, 상담 및 부정 거래 기록 확인, 서비스 이용 가능 연령 확인 및 본인 여부 확인, 이용자의 상품 및 서비스 이용 실적 정보를 활용한 통계 분석 및 상품 서비스 개선 제공, 맞춤형 서비스 제공을 위한 이용자 식별<br>
<br>
<span>2. 수집 항목</span><br>	
[회원가입]<br>
회원가입 시점에 ‘부산웰니스관광 플랫폼’이 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 주소, 이메일, 휴대전화번호’를 필수항목으로 수집합니다. 그리고 선택항목으로 ‘생년월일, 성별, 소속, 직업’ 정보를 수집합니다.<br>
<br>
[서비스 이용 및 부정거래 기록 확인]<br>
서비스 이용시간/이용기록, 접수로그, 이용컨텐츠, 접속IP정보, 기기모델명, 브라우저 정보<br>
<br>
[이벤트]<br>
- 당첨자 이름, 주소, 휴대전화 번호<br>
<br>
[예약/결제]<br>
- 공통 : 예약자 이름, 연락처, 이메일<br>
- 계좌이체 시 : 은행명, 계좌번호, 예금주명<br>
- 취소.환불 시 : 은행명, 계좌번호, 예금주명<br>
<br>
<span>3. 보유∙이용기간</span><br>
- 회원 탈퇴 요청일로 부터 3개월 간 보관<br>
- 관계법령에 따라 보존할 필요가 있는 경우 관련 법령에서 요구하는 기한까지 보관<br>
	</div>
</div>


<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />


</body>
</html>