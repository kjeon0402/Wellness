<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/find_pw.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_login.jsp" />
	
<%-- 	<c:if test="${not empty memberinfo }"> --%>
<!-- 		<script> -->
<%-- 			console.log('${memberinfo}') --%>
<!-- 			location.href = 'find_pw_result' -->
<!-- 		</script> -->
<%-- 	</c:if> --%>
	
	<div class="find_pw_wrap">
		<div class="form_title">비밀번호 찾기</div>
		<form class="find_pw_form" method="POST" id="find_pw_form">
			<div class="search_category">
				<ul>
					<li class="email_choice" onclick="emailSearchWay()">이메일</li>
					<li class="phone_choice" onclick="phoneSearchWay()">휴대폰번호</li>
				</ul>
			</div>
			<div class="id_input">
				<input type="text" id="member_userid" name="member_userid" placeholder="아이디을 입력해주세요.">
				<div class="user_icon" style="background-image: url('${root}/img/view/member/user_icon.svg');"></div>
			</div>
			<div class="phone_input hidden" id="phone_input">
				<div class="phone_input_num">
					<input type="text" name="member_phone" id="member_phone" placeholder="-빼고 입력해주세요">
					<input type="hidden" id="sms_certification" value="">
					<div class="right_td_btn" onclick="smsCheck(find_pw_form, '${root}')">인증하기</div>
					<script>
						// 휴대폰 인증 번호 입력 팝업
							function smsCheck(obj, root) {
								
								var member_userid = $('#member_userid').val();
								var member_phone = $('#member_phone').val();
								
								$.ajax({
									url : 'information_check_pw_phone',
									type : 'post',
									data : {
										member_userid : member_userid,
										member_phone : member_phone
									},
									success : function(data) {
										if ($.trim(data) == 0) {
											if(obj.member_phone.value == "") {
												alert('휴대폰 번호를 입력하세요');
												obj.member_phone.focus();
												return false;
											} else {
												let url = root + "/sendSMS?member_phone=" + obj.member_phone.value;
												window.open(url, "", "width=400, height=200");
											}
										} else {
											alert("정보를 다시 입력해주세요.");
										}
									},
									error : function() {
										alert("에러입니다");
									}
								});
							}
						</script>
				</div>
			</div>
			<div class="email_input" id="email_input">
				<div class="email_input_text">
					<input type="text" name="member_email" id="email_id" placeholder="가입한 이메일 주소">@
					<input type="text" name="member_email_domain" id="email_domain">
				</div>
				<div class="email_select">
					<select onchange="this.form.member_email_domain.value=this[this.selectedIndex].value;">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
					</select>
				</div>
				<input type="hidden" id="email_certification" value="">
				<div class="right_td_btn" onclick="emailCheck(find_pw_form, '${root}')">인증하기</div>
				<script>
					// 휴대폰 인증 번호 입력 팝업
						function emailCheck(obj, root) {
							
							var member_userid = $('#member_userid').val();
							var member_email = $('#email_id').val() + '@' + $('#email_domain').val();
							
							
							$.ajax({
								url : 'information_check_pw_email',
								type : 'post',
								data : {
									member_userid : member_userid,
									member_email : member_email
								},
								success : function(data) {
									if ($.trim(data) == 0) {
										if(obj.email_id.value == "" || obj.email_domain.value == "") {
											alert('이메일를 입력하세요');
											obj.email_id.focus();
											return false;
										} else {
											let url = root + "/sendEmail?member_email=" + member_email;
											window.open(url, "", "width=400, height=200");
										}
									} else {
										alert("정보를 다시 입력해주세요.");
									}
								},
								error : function() {
									alert("에러입니다");
								}
							});
						}
					</script>
			</div>
			<input type="submit" onclick="certificationCheck(event)" value="비밀번호 찾기">
		</form>
		<div class="join_search_login">
			<ul>
				<li><a href="${root }/join">회원가입</a></li>
				<li><a href="${root }/find_id">아이디 찾기</a></li>
				<li><a href="${root }/login">로그인하기</a></li>
			</ul>
		</div>
	</div>
<script>
function certificationCheck(event) {
	event.preventDefault()
	var findIdForm = document.getElementById('find_pw_form')
	var sms_certification = document.getElementById('sms_certification')
	var email_certification = document.getElementById('email_certification')
	if(sms_certification.value == '인증완료' || email_certification.value == '인증완료') {
		findIdForm.submit()
	} else {
		alert('인증을 진행해야합니다.')
		return
	}
}
</script>
<script>
	const emailChoice = document.querySelector('.email_choice')
	const phoneChoice = document.querySelector('.phone_choice')
	const phoneInput = document.getElementById('phone_input')
	const emailInput = document.getElementById('email_input')
	
	function emailSearchWay() {
		phoneInput.classList.add('hidden')
		phoneChoice.style.color = "black"
		phoneChoice.style.borderBottom = "1px solid #707070"
		emailInput.classList.remove('hidden')
		emailChoice.style.color = "#72886C"
		emailChoice.style.borderBottom = "2px solid #72886C"
	}
	function phoneSearchWay() {
		phoneInput.classList.remove('hidden')
		phoneChoice.style.color = "#72886C"
		phoneChoice.style.borderBottom = "2px solid #72886C"
		emailInput.classList.add('hidden')
		emailChoice.style.color = "black"
		emailChoice.style.borderBottom = "1px solid #707070"
	}
</script>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>

<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>