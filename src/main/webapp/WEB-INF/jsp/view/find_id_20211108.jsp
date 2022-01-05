<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	body {
		width: 100%;
		padding: 0;
		margin: 0;
		font-family: 'Nanum Gothic', sans-serif;
	}
	a {
		text-decoration: none;
		color: inherit;
		cursor: pointer;
	}
	.hidden {
		display: none;
	}
	.find_id_wrap {
		width: 30%;
		margin: auto;
		margin-top: 30px;
	}
	.find_id_wrap > .form_title {
		text-align: center;
		font-size: 24px;
		font-weight: bold;
	}
	.find_id_wrap > .find_id_form {
		width: 100%;
	}
	.find_id_wrap > .find_id_form > .search_category > ul {
		width: 100%;
		list-style: none;
		display: flex;
		padding: 0;
		margin: 25px 0;
	}
	.find_id_wrap > .find_id_form > .search_category > ul > li {
		width: 50%;
		border-bottom: 1px solid #707070;
		font-size: 16px;
		font-weight: bold;
		padding-bottom: 10px;
		text-align: center;
		cursor: pointer;
	}
	.find_id_wrap > .find_id_form > .search_category > ul > .email_choice {
		color: #72886C;
		border-bottom: 2px solid #72886C;
	}
	.find_id_wrap > .find_id_form > .name_input {
		width: 100%;
		padding-bottom: 15px;
		border-bottom: 1px solid #707070;
		display: flex; 
	}
	.find_id_wrap > .find_id_form > .name_input > input {
		all: unset;
		width: 93%;
		font-size: 14px;
		padding-left: 10px;
	}
	.find_id_wrap > .find_id_form > .name_input > .user_icon {
		width: 15px;
		height: 20px;
		background-size: 100%;
		background-position: center center;
		background-repeat: no-repeat;
	}
	.find_id_wrap > .find_id_form > .phone_input {
		width: 100%;
		display: flex; 
	}
	.find_id_wrap > .find_id_form > .phone_input > .phone_input_num {
		width: 100%;	
		padding: 15px 0;
		border-bottom: 1px solid #707070;
	}
	.find_id_wrap > .find_id_form > .phone_input > .phone_input_num > input {
		all: unset;
		width: 100%;
		font-size: 14px;
		padding-left: 10px;
	}
	.find_id_wrap > .find_id_form > .phone_input > .phone_input_num > .right_td_btn {
		width: 100px;
    	height: 25px;
    	border: 1px solid #707070;
    	color: #707070;
    	font-size: 13px;
    	background-color: white;
    	vertical-align: middle;
    	cursor: pointer;
    	display: flex;
    	justify-content: center;
    	align-items: center;
	}	
	.find_id_wrap > .find_id_form > .phone_input > .company_select {
		width: 45%;	
		padding: 15px 0;
		border-bottom: 1px solid #707070;
	}
	.find_id_wrap > .find_id_form > .phone_input > .company_select > select {
		border: none;
		width: 100%;
		outline: none;
	}
	.find_id_wrap > .find_id_form > .email_input {
		width: 100%;
		display: flex; 
		align-items: center;
	}
	.find_id_wrap > .find_id_form > .email_input > .email_input_text {
		width: 55%;	
		padding: 15px 0;
		border-bottom: 1px solid #707070;
		margin-right: 10px;
		display: flex;
	}
	.find_id_wrap > .find_id_form > .email_input > .email_input_text > input {
		all: unset;
		width: 50%;
		font-size: 14px;
		padding-left: 10px;
	}
	.find_id_wrap > .find_id_form > .email_input > .email_select {
		width: 45%;	
		padding: 15px 0;
		border-bottom: 1px solid #707070;
	}
	.find_id_wrap > .find_id_form > .email_input > .email_select > select {
		border: none;
		width: 100%;
		outline: none;
	}
	.find_id_wrap > .find_id_form > .email_input > .right_td_btn {
		width: 100px;
    	height: 25px;
    	border: 1px solid #707070;
    	color: #707070;
    	font-size: 13px;
    	background-color: white;
    	vertical-align: middle;
    	cursor: pointer;
    	display: flex;
    	justify-content: center;
    	align-items: center;
    	margin-left: 5px;
	}	
	.find_id_wrap > .find_id_form > input[type="submit"] {
		all: unset;
		width: 100%;
		margin: 20px 0;
		padding: 12px 0;
		font-size: 20px;
		font-weight: bold;
		background-color: #72886C;
		color: white;
		text-align: center;
		cursor: pointer;
	}
	.find_id_wrap > .join_search_login {
		width: 100%;
		text-align: center;
	}
	.find_id_wrap > .join_search_login > ul {
		list-style: none;
		padding: 0;
		margin: 0;
		display: flex;
		justify-content: center;
	}
	.find_id_wrap > .join_search_login > ul > li {
		border-right: 1px solid #707070;
		margin-right: 5px;
		padding-right: 5px;
		font-size: 13px;
	}
	.find_id_wrap > .join_search_login > ul > li:last-child {
		border-right: none;
	}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_login.jsp" />
	
	<c:if test="${not empty memberInfo }">
		<script>
			console.log('${memberInfo.member_userid}')
			alert('${memberInfo.member_userid}')
			location.href = 'login'
		</script>
	</c:if>
	
	<div class="find_id_wrap">
		<div class="form_title">아이디 찾기</div>
		<form class="find_id_form" method="POST">
			<div class="search_category">
				<ul>
					<li class="email_choice" onclick="emailSearchWay()">이메일</li>
					<li class="phone_choice" onclick="phoneSearchWay()">휴대폰번호</li>
				</ul>
			</div>
			<div class="name_input">
				<input type="text" name="member_name" placeholder="이름을 입력해주세요.">
				<div class="user_icon" style="background-image: url('${root}/img/view/member/user_icon.svg');"></div>
			</div>
			<div class="phone_input hidden" id="phone_input">
				<div class="phone_input_num">
					<input type="text" name="member_phone" id="member_phone" placeholder="-빼고 입력해주세요">
					<input type="hidden" id="sms_certification" value="">
					<div class="right_td_btn" onclick="smsCheck(find_id_form, '${root}')">인증하기</div>
					<script>
					// 휴대폰 인증 번호 입력 팝업
						function smsCheck(obj, root) {
							
							var member_name = $('#member_name').val();
							var member_phone = $('#member_phone').val();
							
							$.ajax({
								url : 'information_check_id_phone',
								type : 'post',
								data : {
									member_name : member_name,
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
				<div class="right_td_btn" onclick="emailCheck(find_id_form, '${root}')">인증하기</div>
				<script>
					// 휴대폰 인증 번호 입력 팝업
						function emailCheck(obj, root) {
							
							var member_name = $('#member_name').val();
							var member_email = $('#email_id').val() + '@' + $('#email_domain').val();
							
							
							$.ajax({
								url : 'information_check_id_email',
								type : 'post',
								data : {
									member_name : member_name,
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
			<input type="submit" id="find_id_submit" onclick="certificationCheck(event)" value="아이디 찾기">
		</form>
		<div class="join_search_login">
			<ul>
				<li><a href="${root }/join">회원가입</a></li>
				<li><a href="${root }/find_pw">비밀번호 찾기</a></li>
				<li><a href="${root }/login">로그인하기</a></li>
			</ul>
		</div>
	</div>
<script>
	function certificationCheck(event) {
		event.preventDefault()
		var findIdForm = document.getElementById('find_id_form')
		var email_certification = document.getElementById('email_certification')
		var sms_certification = document.getElementById('sms_certification')
		if(email_certification.value == '인증완료' || sms_certification.value == '인증완료') {
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


<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>