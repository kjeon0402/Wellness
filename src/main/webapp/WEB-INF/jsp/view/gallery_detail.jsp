<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/gallery_detail.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
// 목록 버튼
	function goGalleryList() {
		location.href = 'gallery_list'
	}
	function goGalleryModify() {
		location.href = '${root }/gallery_modify?no=${gVO.gallery_idx }'
	}
</script>
<script>	
// 댓글 옵션
	function showCommentOption() {
		const menuBtn = document.querySelectorAll('.menu_btn')
		const menuList = document.querySelectorAll('.menu_list')
		
		for(let i = 0; i < menuBtn.length; i++) {
			menuBtn[i].onclick = function() {
				if(menuList[i].classList.contains('hidden')) {
					menuList[i].classList.remove('hidden')
				} else {
					menuList[i].classList.add('hidden')
				}
			}
		}
	}
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
   	#prevBtn {
   		background-image: url("${root}/img/view/gallery/pre_btn.svg");
   		border: none;
   	}
   	#nextBtn {
   		background-image: url("${root}/img/view/gallery/next_btn.svg");
   		border: none;
   	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

<div class="gallery_detail_wrap">
	<div class="gallery_detail_title">
		<div class="title">${gVO.gallery_title }</div>
	</div>
	<div class="gallery_detail_info">
		<div class="gallery_detail_info_date">
			<div class="date_title">작성일</div>
			<div class="date_content">${gVO.gallery_write_time }</div>			
		</div>
		<div class="gallery_detail_info_count">
			<div class="count_title">조회수</div>
			<div class="count_content">${gVO.gallery_count }</div>			
		</div>
	</div>
	<div class="gallery_detail_content">
		<div class="img_area" id="img_area">
			<ul class="img_slider">
				<c:forEach items="${imgVOList }" var="imgVO_list">
				<li><img class="slider_obj" src="${root }/gallery_file/${imgVO_list.img_path}"></li>
				</c:forEach>
				<c:forEach items="${videoVOList }" var="videoVO_list">
				<li><video class="slider_obj" width="100%" height="500px" src="${root }/gallery_file/${videoVO_list.video_path }" controls></video></li>
				</c:forEach>
			</ul>
			<div class="slider_controller">
				<div class="prev_btn"><button id="prevBtn"> <!-- onclick="prevBtn(event)" --></button></div>
				<div class="next_btn"><button id="nextBtn"> <!-- onclick="nextBtn(event)" --></button></div>
				<input type="hidden" id="slider_cnt" value="1">
			</div>
			<script>
				$(function () {
					var sliderObj = document.querySelectorAll('.slider_obj');
					var cnt = sliderObj.length;
					var slider_cnt = $('#slider_cnt').val();
					
					console.log('카운트' + sliderObj.length);
					
					$('.img_slider').css('width', cnt + '00%');
					
					$('#prevBtn').click(function() {
						
						if(slider_cnt == 1){
							$('.img_slider').css('transform', 'translateX(0)');
						} else{
							$('.img_slider').css('transform', 'translateX(calc(-' + (Number(slider_cnt) - 2) * 100 + '%/' + cnt + '))');
							slider_cnt = Number(slider_cnt) - 1;
							$('#slider_cnt').val(slider_cnt);
						}
					});
					
					$('#nextBtn').click(function() {
						
						if(slider_cnt != cnt){
							$('.img_slider').css('transform', 'translateX(calc(-' + slider_cnt * 100 + '%/' + cnt + '))');
							slider_cnt = Number(slider_cnt) + 1;
							$('#slider_cnt').val(slider_cnt);
						}
					});
				});
				
				
				/* // 이미지 슬라이더
				let minus = '-'
				let su = 0
				let px = 'px'
				function nextBtn(event) {
					var sliderObj = document.querySelectorAll('.slider_obj')				
					
					if(su == 989 * (sliderObj.length - 1)){
						return;
					}
					su = su + 989
					let pxMove = minus + su + px
					for(let i = 0; i < sliderObj.length; i++){
						sliderObj[i].style.transition = 'left 400ms linear'
						sliderObj[i].style.left = pxMove
					}
				}
				function prevBtn(event) {
					var sliderObj = document.querySelectorAll('.slider_obj')
					if(su == 0){
						return;
					}
					su = su - 989
					let pxMove = minus + su + px
					for(let i = 0; i < sliderObj.length; i++){
						sliderObj[i].style.transition = 'left 400ms linear'
						sliderObj[i].style.left = pxMove
					}
				} */
				
			</script>
		</div>
		<div class="tour_content">
			${gVO.gallery_content }
		</div>
	</div>
	<div class="comment_area">
	   	<form name="comment_form" id="comment_write_form" class="comment_write_form" method="post">
	        <input class="cmt_small_category" type="hidden" name="comment_small_category" value="${gVO.gallery_idx }">
	        <input class="cmt_big_category" type="hidden" name="comment_big_category" value="gallery">
	           <div class="comment_write_id">
	               <input type="text" name="comment_writer" value="${not empty member ? member.member_userid : '로그인이 필요한 기능입니다.'}" readonly>
	           </div>
	           <div class="comment_write_area" >
	               <textarea class="cmt_content" name="comment_content" required placeholder="${not empty member ? '악플은 경고조치 없이 삭제되며 징계대상이 될 수 있습니다.' : '로그인이 필요한 기능입니다.' }" ${not empty member ? '' : 'disabled' }></textarea>
	           </div>
	           <div class="comment_apply_area" style="display: ${not empty member ? '' : 'none'};">
	               <input type="submit" value="등록">
	           </div>
		</form>
		<c:forEach items="${cmtVOList }" var="cmtVO_list">
       	<div class="comment_one">
       		<c:if test="${cmtVO_list.comment_writer == member.member_userid }">
	       	<div class="comment_option_menu">
	       		<div class="menu_btn" onclick="showCommentOption()">⋮</div>
	       		<ul class="menu_list hidden">
	       			<li onclick="updateCmt(event)">수정</li>
	       			<li onclick="deleteCmt(event)">삭제</li>
	       		</ul>
	        </div>
	        </c:if>
	        <form id="cmt_ctrl_form" method="POST" action="comment_update">
	        <div class="writer_info">
	            <div class="writer_id">
	            	${cmtVO_list.comment_writer }
	            	<input type="hidden" name="comment_idx" value="${cmtVO_list.comment_idx }">
	            	<input type="hidden" name="comment_small_category" value="${cmtVO_list.comment_small_category }">
	            </div>
	        </div>
	        <div class="comment_content">
	            <textarea id="cmt_cnt" name="comment_content" readonly style="outline: none; margin-top: 10px; font-size: 11px; color: #707070; resize: none; width: 80%; padding: 0; border: none;">${cmtVO_list.comment_content }</textarea>
	        </div>
	        <div class="comment_one_bottom">
	            <div class="upload_time" style="text-align: right;"><input id="cmt_update" style="display: none;background-color: #72866C; border: none; color: white; cursor: pointer; width: 40px; height: 25px;" type="submit" value="수정">${cmtVO_list.comment_date }</div>
	        </div>
	        </form>
	        <script>
	        	function updateCmt(event) {
	        		var cmtCnt = event.target.parentNode.parentNode.parentNode.getElementsByTagName('textarea').cmt_cnt
// 	        		console.log(cmtCnt)
					cmtCnt.readOnly = false;	
	        		cmtCnt.focus();
	        		cmtCnt.style.border = '1px solid #707070'
	        		var cmtUpdate = event.target.parentNode.parentNode.parentNode.getElementsByTagName('input').cmt_update
// 	        		console.log(cmtUpdate)
	        		cmtUpdate.style.display = 'block'
	        	}
	        	function deleteCmt(event) {
	        		if(confirm('정말로 삭제 하시겠습니까?')){
	        			var form = event.target.parentNode.parentNode.parentNode.getElementsByTagName('form').cmt_ctrl_form
// 	        			console.log(form)
	        			form.action = 'comment_delete'
	        			form.submit();
	        		}else {
	        			return;
	        		}
	        	}
	        </script>
    	</div>
    	</c:forEach>
    	
		<div class="go_gallery_list">
			<div class="btn" onclick="goGalleryList()" style="margin-right: 20px;">목록</div>
			<c:if test="${member.member_idx == gVO.member_idx }">
			<div class="btn" onclick="goGalleryModify()">수정</div>
			</c:if>
		</div>
	
	
