<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/join.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
// 	동의 체크박스 핸들러
	function chkboxAll(event) {
		var chkboxAllImg = document.getElementById('checkboxAllImg')
		var chkbox1Img = document.getElementById('checkbox1Img')
		var chkbox2Img = document.getElementById('checkbox2Img')
		var chkbox3Img = document.getElementById('checkbox3Img')
		var chkbox4Img = document.getElementById('checkbox4Img')
		if(event.target.checked){
			chkboxAllImg.src = '${root}/img/view/join/checkbox2.svg'
			var chkboxes = document.querySelectorAll('input[type=checkbox]')
			for(let i = 0; i < chkboxes.length; i++) {
				chkboxes[i].checked = true
			}
			chkbox1Img.src = '${root}/img/view/join/checkbox2.svg'
			chkbox2Img.src = '${root}/img/view/join/checkbox2.svg'
			chkbox3Img.src = '${root}/img/view/join/checkbox2.svg'
			chkbox4Img.src = '${root}/img/view/join/checkbox2.svg'
		}else {
			var chkboxes = document.querySelectorAll('input[type=checkbox]')
			for(let i = 0; i < chkboxes.length; i++) {
				chkboxes[i].checked = false
			}
			chkboxAllImg.src = '${root}/img/view/join/checkbox.svg'
			chkbox1Img.src = '${root}/img/view/join/checkbox.svg'
			chkbox2Img.src = '${root}/img/view/join/checkbox.svg'
			chkbox3Img.src = '${root}/img/view/join/checkbox.svg'
			chkbox4Img.src = '${root}/img/view/join/checkbox.svg'
		}
	}
	function chkbox1(event) {
		var chkbox1Img = document.getElementById('checkbox1Img')
		if(event.target.checked){
			chkbox1Img.src = '${root}/img/view/join/checkbox2.svg'
		}else {
			chkbox1Img.src = '${root}/img/view/join/checkbox.svg' 
		}
	}
	function chkbox2(event) {
		var chkbox2Img = document.getElementById('checkbox2Img')
		if(event.target.checked){
			chkbox2Img.src = '${root}/img/view/join/checkbox2.svg'
		}else {
			chkbox2Img.src = '${root}/img/view/join/checkbox.svg' 
		}
	}
	function chkbox3(event) {
		var chkbox3Img = document.getElementById('checkbox3Img')
		if(event.target.checked){
			chkbox3Img.src = '${root}/img/view/join/checkbox2.svg'
		}else {
			chkbox3Img.src = '${root}/img/view/join/checkbox.svg' 
		}
	}
	function chkbox4(event) {
		var chkbox4Img = document.getElementById('checkbox4Img')
		if(event.target.checked){
			chkbox4Img.src = '${root}/img/view/join/checkbox2.svg'
		}else {
			chkbox4Img.src = '${root}/img/view/join/checkbox.svg' 
		}
	}
	
	function checkChkBox() {
		var chkBoxAll = document.getElementById('checkboxAll')
		var chkBox1 = document.getElementById('checkbox1')
		var chkBox2 = document.getElementById('checkbox2')
		var chkBox3 = document.getElementById('checkbox3')
		var chkBox4 = document.getElementById('checkbox4')
		var password_check = $('#password_check').val();
		
		if(chkBoxAll.checked) {
			var result = true
		}else if(chkBox1.checked && chkBox2.checked) {
			var result = true
		}else if(password_check == 'true'){
			var result = true
		}else if(password_check == 'false'){
			var result = false
		}else {
			var result = false
		}
		console.log(result)
	}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 주소 api
	function sample6_execDaumPostcode() {
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
<body>
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_login.jsp" />
	
<div class="join_wrap">
	
    <div class="join_form">
    <form method="POST" id="join_form">
    	<!-- 회원가입 -->
    	<div class="join_text">회원가입</div>
    	<!-- 기본정보 -->
    	<div class="join_text_left">기본정보</div>
    	<!-- 필수입력사항 -->
    	<div class="join_text_right"><span style="color: red;">* </span><span>필수입력사항</span></div>
    	<!-- 입력 테이블 -->
    	<div class="join_table_div">
    		<table class="join_table">
    			<tbody>
    				<tr>
    					<td class="left_td"><span>아이디</span><span style="color: red;"> *</span></td>
    					<td class="right_td">
    						<div><input type="text" id="id" name="member_userid" placeholder="ID" autofocus required><button class="right_td_btn" onclick="checkId()">중복확인</button></div>
    						<div class="rule">(영문소문자/숫자, 4~16글자)</div>
    						<script>
    						// 아이디 조건 체크
    							function checkId() {
    								event.preventDefault();
    								var id = $('#id').val();
    								console.log(id)
    								$.ajax({
    									url : 'idCheck',
    									type : 'post',
    									data : {
    										id : id
    									},
    									success : function(data) {
    										if($.trim(data) == 0) {
    											alert('사용 가능한 아이디입니다.');
    										} else {
    											alert('사용이 불가능한 아이디입니다.');
    										}
    									},
    									error : function() {
    										alert('에러입니다.');
    									}
    								});
    							};
    						</script>
    					</td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>비밀번호</span><span style="color: red;"> *</span></td>
    					<td class="right_td">
    						<div>
    							<input type="password" class="pw" id="password" name="member_password" placeholder="PW" required>
    							<span id="pw_true" style="display: none; color: blue; font-size: 11px;">사용가능</span>
    							<span id="pw_false" style="display: none; color: red; font-size: 11px;">사용불가</span>
    							<input type="hidden" id="password_check" value="false">
    						</div>
    						<div class="rule">(영문 대소문자/숫자/특수문자 중 2가지 이상조합, 10~16자)</div>
    						<script>
    						// 비밀번호 정규식 체크
    						$('.pw').focusout(
								function (){
									var pw = $("#password").val();
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
    					</td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>비밀번호 확인</span><span style="color: red;"> *</span></td>
    					<td class="right_td">
    						<div><input type="password" class="checkPw" id="checkPW" required></div>
    						<div class="rule" id="alert-success" style="color: blue; display: none;">비밀번호가 일치합니다.</div>
    						<div class="rule" id="alert-danger" style="color: red; display: none;">비밀번호가 일치하지 않습니다.</div>
    						<script>
    						// 비밀번호 일치 여부 체크
    						$('.checkPw').focusout(
								function() {
									var pwd1 = $("#password").val();
									var pwd2 = $("#checkPW").val();

									if (pwd1 != '' && pwd2 == '') {
										null;
									} else if (pwd1 != "" || pwd2 != "") {
										if (pwd1 == pwd2) {
											$("#alert-success").css('display', 'block');
											$("#alert-danger").css('display', 'none');
										} else {
											$("#alert-success").css('display', 'none');
											$("#alert-danger").css('display', 'block');
										}
									}
								});
    						</script>
    					</td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>이름</span><span style="color: red;"> *</span></td>
    					<td class="right_td"><input type="text" name="member_name" required></td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>주소</span><span style="color: red;"> *</span></td>
    					<td class="right_td">
    						<div><input type="text" name="member_post" id="postcode" placeholder="우편번호" required><button class="right_td_btn" onclick="sample6_execDaumPostcode()">주소검색</button></div>
    						<div><input type="text" name="member_address" id="address" placeholder="주소" required style="margin: 20px 0 20px 0; width: 100%;"></div>
    						<div><input type="text" name="member_address_detail" id="detailAddress" placeholder="나머지주소" style="width: 100%;"></div>
    					</td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>이메일</span><span style="color: red;"> *</span></td>
    					<td class="right_td">
    						<input type="text" id="email_id" name="member_email" required style="width: 30%; margin: 0;">&nbsp@&nbsp<input type="text" id="email_domain" name="email_domain" value="" style="width: 20%;">
    						<select id="email_server" onchange="this.form.email_domain.value=this[this.selectedIndex].value;">
    							<option value="" selected="selected">직접입력</option>
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
    							<input type="text" name="member_phone" id="member_phone" required style="width: 30%;">
    							<button class="right_td_btn smsc_btn" onclick="smsCheck(join_form, '${root}')">인증하기</button>
    							<input style="border: none; width: 65px; color: red; font-size: 13px;" type="text" id="sms_certification" value="인증필요" readonly>
    							<script>
    								// 휴대폰 인증 번호 입력 팝업
    								function smsCheck(obj, root) {
    									event.preventDefault();
    									if(obj.member_phone.value == "") {
    										alert('휴대폰 번호를 입력하세요');
    										obj.member_phone.focus();
    										return false;
    									} else {
    										let url = root + "/sendSMS?member_phone=" + obj.member_phone.value;
    										window.open(url, "", "width=400, height=200");
    									}
    								}
    							</script>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>소속</span></td>
    					<td class="right_td"><input type="text" name="member_belong" placeholder="직장"></td>
    				</tr>
    				<tr>
    					<td class="left_td"><span>직업</span></td>
    					<td class="right_td"><input type="text" name="member_job" placeholder="서비스업"></td>
    				</tr>
    			</tbody>
    		</table>
    	</div>
    	<!-- 전체동의 -->
    	<div class="agree_all_text">전체동의</div>
    	<!-- 이용약관/개인정보이용 모두 동의 체크박스 -->
    	<div class="agree_checkbox_div">
    		<div class="agree_checkbox"><label><input type="checkbox" id="checkboxAll" onclick="chkboxAll(event)"><img id="checkboxAllImg" src="${root }/img/view/member/checkbox.svg"></label></div>
    		<div>이용약관/개인정보이용 모두 동의합니다.</div>
    	</div>
    	<!-- [필수]이용약관 -->
    	<div class="agree_title_div">[필수] 이용약관 동의</div>
    	<!-- [필수]이용약관 내용-->
    	<div class="agree_content_div">
    		<textarea class="acd_textarea">제 1 장 총칙

제 1 조 (목적)
본 약관은 부산웰니스관광 플랫폼이 운영하는 웹 사이트 (http://www.bswellnesstour.com )의 제반 서비스의 이용조건 및 절차에 관한 사항 및 기타 필요한 사항을 규정함을 목적으로 한다.

제 2 조 (용어의 정의)
본 약관에서 사용하는 용어는 다음과 같이 정의한다.
①회원 : 기본 회원 정보를 입력하였고, 회사와 서비스 이용계약을 체결하여 아이디를 부여받은 개인
②아이디(ID) : 회원식별과 회원의 서비스 이용을 위해 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합
③비밀번호(Password) : 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합
④해지 : 회사 또는 회원에 의한 이용계약의 종료

제 3 조 (약관의 공시 및 효력과 변경)
①본 약관은 회원가입 화면에 게시하여 공시하며 '부산웰니스관광 플랫폼'은 사전 변경 및 영업상 중요한 사유가 있을 경우 약관을 변경할 수 있으며 변경된 약관은 공지사항을 통해 공시한다
②본 약관 및 차후 회사사정에 따라 변경된 약관은 이용자에게 공시함으로써 효력을 발생한다.

제 4 조 (약관 외 준칙)
본 약관에 명시되지 않은 사항이 전기통신기본법, 전기통신사업법, 정보통신촉진법, ‘전자상거래등에서의 소비자 보호에 관한 법률’, ‘약관의 규제에관한법률’, ‘전자거래기본법’, ‘전자서명법’, ‘정보통신망 이용촉진등에 관한 법률’, ‘소비자보호법’ 등 기타 관계 법령에 규정되어 있을 경우에는 그 규정을 따르도록 한다.


제 2 장 이용계약

제 5 조 (이용신청)
①이용신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의 가입 신청서 작성)를 거쳐 '확인' 버튼을 누르면 이용신청을 할 수 있다.
②이용신청자는 반드시 실명과 실제 정보를 사용해야 하며 1개의 생년월일에 대하여 1건의 이용신청을 할 수 있다.
③실명이나 실제 정보를 입력하지 않은 이용자는 법적인 보호를 받을 수 없으며, 서비스 이용에 제한을 받을 수 있다.

제 6 조 (이용신청의 승낙)
①'부산웰니스관광 플랫폼'은 제5조에 따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다.
②'부산웰니스관광 플랫폼'은 아래 사항에 해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다.
  가. 서비스 관련 설비에 여유가 없는 경우
  나. 기술상 지장이 있는 경우
  다. 기타 회사 사정상 필요하다고 인정되는 경우
③'부산웰니스관광 플랫폼'은 아래 사항에 해당하는 경우에 승낙을 하지 않을 수 있다.
  가. 다른 사람의 명의를 사용하여 신청한 경우
  나. 이용자 정보를 허위로 기재하여 신청한 경우
  다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우
  라. 기타 회사가 정한 이용신청 요건이 미비한 경우


제 3 장 계약 당사자의 의무

제 7 조 (회사의 의무)
①'부산웰니스관광 플랫폼'은 사이트를 안정적이고 지속적으로 운영할 의무가 있다.
②'부산웰니스관광 플랫폼'은 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정될 경우에는 즉시 처리해야 한다. 단, 즉시 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 공지사항 또는 전자우편을 통해 통보해야 한다.
③제1항의 경우 수사상의 목적으로 관계기관 및 정보통신윤리위원회의 요청이 있거나 영장 제시가 있는 경우, 기타 관계 법령에 의한 경우는 예외로 한다.

제 8 조 (이용자의 의무)
①이용자는 본 약관 및 회사의 공지사항, 사이트 이용안내 등을 숙지하고 준수해야 하며 기타 회사의 업무에 방해되는 행위를 해서는 안 된다.
②이용자는 회사의 사전 승인 없이 본 사이트를 이용해 어떠한 영리행위도 할 수 없다.
③이용자는 본 사이트를 통해 얻는 정보를 회사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 및 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.

제 4 장 서비스의 제공 및 이용

제 9 조 (서비스 이용)
①이용자는 본 약관의 규정된 사항을 준수해 사이트를 이용한다.
②본 약관에 명시되지 않은 서비스 이용에 관한 사항은 회사가 정해 '공지사항'에 게시하거나 또는 별도로 공지하는 내용에 따른다.

제 10 조 (정보의 제공)
'부산웰니스관광 플랫폼'은 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보에 대하여 전자메일이나 서신우편 등의 방법으로 회원에게 정보를 제공할 수 있다.

제 11 조 (광고게재)
①'부산웰니스관광 플랫폼'은 서비스의 운용과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있다.
②'부산웰니스관광 플랫폼'은 사이트에 게재되어 있는 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않는다.

제 12 조 (서비스 이용의 제한)
본 사이트 이용 및 행위가 다음 각 항에 해당하는 경우 '부산웰니스관광 플랫폼'은 해당 이용자의 이용을 제한할 수 있다.
①공공질서 및 미풍양속, 기타 사회질서를 해하는 경우
②범죄행위를 목적으로 하거나 기타 범죄행위와 관련된다고 객관적으로 인정되는 경우
③타인의 명예를 손상시키거나 타인의 서비스 이용을 현저히 저해하는 경우
④타인의 의사에 반하는 내용이나 광고성 정보 등을 지속적으로 전송하는 경우
⑤해킹 및 컴퓨터 바이러스 유포 등으로 서비스의 건전한 운영을 저해하는 경우
⑥다른 이용자 또는 제3자의 지적재산권을 침해하거나 지적재산권자가 지적 재산권의 침해를 주장할 수 있다고 판단되는 경우
⑦타인의 아이디 및 비밀번호를 도용한 경우
⑧기타 관계 법령에 위배되는 경우 및 회사가 이용자로서 부적당하다고 판단한 경우

제 13 조 (서비스 제공의 중지)
'부산웰니스관광 플랫폼'은 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부의 제공을 중지할 수 있다.
①전기통신사업법 상에 규정된 기간통신 사업자 또는 인터넷 망 사업자가 서비스를 중지했을 경우
②정전으로 서비스 제공이 불가능할 경우
③설비의 이전, 보수 또는 공사로 인해 부득이한 경우
④서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 어려운 경우
⑤전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우

제 14 조 (게시물 관리)
회사는 건전한 통신문화 정착과 효율적인 사이트 운영을 위하여 이용자가 게시하거나 제공하는 자료가 제12조에 해당한다고 판단되는 경우에 임의로 삭제, 자료이동, 등록거부를 할 수 있다.

제 15 조 (서비스 이용 책임)
이용자는 회사에서 권한 있는 사원이 서명한 명시적인 서면에 구체적으로 허용한 경우를 제외하고는 서비스를 이용하여 불법상품을 판매하는 영업활동을 할 수 없으며 특히 해킹, 돈벌기 광고, 음란 사이트를 통한 상업행위, 상용 S/W 불법제공 등을 할 수 없다. 이를 어기고 발생한 영업활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 회사가 책임을 지지 않는다.


제 5 장 (재화의 주문 및 결제 관련) 

제16조 (예약 및 결제방법)
‘회원’은 ‘부산웰니스관광 플랫폼’에서 제공 및 판매하는 재화에 대하여 ‘계좌이체’를 통한 결제만 가능하며, ‘선불카드, 직불카드, 신용카드 등의 각종 카드 결제 수단’을 이용하여 결제할 수 없다. 이때 ‘부산웰니스관광 플랫폼’은 이용자의 지급방법에 대하여 재화 외 어떠한 명목의 수수료를 추가 징수하지 않는다.

① ‘부산웰니스관광플랫폼’은 이용자의 예약 신청이 있는 경우 이용자에게 예약확인통지를 한다. 예약 확인에 대한 내용은 해당 게시판에서 확인 할 수 있다.
② 예약확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 예약확인통지를 받은 후 즉시 예약 변경 및 취소를 요청할 수 있고 ‘회사’는 예약 확정 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리한다. 다만 이미 대금을 지불한 경우에는 제 17조의 ‘취소 및 환불 규정’을 따른다.

제 17조 (취소 및 환불 규정)
‘부산웰니스관광 플랫폼’은 이용자가 예약 및 구매한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 14영업일 이내에 환급하거나 환급에 필요한 조치를 한다.
① 예약이 확정 되기 전 이용자가 예약을 취소할 경우, ‘부산웰니스관광 플랫폼’은 해당 예약 건을 취소 처리한다. 상품의 특성상 예약한 상품의 시행 3일(42시간) 전부터는 취소가 불가능하다.
② 재화가 발송된 이후, 또는 상품의 예약확인통지를 받아 결제 진행 후 환불가능기한(14일)을 지난 경우 결제 취소는 불가하다. 단, ‘부산웰니스관광 플랫폼’의 부주의 또는 불가항력적인 상황으로 인한 재화의 파손, 변질의 경우 ‘회사’는 이용자에게 구매 금액의 환불 및 교환 조치를 취한다.


제 6 장 기타

제 18 조 (면책 및 손해배상)
①천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 회사의 서비스 제공 책임이 면제된다.
②회사는 이용자간 또는 이용자와 제3자간의 상호거래 관계에서 발생되는 결과에 대하여 어떠한 책임도 부담하지 않는다.
③회사는 이용자가 게시판에 게재한 정보, 자료, 내용 등에 관하여 사실의 정확성, 신뢰도 등에 어떠한 책임도 부담하지 않으며 이용자는 본인의 책임 아래 본 사이트를 이용해야 한다.
④이용자가 게시 또는 전송한 자료 등에 관하여 손해가 발생하거나 자료의 취사선택, 기타 무료로 제공되는 서비스 이용과 관련해 어떠한 불이익이 발생하더라도 이에 대한 모든 책임은 이용자에게 있다.
⑤아이디와 비밀번호의 관리 및 이용자의 부주의로 인하여 발생되는 손해 또는 제3자에 의한 부정사용 등에 대한 책임은 이용자에게 있다.
⑥이용자가 본 약관의 규정을 위반함으로써 회사에 손해가 발생하는 경우 이 약관을 위반한 이용자는 회사에 발생한 모든 손해를 배상해야 하며 동 손해로부터 회사를 면책시켜야 한다.

제 19 조 (개인신용정보 제공 및 활용에 대한 동의서)
회사가 회원 가입과 관련해 취득한 개인 신용 정보는 신용정보의 이용 및 보호에 관한 법률 제23조의 규정에 따라 타인에게 제공 및 활용 시 이용자의 동의를 얻어야 한다. 이용자의 동의는 회사가 회원으로 가입한 이용자의 신용정보를 신용정보기관, 신용정보업자 및 기타 이용자 등에게 제공해 이용자의 신용을 판단하기 위한 자료로서 활용하거나 공공기관에서 정책자료로 활용하는데 동의하는 것으로 간주한다.

제 20 조 (분쟁의 해결)
①회사와 이용자는 본 사이트 이용과 관련해 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 해야 한다.
②제1항의 규정에도 불구하고 동 분쟁으로 인하여 소송이 제기될 경우 동 소송은 회사의 본사 소재지를 관할하는 법원의 관할로 본다.

<부칙>
본 약관은 2021년 11월 1일부터 적용한다.</textarea>
    	</div>
    	<!-- [필수]이용약관 체크박스-->
    	<div class="agree_checkbox_div">
    		<div class="agree_confirm_div">이용약관에 동의하십니까?</div>
    		<div><label><input type="checkbox" id="checkbox1" required onclick="chkbox1(event)"><img id="checkbox1Img" src="${root }/img/view/member/checkbox.svg"></label></div>
    	</div>
    	<!-- [필수]개인정보 수집 -->
    	<div class="agree_title_div">[필수] 개인정보 수집 및 이용 동의</div>
    	<!-- [필수]개인정보 내용-->
    	<div class="agree_content_div">
    		<textarea class="acd_textarea">1. 개인정보 수집 및 이용
개인정보보호법에 따라 ‘부산웰니스관광 플랫폼’에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.

1. 수집∙이용 목적
회원가입, 서비스 이용, 상담 및 부정 거래 기록 확인, 서비스 이용 가능 연령 확인 및 본인 여부 확인, 이용자의 상품 및 서비스 이용 실적 정보를 활용한 통계 분석 및 상품 서비스 개선 제공, 맞춤형 서비스 제공을 위한 이용자 식별

2. 수집 항목
[회원가입]
회원가입 시점에 ‘부산웰니스관광 플랫폼’이 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 주소, 이메일, 휴대전화번호’를 필수항목으로 수집합니다. 그리고 선택항목으로 ‘생년월일, 성별, 소속, 직업’ 정보를 수집합니다.

[서비스 이용 및 부정거래 기록 확인]
서비스 이용시간/이용기록, 접수로그, 이용컨텐츠, 접속IP정보, 기기모델명, 브라우저 정보

[이벤트]
- 당첨자 이름, 주소, 휴대전화 번호

[예약/결제]
- 공통 : 예약자 이름, 연락처, 이메일
- 계좌이체 시 : 은행명, 계좌번호, 예금주명
- 취소.환불 시 : 은행명, 계좌번호, 예금주명

3. 보유∙이용기간
- 회원 탈퇴 요청일로 부터 3개월 간 보관
- 관계법령에 따라 보존할 필요가 있는 경우 관련 법령에서 요구하는 기한까지 보관</textarea>
    	</div>
    	<!-- [필수]개인정보 체크박스-->
    	<div class="agree_checkbox_div">
    		<div class="agree_confirm_div">이용약관에 동의하십니까?</div>
    		<div><label><input type="checkbox" id="checkbox2" required onclick="chkbox2(event)"><img id="checkbox2Img" src="${root }/img/view/member/checkbox.svg"></label></div>
    	</div>
    	<!-- [선택]수신동의 -->
    	<div class="agree_title_div">[선택] 웰니스 정보 수신 동의</div>
    	<!-- [선택]수신동의 내용-->
    	<div class="agree_content_div">
    		<textarea class="acd_textarea"> ‘부산웰니스관광 플랫폼’은 개인정보보호법 등에 관한 법률 등 관계법령에 따라 광고성 정보를 전송하기 위해 수신자의 사전 수신동의를 받고 있으며, 광고성 정보 수신자의 수신동의여부를 정기적으로 확인합니다. 다만 동의하지 않을 경우, 상품/서비스 소개 및 권유, 이벤트 등 이용목적에 따른 혜택의 제한이 있을 수 있습니다. 그 밖에 금융 거래와 관련된 불이익은 없습니다.

[전송방법]
이용자의 핸드폰 문자메시지(SMS), 이메일 등을 통해 전달 될 수 있습니다.

[전송내용]
발송되는 마케팅 정보는 수신자에게 ‘부산관광웰니스 플랫폼’이 운영하는 서비스에서 제공하는 혜택 정보, 각종 이벤트 정보, 각종 웰니스 정보, 신규 상품 안내 등 광고성 정보로 관련법의 규정을 준수하여 발송됩니다. 단, 광고성 정보 이외 의무적으로 안내되어야 하는 정보성 내용은 수신동의 여부와 무관하게 제공됩니다.

[철회안내]
고객님은 수신 동의 이후에라도 의사에 따라 동의를 철회할 수 있으며, 수신을 동의하지 않아도 ‘부산웰니스관광 플랫폼’이 제공하는 기본적인 서비스를 이용할 수 있으나, 해당 플랫폼의 마케팅 정보를 수신하지 못할 수 있습니다.

[수신동의 변경]
마이페이지 마케팅 수신 동의란 체크 비활성화를 통해 수신동의를 (동의/철회)할 수 있습니다.

[개인정보 이용 상세내용]
1) 이용하는 개인정보 항목
- 휴대전화번호, 이메일 주소

2) 보유 이용 목적
- 혜택 정보, 각종 이벤트 정보, 상품 정보, 신규 서비스 안내 등 광고성 정보 제공

[개인정보 보유 및 이용 기간]
마케팅 활용 동의일로부터 회원 탈퇴 또는 마케팅 동의 철회 시까지 보유 및 이용</textarea>
    	</div>
    	<!-- [선택]수신동의 체크박스1-->
    	<div class="agree_checkbox_div" style="margin-bottom: 10px;">
    		<div class="agree_confirm_div">SNS 수신을 동의하십니까?</div>
    		<div><label><input type="checkbox" id="checkbox3" onclick="chkbox3(event)"><img id="checkbox3Img" src="${root }/img/view/member/checkbox.svg"></label></div>
    	</div>
    	<!-- [선택]수신동의 체크박스2-->
    	<div class="agree_checkbox_div">
    		<div class="agree_confirm_div">이메일 수신을 동의하십니까?</div>
    		<div><label><input type="checkbox" id="checkbox4" onclick="chkbox4(event)"><img id="checkbox4Img" src="${root }/img/view/member/checkbox.svg"></label></div>
    	</div>
    	<!-- 완료/취소-->
    	<div class="form_submit_div">
    		<button class="ok_btn" type="button" id="join_submit">완료</button>
    		<button class="cancel_btn">취소</button>
    	</div>
    </form>
    </div>
</div>

<script>
$(function () {
	$("#join_submit").click(function(){    
    	
    	var password_check = $('#password_check').val();
    	var sms_certification = $('#sms_certification').val();
    	
        if($("#checkbox1").is(":checked") == false){
            alert("필수 이용 약관에 모두 동의하셔야합니다.");
            return;
        }else if($("#checkbox2").is(":checked") == false){
            alert("필수 동의 약관에 모두 동의하셔야합니다.");
            return;
        }else if(password_check == 'false'){
        	alert("비밀번호를 확인하시오.");
        	return;
        } else if(sms_certification != '인증완료'){
        	alert("휴대전화를 인증하세요.");
        	return;
        } else {
        	alert('회원가입에 성공하셨습니다. 환영합니다.')
            $("#join_form").submit();
        }
        
    });
})
</script>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>