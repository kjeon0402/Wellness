<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
/* @media screen and (max-width: 1500px) { */
/* 	.sizeModal { */
/* 		width: 1500px; */
/* 	    height: 50000px; */
/* 	    background-color: black; */
/* 	    opacity: 0.8; */
/* 	    position: fixed; */
/* 	    top: 0; */
/* 	    z-index: 5; */
/* 	    display: block !important; */
/* 	} */
/* 	.textModal { */
/* 		width: 1500px; */
/* 	    color: white; */
/* 	    font-size: 80px; */
/* 	    margin: 124px auto; */
/* 	    text-align: center; */
/* 	    line-height: 3; */
/* 	    z-index: 6; */
/* 	    display: block !important; */
/* 	} */
/* } */
.sizeModal {
	display: none;
}
.textModal {
	display: none;
}
body {
	min-width: 100%;
        padding: 0;
        margin: 0;
        width: 100%;
        font-family: 'Nanum Gothic', sans-serif;
    }
    a {
    	text-decoration: none;
    	color: inherit;
    	cursor: pointer;
    }
    .hidden {
    	display: none !important;
    }
    .mypage_main {
        width: 100%;
/*         float: left; */
    }
    .mypage_main > .mypage_main_wrap {
    	width: 52%;
    	margin: auto;
    	margin-top: 30px;
    }
    .mypage_main_wrap > .top_info_member {
		width: 100%;
		border-bottom: 1px solid #707070;
		margin: 20px 0;
		padding-bottom: 10px;
		font-size: 18px;
		font-weight: bold;
	}
	.mypage_main_wrap > .mypage_category {
		width: 100%;
	}
	.mypage_main_wrap > .mypage_category > ul {
		width: 100%;
		display: flex;
		justify-content: space-between;
		list-style: none;
		margin: 0;
		padding: 0;
		margin-bottom: 40px;
	}
	.mypage_main_wrap > .mypage_category > ul > li {
		width: 150px;
		padding: 10px;
		border: 1px solid #707070;
		text-align: center;
		font-weight: bold;
		cursor: pointer;
	}
	.mypage_main_wrap > .mypage_category > ul > li:nth-child(2) {
		background-color: #72886C;
		color: white;
	}
	.mypage_main > .mypage_main_wrap > .page_title {
		border-bottom: 1px solid #707070;
		font-size: 18px;
		font-weight: bold;
		padding-bottom: 10px;
	}
    .mypage_main > .mypage_main_wrap > .notice_password_change {
    	margin: 20px 0;
    }
    .mypage_main > .mypage_main_wrap > .notice_password_change > p {
    	margin: 0;
    	margin-bottom: 10px;
    	font-size: 13px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw {
    	width: 100%;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password {
    	display: flex;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_title {
    	width: 20%;
    	font-size: 13px;
    	font-weight: bold;
    	display: flex;
    	align-items: center;
    	background-color: #F4F2F2;
    	padding: 20px 0;
    	border-bottom: 1px solid #707070;
    	border-top: 1px solid #707070;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_title > span {
    	margin-left: 15px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_title > .need_icon {
    	width: 12px;
    	height: 15px;
    	background-size: 100%;
    	background-position: center center;
    	background-repeat: no-repeat;
    	margin-right: 5px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_input {
    	width: 80%;
    	padding: 20px 0;
    	border-bottom: 1px solid #707070;
    	border-top: 1px solid #707070;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_input > input {
    	all: unset;
    	width: 250px;
    	font-size: 12px;
    	border-bottom: 1px solid #707070;
    	padding: 5px;
    	margin-left: 25px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_input > span {
    	margin-left: 25px;
    	margin-top: 5px;	
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password > .new_password_input > p {
    	margin: 0;
    	margin-top: 5px;
    	margin-left: 25px;
    	font-size: 11px;
    	font-weight: bold;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check {
    	display: flex;
    	margin-bottom: 15px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_title {
    	width: 20%;
    	font-size: 13px;
    	font-weight: bold;
    	display: flex;
    	align-items: center;
    	background-color: #F4F2F2;
    	padding: 20px 0;
    	border-bottom: 1px solid #707070;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_title > span {
    	margin-left: 15px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_title > .need_icon {
    	width: 12px;
    	height: 15px;
    	background-size: 100%;
    	background-position: center center;
    	background-repeat: no-repeat;
    	margin-right: 5px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_input {
    	width: 80%;
    	display: flex;
    	padding: 20px 0;
    	border-bottom: 1px solid #707070;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_input > input {
    	all: unset;
    	width: 250px;
    	font-size: 12px;
    	border-bottom: 1px solid #707070;
    	padding: 5px;
    	margin-left: 25px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_input > .co_check_btn {
    	border: 1px solid #707070;
    	font-size: 12px;
    	color: #707070;
    	padding: 5px 25px;
    	cursor: pointer;
    	margin-left: 10px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_input > .text_co_password {
    	font-size: 10px;
    	color: blue;
    	padding: 5px;
    	display: flex;
    	align-items: center;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .new_password_check > .new_password_check_input > .text_noco_password {
    	font-size: 10px;
    	color: red;
    	padding: 5px;
    	display: flex;
    	align-items: center;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .button_area {
    	text-align: center;
    	margin-top: 30px;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .button_area input[type="button"] {
    	all: unset;
    	font-size: 13px;
    	font-weight: bold;
    	padding: 5px 35px;
    	border: 1px solid #72886C;
    	border-radius: 50px;
    	cursor: pointer;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .button_area > input[name="change_btn"] {
    	background-color: #72886C;
    	color: white;
    }
    .mypage_main > .mypage_main_wrap > .box_change_pw > .change_pw_form > .button_area input[name="cancel"] {
    	color: #72886C;
    	margin-left: 5px;
    }
</style>
<script>
// 비밀번호 일치 여부
	function checkPassword() {
		const password1 = document.getElementById('password1').value
		const password2 = document.getElementById('password2').value
		
		if(password1 == password2 && password1 != '') {
			document.querySelector('.text_co_password').classList.remove('hidden')
			document.querySelector('.text_noco_password').classList.add('hidden')
			var checkForCheck = document.getElementById('checkForCheck')
			checkForCheck.value = 'true'
		} 
// 		else if(password1 == '' || password2 == '') {
// 			document.querySelector('.text_co_password').classList.add('hidden')
// 			document.querySelector('.text_noco_password').classList.add('hidden')
// 		}
		else {
			document.querySelector('.text_noco_password').classList.remove('hidden')
			document.querySelector('.text_co_password').classList.add('hidden')
		}
	}
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />
	
		<div class="mypage_main">
	        
	        <div class="mypage_main_wrap">
				<div class="page_title">비밀번호 수정</div>
		        <div class="notice_password_change">
		        	<p>- 새로운 비밀번호를 입력하여 주십시오.</p>
		        	<p>- 연속된 숫자, 생일, 주민등록번호 등 알기 쉬운 숫자는 피해주시기 바랍니다.</p>
		        </div>
		        <div class="box_change_pw">
		        	<form class="change_pw_form" action="${root }/find_pw_result" method="POST">
		        		<input type="hidden" name="member_idx" value="${mvo.member_idx }">
		        		<input type="hidden" name="prepassword" value="${mvo.member_password }">
		        		<div class="new_password">
		        			<div class="new_password_title">
		        				<span>새비밀번호</span>
		        				<div class="need_icon" style="background-image: url('${root}/img/view/member/need_icon.svg');"></div>
		        			</div>
		        			<div class="new_password_input">
		        				<input type="password" class="pw" name="newpassword" id="password1" placeholder="비밀번호를 입력하세요.">
		        				<span id="pw_true" style="display: none; color: blue; font-size: 11px;">사용가능</span>
    							<span id="pw_false" style="display: none; color: red; font-size: 11px;">사용불가</span>
		        				<input type="hidden" id="password_check" value="false">
		        				<p>(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</p>
		        			</div>
		        			<script>
		        			$('.pw').focusout(
									function (){
										var pw = $("#password1").val();
										var num = pw.search(/[0-9]/g);
										var eng = pw.search(/[a-z]/ig);
										var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

										if(pw.length < 10 || pw.length > 16){
											$("#pw_false").css('display', 'block');
											$("#pw_true").css('display', 'none');
											$('#password_check').val('false');
										} else if(pw.search(/\s/) != -1){
											$("#pw_false").css('display', 'block');
											$("#pw_true").css('display', 'none');
											$('#password_check').val('false');
										} else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
											$("#pw_false").css('display', 'block');
											$("#pw_true").css('display', 'none');
											$('#password_check').val('false');
										} else {
											$("#pw_true").css('display', 'block');
											$("#pw_false").css('display', 'none');
											$('#password_check').val('true');
									 }
									}
								);
		        				
		        			</script>
		        		</div>
		        		<div class="new_password_check">
		        			<div class="new_password_check_title">
		        				<span>새비밀번호 확인</span>
		        				<div class="need_icon" style="background-image: url('${root}/img/view/member/need_icon.svg');"></div>
		        			</div>
		        			<div class="new_password_check_input">
		        				<input type="password" name="password" id="password2" placeholder="새비밀번호 확인">
		        				<input type="hidden" id="checkForCheck" value="false">
		        				<div class="co_check_btn" onclick="checkPassword()">확인</div>
		        				<div class="text_co_password hidden">비밀번호가 일치합니다.</div>
		        				<div class="text_noco_password hidden">비밀번호가 일치하지 않습니다.</div>
		        			</div>
		        		</div>
		        		<div class="button_area">
			        		<input onclick="checkSubmit(event)" type="button" name="change_btn" value="완료">
			        		<a href="javascript:history.back();"><input type="button" name="cancel" value="취소"></a>
		        		</div>
		        	</form>
		        </div>
	        </div>
        </div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
	<script>
		function checkSubmit(event) {
			event.preventDefault();
			var pwCheck = document.getElementById('password_check')
			var form = document.querySelector('.change_pw_form')
			if(pwCheck.value == 'false') {
				alert("잘못된 비밀번호를 입력하셨습니다.")
			}else {
				if(document.getElementById('checkForCheck').value == 'true'){
					form.submit();
				}else {
					alert("비밀번호 확인이 필요합니다")
				}
			}
		}
	</script>
</body>
</html>