<!-- 	    <div class="paging"> -->
<%-- 	        <c:if test="${paging.nowPage != 1 }"> --%>
<%-- 	        	<a href="webtoon_detail?nowPage=1&cntPerPage=${paging.cntPerPage }">&lt;&lt;</a> --%>
<%-- 	        	<a href="webtoon_detail?nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }">&lt;</a> --%>
<%-- 	        </c:if> --%>
<%-- 	        <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p"> --%>
<%-- 	        	<c:choose> --%>
<%-- 	       			<c:when test="${p == paging.nowPage }"> --%>
<%-- 			<div class="num">${p }</div>                			 --%>
<%-- 	        		</c:when> --%>
<%-- 	        		<c:when test="${p != paging.nowPage }"> --%>
<%-- 	        			<a href="webtoon_detail?nowPage=${p }&cntPerPage=${paging.cntPerPage }">${p }</a> --%>
<%-- 	        		</c:when> --%>
<%-- 	        	</c:choose> --%>
<%-- 	        </c:forEach> --%>
<%-- 	        <c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }"> --%>
<%-- 	        	<a href="webtoon_detail?nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }">&gt;</a> --%>
<%-- 	        	<a href="webtoon_detail?nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }">&gt;&gt;</a> --%>
<%-- 	        </c:if> --%>
<!-- 	    </div> -->
    </div>
	
</div>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
</html>