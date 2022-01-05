<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
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
	width: 100%;
	margin: 0;
	padding: 0;
	font-family: 'Nanum Gothic', sans-serif;
}
a {
	text-decoration: none;
	color: inherit;
	cursor: pointer;
}
.wrap {
	width: 50%;
	margin: 0 auto;
}
.page_title {
	font-weight: bold;
	font-size: 20px;
	padding: 10px 0;
	border-bottom: 2px solid #707070;
	margin-top: 100px;
}
.gw_form_div {
	margin-top: 30px;
}
.gw_form_table {
	border-top: 1px solid #707070;
	width: 100%;
	border-collapse: collapse;
}
.gw_form_table > tbody > tr {
	border-bottom: 1px solid #707070;
}
.gw_form_table > tbody > tr:first-child {
	height: 60px;
}
.gw_form_table > tbody > tr:nth-child(2) {
	height: 200px;
}
.gw_form_table > tbody > tr:nth-child(3) {
	height: 100px;
}
.gw_form_table > tbody > tr > td:first-child {
	background-color: #EEEEEE;
	text-align: center;
	font-size: 15px;
}
.gw_form_table > tbody > tr > td:last-child {
	padding: 18px 10px;
	width: 90%;
}
.sctd_div {
	border: 1px solid #707070;
	padding: 5px 10px;
	width: 96%;
}
.sctd_div2 {
	height: 155px;
}
.sctd_div input[type=text] {
	border: none;
	outline: none;
	width: 50%;
}
.sctd_div textarea {
	resize: none;
	width: 99%;
	height: 99%;
	border: none;
	outline: none;
}
.sctd_div3 {
	height: 200px;
	display: flex;
	justify-content: center;
}
.sl_btn_div {
	margin-top: 30px;
}
.sl_btn_div button {
	width: 71px;
	height: 30px;
}
.sl_btn_div button:first-child {
	background-color: #72886C;
	border: none;
	color: white;
	cursor: pointer;
	margin-right: 10px;
}
.sl_btn_div button:last-child {
	background-color: white;
	border: 1px solid #72886C;
	color: #72886C;
	cursor: pointer;
}
#video_btn {
	background-image: url("${root}/img/view/gallery/video_btn.svg");
	border: none;
	width: 103px;
	height: 34px;
	margin-right: 10px;
	cursor: pointer;
}
#img_btn {
	background-image: url("${root}/img/view/gallery/img_btn.svg");
	border: none;
	width: 103px;
	height: 34px;
	cursor: pointer;
}
.sctd_div3_inner_div {
	margin: auto 0;
}
.sctd_div3_inner_btn {
	display: flex;
	justify-content: center;
	margin-bottom: 5px;
}
.sctd_div3_inner_text {
	text-align: center;
}
.inner_text1 {
	font-size: 12px;
	color: #707070;
}
.inner_text2 {
	margin: 3px 0;
}
.inner_text2, .inner_text3 {
	font-size: 11px;
	color: #A0A0A0;
}
#i_file, #v_file {
	display: none;
}
.show_file_list {
	border: 1px solid #707070;
	padding: 5px 10px;
	width: 96%;
}
.show_file_list p {
	font-size: 14px;
	margin: 5px 0;
}
#clear_file {
	border: 1px solid #72886C;
	background-color: white;
	color: #72886C;
	margin-top: 10px;
}
#clear_file:hover {
	background-color: #72886C;
	color: white;
	cursor: pointer;
}
</style>
</head>
<body>

<script>
	var memberWho = '${member.member_grade}'
	if(memberWho != 3) {
		alert('비정상적인 접근입니다.')
		location.href = '${root}/home'
	}
</script>

<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

<!-- gallery write wrap -->
<div class="gallery_wirte_wrap">
	<!-- 게시글 작성 -->
	<div class="page_title wrap">이벤트 작성</div>
	<!-- form -->
	<form id="write_form" enctype="multipart/form-data" method="POST">
	<input type="hidden" name="event_homepage_writer" value="${member.member_name }">
	<div class="gw_form_div wrap">
		<table class="gw_form_table">
			<tbody>
				<tr>
					<td>제목</td>
					<td>
						<div class="sctd_div"><input type="text" name="event_homepage_title" placeholder="제목을 입력해주세요." required></div>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<div class="sctd_div sctd_div2"><textarea name="event_homepage_content" placeholder="내용을 입력해주세요." required></textarea></div>
					</td>
				</tr>
				<tr>
					<td>이벤트<br>기간</td>
					<td>
						<div class="sctd_div sctd_div4">
							<div style="margin-bottom: 10px;font-size: 13px;color: #707070;">시작일<input required="required" style="margin-left: 10px;" type="date" name="event_homepage_start_date"></div>
							<div style="font-size: 13px;color: #707070;">종료일<input required="required" style="margin-left: 10px;" type="date" name="event_homepage_end_date"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>첨부</td>
					<td>
						<div class="sctd_div sctd_div3">
							<div class="sctd_div3_inner_div">
								<div class="sctd_div3_inner_btn">
