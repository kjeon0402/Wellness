<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/change_personnal.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
// 주소 api
	function sample6_execDaumPostcode(event) {
	event.preventDefault()
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
//             var extraAddr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
//                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
//                     extraAddr += data.bname;
//                 }
//                 if(data.buildingName !== '' && data.apartment === 'Y'){
//                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
//                 }
//                 if(extraAddr !== ''){
//                     extraAddr = ' (' + extraAddr + ')';
//                 }
//                 document.getElementById("sample6_extraAddress").value = extraAddr;
//             } else {
//                 document.getElementById("sample6_extraAddress").value = '';
            }
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>
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
<body>
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />
	
<div class="change_personnal_wrap">
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
    <div class="change_personnal_form">
	    <form action="${root }/change_personnal" method="POST" id="change_personnal_form">
	    	<!-- 기본정보 -->
	    	<div class="change_personnal_text_left">기본정보</div>
	    	<!-- 필수입력사항 -->
	    	<div class="change_personnal_text_right"><span style="color: red;">* </span><span>필수입력사항</span></div>
	    	<!-- 입력 테이블 -->
	    	<div class="change_personnal_table_div">
	    		<table class="change_personnal_table">
	    			<tbody>
	    				<tr>
	    					<td class="left_td"><span>아이디</span><span style="color: red;"> *</span></td>
	    					<td class="right_td">
	    						<div><input type="text" name="member_userid" placeholder="ID" value="${member.member_userid }" autofocus required readonly></div>
	    						<div class="rule">(영문소문자/숫자, 4~16글자)</div>
	    						<input type="hidden" name="member_idx" value="${member.member_idx }">
	    					</td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>이름</span><span style="color: red;"> *</span></td>
	    					<td class="right_td"><input type="text" name="member_name" value="${member.member_name }" required readonly></td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>주소</span><span style="color: red;"> *</span></td>
	    					<td class="right_td">
	    						<div><input type="text" name="member_post" id="postcode" placeholder="우편번호" value="${member.member_post }" required><button class="right_td_btn" onclick="sample6_execDaumPostcode(event)">주소검색</button></div>
	    						<div><input type="text" name="member_address" id="address" placeholder="주소" value="${member.member_address }" required style="margin: 20px 0 20px 0; width: 100%;"></div>
	    						<div><input type="text" name="member_address_detail" id="detailAddress" placeholder="나머지주소" value="${member.member_address_detail }" style="width: 100%;"></div>
	    					</td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>이메일</span><span style="color: red;"> *</span></td>
	    					<td class="right_td">
	    						<input type="text" id="email_id" name="email_id" value="${fn:split(member.member_email, '@')[0] }" required style="width: 30%; margin: 0;">&nbsp@&nbsp
	    						<input type="text" id="email_domain" name="email_domain" value="${fn:split(member.member_email, '@')[1] }" style="width: 20%;">
	    						<select class="cp_select" onchange="this.form.email_domain.value=this[this.selectedIndex].value;">
	    							<option value="">직접입력</option>
	    							<option value="naver.com">naver.com</option>
	    							<option value="hanmail.net">hanmail.net</option>
	    							<option value="gmail.com">gmail.com</option>
	    							<option value="nate.com">nate.com</option>
	    						</select>
	    					</td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>휴대전화</span><span style="color: red;"> *</span></td>
	    					<td class="right_td">
	    						<div>
	    							<input type="text" name="member_phone" value="${member.member_phone }" required style="width: 30%;">
<!-- 	    							<button class="right_td_btn">인증하기</button> -->
	    						</div>
	    					</td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>소속</span></td>
	    					<td class="right_td"><input type="text" name="member_belong" value="${member.member_belong }" placeholder="직장"></td>
	    				</tr>
	    				<tr>
	    					<td class="left_td"><span>직업</span></td>
	    					<td class="right_td"><input type="text" name="member_job" value="${member.member_job }" placeholder="서비스업"></td>
	    				</tr>
	    			</tbody>
	    		</table>
	    	</div>
	    	<div class="drop_member_div">
	    		<div class="drop_member_btn" id="drop_member_btn" onclick="dropMember()">회원탈퇴</div>
	    	</div>	    	
	    	<div class="form_submit_div">
	    		<button class="ok_btn">완료</button>
	    		<a href="javascript:history.back();"><button class="cancel_btn">취소</button></a>
	    	</div>
	    </form>
    </div>
</div>
<script>
	function dropMember() {
		var confirm_val = confirm('탈퇴를 진행합니다.')
		if(confirm_val) {
			const dropForm = document.getElementById('change_personnal_form')
			dropForm.action = 'drop_member'
			dropForm.method = 'POST'
			dropForm.submit()
			alert('탈퇴되었습니다.')
		}
	}
</script>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>