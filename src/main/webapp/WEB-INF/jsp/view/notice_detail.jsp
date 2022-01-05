<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/notice_detail.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script>
	function goNoticeList() {
		location.href = 'notice'
	}
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

	<div class="notice_detail_wrap">
		<div class="notice_detail_title">
			<div class="title">${noticeVO.notice_title }</div>
		</div>
		<div class="notice_detail_info">
			<div class="notice_detail_info_date">
				<div class="date_title">작성일</div>
				<div class="date_content">${noticeVO.notice_write_time }</div>			
			</div>
			<div class="notice_detail_info_count">
				<div class="count_title">조회수</div>
				<div class="count_content">${noticeVO.notice_count }</div>			
			</div>
		</div>
		<div class="notice_detail_img_div">
			<c:if test="${not empty noticeVO.notice_file }">
				<img class="notice_detail_img" src="${root }/noticeimg/${noticeVO.notice_file}">
			</c:if>
		</div>
<!-- 		<div class="attached_file"> -->
<!-- 			<div class="attached_file_title">첨부파일</div> -->
<!-- 			<div class="attached_file_content">wellness_background_img_20210912.png</div> -->
<!-- 		</div> -->
		<div class="notice_detail_content">
			${noticeVO.notice_content }
<!-- 			<p>- 추석연휴 영업하지 않는 관광지</p> -->
<!-- 			<p>9월18일 송도용궁구름다리, 안심치유정원, 해운대블루라인파크</p> -->
<!-- 			<p>9월19일 안심치유정원, 해운대블루라인파크, 광안리 SUP ZONE, 금강사 다례체험</p> -->
<!-- 			<p>9월20일 송도용궁구름다리, 해운대블루라인파크</p> -->
<!-- 			<p>9월21일 송도용궁구름다리, 해운대블루라인파크, 광안리 SUP ZONE, 금강사 다례체험, 다대포 해양레포츠센터, 힐튼 부산 사우나&테라피시설&피트니스</p> -->
<!-- 			<p>9월22일 해운대블루라인파크, 힐튼 부산 사우나&테라피시설&피트니스</p> -->
<!-- 			<br> -->
<!-- 			<p>이상입니다.</p> -->
<!-- 			<p>자세한내용은 첨부파일 확인 바랍니다.</p> -->
<!-- 			<p>감사합니다.</p> -->
		</div>
		<div class="notice_prev_next">
			<div class="prev" onclick="goPrev()">&lt; 이전글</div>
			<div class="next" onclick="goNext()">다음글 &gt;</div>
			<script>
				function goPrev() {
					var no = parseInt('${noticeVO.notice_idx}')
						if(no == 1){
						alert('첫번째 게시글 입니다.')
						return;
					}else {
						location.href = '${root}/notice_detail?no=' + (no - 1)
					}
				}
				function goNext() {
					var no = parseInt('${noticeVO.notice_idx}')
					if(no == parseInt('${lastIdx }')){
						alert('마지막 게시글 입니다.')
						return;
					}else {
						location.href = '${root}/notice_detail?no=' + (no + 1)
					}
				}
			</script>
		</div>
		<div class="go_notice_list">
			<div class="btn" onclick="goNoticeList()">목록</div>
			<c:if test="${member.member_grade == 3 }">
				<div style="margin-left: 15px;" class="btn" onclick="location.href = '${root}/notice_modify?no=${noticeVO.notice_idx }'">수정</div>
			</c:if>
		</div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>