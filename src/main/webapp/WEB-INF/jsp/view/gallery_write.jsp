<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/gallery_write.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<body>

<script>
	var memberInfo = '${member}'
	if(memberInfo == '') {
		alert('로그인이 필요한 기능입니다.')
		location.href = '${root}/gallery_list'
	}
</script>

<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

<!-- gallery write wrap -->
<div class="gallery_wirte_wrap">
	<!-- 게시글 작성 -->
	<div class="page_title wrap">게시글 작성</div>
	<!-- form -->
	<form id="write_form" enctype="multipart/form-data" method="POST">
	<input type="hidden" name="member_idx" value="${member.member_idx }">
	<input type="hidden" name="gallery_writer" value="${member.member_userid }">
	<div class="gw_form_div wrap">
		<table class="gw_form_table">
			<tbody>
				<tr>
					<td>제목</td>
					<td>
						<div class="sctd_div"><input type="text" name="gallery_title" placeholder="20자 이내로 입력해주세요." required></div>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<div class="sctd_div sctd_div2"><textarea name="gallery_content" placeholder="100자 이내로 입력해주세요." required></textarea></div>
					</td>
				</tr>
				<tr>
					<td>첨부</td>
					<td>
						<div class="sctd_div sctd_div3">
							<div class="sctd_div3_inner_div">
								<div class="sctd_div3_inner_btn">
									<button id="video_btn" onclick="openVFile(event)"></button><input accept="image/*, .mp4" type="file" id="g_file" name="g_file" multiple="multiple" onchange="fileUpload(event)">
<!-- 									<button id="img_btn" onclick="openIFile(event)"></button><input type="file" id="i_file" name="i_file" multiple="multiple" onchange="fileUpload(event)"> -->
									<script>
										function openVFile(event) {
											event.preventDefault();
											document.getElementById('g_file').click();
										}
										function openIFile(event) {
											event.preventDefault();
											document.getElementById('g_file').click();
										}
										function fileUpload(event) {
											var pForFile = document.querySelector('.p_file')
											if(pForFile != null){
												pForFile.remove();
											}
											var showDiv = document.querySelector('.show_file_list')
											for(let i = 0; i < event.target.files.length; i++){
												var new_pForFile = document.createElement('p')
												new_pForFile.classList.add('p_file')
												new_pForFile.innerText += event.target.files[i].name + '\n'
												showDiv.append(new_pForFile)
											}
										}
									</script>
								</div>
								<div class="sctd_div3_inner_text">
<!-- 									<div class="inner_text1">또는 이곳에 파일을 끌어 놓으세요.</div> -->
									<div class="inner_text2">동영상 파일(*.mp4)은 최대 5개, 파일의 용량은 1GB / 30분까지 업로드 가능합니다.</div>
									<div class="inner_text3">이미지 파일은 최대 5개, 파일의 용량은 1GB까지 업로드 가능합니다.</div>
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
		<button id="do_save" onclick="checkFile(event)">저장</button>
		<button id="go_list" onclick="goList(event)">목록</button>
	</div>
	</form>
	<script>
		function checkFile(event) {
			event.preventDefault();
			var titleIs = document.getElementsByName('gallery_title')[0]
			var contentIs = document.getElementsByName('gallery_content')[0]
			var fileIs = document.getElementById('g_file')
			
			var cntP = document.querySelectorAll('.p_file')
			if(cntP.length > 10) {
				alert('파일은 최대 10개까지 업로드할 수 있습니다.')
				return
			}
			let checkVideo = 0
			let checkImage = 0
			for(let i = 0; i < cntP.length; i++){
				if(cntP[i].innerText.indexOf('.mp4') != -1) {
					checkVideo = checkVideo + 1
					if(checkVideo > 5) {
						alert('동영상 파일은 최대 5개까지 업로드할 수 있습니다')
						return
					}
				}else {
					checkImage = checkImage + 1
					if(checkImage > 5) {
						alert('이미지 파일은 최대 5개까지 업로드할 수 있습니다')
						return
					}
				}
			}
			
			if(titleIs.value == '') {
				alert('제목을 입력해주세요.')
			}else if(contentIs.value == '') {
				alert('내용을 입력해주세요.')
			}else if(fileIs.value == ''){
				alert('이미지 혹은 동영상을 첨부해주세요.')
			}else {
				var form = document.querySelector('form')
				form.submit();
			}
		}
		// 목록으로
		function goList(event) {
			event.preventDefault();
			location.href = '${root}/gallery_list'
		}
	</script>
</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />



</body>
</html>