<!-- 									<button id="video_btn" onclick="openVFile(event)"></button><input type="file" id="v_file" name="v_file" multiple="multiple" onchange="fileUpload(event)"> -->
									<button id="img_btn" onclick="openIFile(event)"></button><input type="file" id="i_file" name="i_file" onchange="fileUpload(event)">
									<script>
										function openVFile(event) {
											event.preventDefault();
											document.getElementById('v_file').click();
										}
										function openIFile(event) {
											event.preventDefault();
											document.getElementById('i_file').click();
										}
										function fileUpload(event) {
											var p_file = document.querySelector('.p_file')
											if(p_file != null) {
												p_file.remove()
											}
											var showDiv = document.querySelector('.show_file_list')
											for(let i = 0; i < event.target.files.length; i++){
												var pForFile = document.createElement('p')
												pForFile.classList.add('p_file')
												pForFile.innerText = event.target.files[i].name
												showDiv.append(pForFile)
											}
										}
									</script>
								</div>
								<div class="sctd_div3_inner_text">
<!-- 									<div class="inner_text1">또는 이곳에 파일을 끌어 놓으세요.</div> -->
<!-- 									<div class="inner_text2">동영상 파일은 최대 10개, 파일의 용량은 4GB / 60분까지 업로드 가능합니다.</div> -->
									<div class="inner_text3">이미지 파일은 최대 1개, 파일의 용량은 2GB까지 업로드 가능합니다.</div>
								</div>
							</div>
<!-- 							<script> -->
<!-- 								//드래그앤드롭 미구현 -->
<!-- 								var fileList = []; -->
<!-- 								var uploadBox = document.querySelector('.sctd_div3') -->
<!-- 								uploadBox.addEventListener('dragenter', function(e){ -->
<!-- 									console.log('dragenter') -->
<!-- 								}) -->
<!-- 								uploadBox.addEventListener('dragover', function(e){ -->
<!-- 									e.preventDefault(); -->
<!-- 									console.log('dragover') -->
<!-- 									this.style.border = '1px dashed #707070' -->
<!-- 									this.style.backgroundColor = '#ECECEC' -->
<!-- 								}) -->
<!-- 								uploadBox.addEventListener('dragleave', function(e){ -->
<!-- 									console.log('dragleave') -->
<!-- 									this.style.border = '1px solid #707070' -->
<!-- 									this.style.backgroundColor = 'white' -->
<!-- 								}) -->
<!-- 								uploadBox.addEventListener('drop', function(e){ -->
<!-- 									e.preventDefault(); -->
<!-- 									console.log('drop') -->
<!-- 									this.style.border = '1px solid #707070' -->
<!-- 									this.style.backgroundColor = 'white' -->
<!-- 									console.dir(e.dataTransfer) -->
									
<!-- 									var data = e.dataTransfer.files; -->
<!-- 									console.dir(data) -->
									
<!-- 									var showDiv = document.querySelector('.show_file_list') -->
<!-- 									for(let i = 0; i < data.length; i++) { -->
<!-- 										var pForFile = document.createElement('p') -->
<!-- 										pForFile.classList.add('p_file') -->
<!-- 										pForFile.innerText = data[i].name -->
<!-- 										showDiv.append(pForFile) -->
<!-- 									} -->
									
<!-- 									for(let i = 0; i < data.length; i++){ -->
<!-- 										var f = data[i] -->
<!-- 										fileList.push(f) -->
<!-- 										var fileName = f.name; -->
<!-- 										var fileSize = f.size / 1024 / 1024; -->
<!-- 									} -->
<!-- 									console.log(fileList) -->
									
<!-- 									var formData = new FormData(document.getElementById('write_form')) -->
<!-- 									fileList.forEach(function(f){ -->
<!-- 										formData.append("fileList", f) -->
<!-- 									}) -->
<!-- 									for(var pair of formData.entries()){ -->
<!-- 										console.log('formData : ' + pair[0] + ', ' + pair[1]) -->
<!-- 									} -->
<!-- 									fileList = []; -->
<!-- 								}) -->
<!-- 							</script> -->
						</div>
					</td>
				</tr>
				<tr>
					<td>첨부<br>목록</td>
					<td>
						<div class="show_file_list"></div>
						<button id="clear_file" onclick="clearFile(event)">초기화</button>
						<script>
							function clearFile(event) {
								event.preventDefault();
								var pFile = document.querySelectorAll('.p_file')
								for(let i = 0; i < pFile.length; i++){
									pFile[i].remove();
								}
								var files = document.querySelectorAll('input[type=file]')
								for(let i = 0; i < files.length; i++){
									files[i].value = ''
								}
							}
						</script>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- save / list btn -->
	<div class="sl_btn_div wrap">
		<button id="do_save">저장</button>
		<button id="go_list" onclick="goList(event)">목록</button>
	</div>
	</form>
	<script>
		// 목록으로
		function goList(event) {
			event.preventDefault();
			location.href = '${root}/event'
		}
	</script>
</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />



</body>
</html>