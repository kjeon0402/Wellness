<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/login.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_login.jsp" />
	
	<script>
		var findInfo = '${findID}'
		if(findInfo != '') {
			alert('회원님의 아이디는 [ ' + findInfo + ' ] 입니다.')
		}
	</script>
	
	<div class="login_wrap">
		<div class="form_title">로그인</div>
		<form class="login_form" method="POST">
			<div class="id_input">
				<input type="text" id="userId" name="member_userid" placeholder="아이디">
				<div class="user_icon" style="background-image: url('${root}/img/view/member/user_icon.svg');"></div>
			</div>
			<div class="password_input">
				<input type="password" name="member_password" placeholder="비밀번호">
				<div class="lock_icon" style="background-image: url('${root}/img/view/member/lock_icon.svg');"></div>
			</div>
			<div class="remember_id">
				<label><input type="checkbox" id="idSaveCheck" name="check_rememeber_id">&nbsp;아이디 저장하기</label>
				<script>
					$(document).ready(function(){
						 
					    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
					    var key = getCookie("key");
					    $("#userId").val(key); 
					     
					    if($("#userId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
					        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
					    }
					     
					    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
					        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
					            setCookie("key", $("#userId").val(), 7); // 7일 동안 쿠키 보관
					        }else{ // ID 저장하기 체크 해제 시,
					            deleteCookie("key");
					        }
					    });
					     
					    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
					    $("#userId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
					        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
					            setCookie("key", $("#userId").val(), 7); // 7일 동안 쿠키 보관
					        }
					    });
					});
					 
					function setCookie(cookieName, value, exdays){
					    var exdate = new Date();
					    exdate.setDate(exdate.getDate() + exdays);
					    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
					    document.cookie = cookieName + "=" + cookieValue;
					}
					 
					function deleteCookie(cookieName){
					    var expireDate = new Date();
					    expireDate.setDate(expireDate.getDate() - 1);
					    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
					}
					 
					function getCookie(cookieName) {
					    cookieName = cookieName + '=';
					    var cookieData = document.cookie;
					    var start = cookieData.indexOf(cookieName);
					    var cookieValue = '';
					    if(start != -1){
					        start += cookieName.length;
					        var end = cookieData.indexOf(';', start);
					        if(end == -1)end = cookieData.length;
					        cookieValue = cookieData.substring(start, end);
					    }
					    return unescape(cookieValue);
					}
					</script>
			</div>
			<input type="submit" value="로그인">
		</form>
		<div class="join_search_login">
			<ul>
				<li><a href="${root }/join">회원가입</a></li>
				<li><a href="${root }/find_id">아이디 찾기</a></li>
				<li><a href="${root }/find_pw">비밀번호 찾기</a></li>
			</ul>
		</div>
	</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
</html>