<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
	<c:set var="root" value="${pageContext.request.contextPath}" />
<%-- 	<c:if test="${check != 0}"> --%>
		<div align="center">
			인증번호를 입력해주세요.
			<form method="post">
				<input type="text" name="certification" id="certification" /> 
				<input type="submit" onclick="submitCheck(event)" value="확인" />
				<input type="hidden" id="check" value="${check}">
			</form>
		</div>
<%-- 	</c:if> --%>

<%-- 	<c:if test="${check == 0}"> --%>
<!-- 		<div align="center">인증이 완료되었습니다.</div> -->
<%-- 		<input type="hidden" id="certification" value="${check}"> --%>
<%-- 	</c:if> --%>

	<div align="center">
		<span id="close">닫기</span>
	</div>
	<script>
		function submitCheck(event) {
			event.preventDefault()
			var certification = $('#certification').val();
			
			$.ajax({
				url : 'sendEmail',
				type : 'post',
				data : {
					certification : certification
				},
				success : function(data) {
					if ($.trim(data) == 0) {
						alert('인증이 완료되었습니다.');
						opener.email_certification.value = '인증완료';
						self.close();
					} else {
						alert('인증번호가 일치하지 않습니다.');
					}
				},
				error : function() {
					alert("에러입니다");
				}
			});
		}
	</script>
</body>
</html>