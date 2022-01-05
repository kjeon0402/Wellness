<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/change_pw.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script>
// 메뉴 이동
	function goChangePersonnal() {
		location.href = 'mypage?mode=info'
	}
	function goChangePw() {
		location.href = 'mypage?mode=pw'
	}
	function goLikeList() {
		location.href = 'like_list'
	}
	function goMyReserve() {
		location.href = 'my_reserve'
	}
	function goMyPosting() {
		location.href = 'my_posting'
	}
</script>
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
		console.log(password1)
	}
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />
	
		<div class="mypage_main">
	        
	        <div class="mypage_main_wrap">
	        	<div class="top_info_member">반갑습니다 ${member.member_name }님!</div>
		        <div class="mypage_category">
					<ul>
						<li onclick="goChangePersonnal()">개인정보수정</li>
						<li onclick="goChangePw()">비밀번호 수정</li>
						<li onclick="goLikeList()">내 관심목록</li>
						<li onclick="goMyReserve()">${member.member_grade == 3 ? '전체 예약현황' : '나의 예약현황' }</li>
						<li onclick="goMyPosting()">${member.member_grade == 3 ? '게시글 관리' : '내 게시글 관리' }</li>
					</ul>
				</div>
				<div class="page_title">비밀번호 수정</div>
		        <div class="notice_password_change">
		        	<p>- 새로운 비밀번호를 입력하여 주십시오.</p>
		        	<p>- 연속된 숫자, 생일, 주민등록번호 등 알기 쉬운 숫자는 피해주시기 바랍니다.</p>
		        </div>
		        <div class="box_change_pw">
		        	<form class="change_pw_form" action="${root }/change_pw" method="POST" id="changepw_form">
						<input type="hidden" name="member_idx" value="${member.member_idx }">
		        		<div class="pre_password">
		        			<div class="pre_password_title">
		        				<span>비밀번호</span>
		        				<div class="need_icon" style="background-image: url('${root}/img/view/member/need_icon.svg');"></div>
		        			</div>
		        			<div class="pre_password_input">
		        				<input type="password" name="prepassword" placeholder="비밀번호를 입력하세요.">
		        				<p>(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</p>
		        			</div>
		        		</div>
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
		        			// 비밀번호 정규식
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
// 		$(function() {
// 			#("#submit").click(function(e) {
// 				e.preventDefault();
// 				var password_check = $('#password_check').val();
// 				if(password_check == 'false') {
// 					alert("잘못된 비밀번호를 입력하셨습니다.")
// 				} else {
// 					$("#changepw_form").submit()
// 				}
// 			})
// 		})
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
					alert('비밀번호 확인이 필요합니다.')
				}
			}
		}
	</script>
	
</body>
</html>