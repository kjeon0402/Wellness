<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/gallery_list.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

<!-- gallery wrap -->
<div class="gallery">

	<!-- sort / total -->
	<div class="st_wrap wrap">
		<!-- sort -->
		<div class="sort_div">
			<select>
				<option>3개월</option>
				<option>6개월</option>
				<option>1년</option>
			</select>
		</div>
		<!-- total -->
		<div class="total_div">총(전체)<span style="color: #72886C;">${gVOListCnt }</span>건</div>
	</div>
	
	<!-- gallery list -->
	<div class="gl_wrap wrap">
		<c:forEach items="${gVOList }" var="gVO_list" varStatus="st">
		<!-- each gallery -->
		<div class="gl_each">
			<!-- image -->
			<div class="gl_img_div">
				<a href="${root }/gallery_detail?no=${gVO_list.gallery_idx}">
				<c:set var="checkCnt" value="0" />
				<c:forEach items="${imgVOList }" var="imgVO_list">
					<c:if test="${imgVO_list.img_small_category == gVO_list.gallery_idx }">
						<c:set var="checkCnt" value="${checkCnt + 1 }" />
					</c:if>
					<c:if test="${checkCnt != 0 }">
						<img class="thumbnail_gallery${st.index }" src="${root }/gallery_file/${imgVO_list.img_path }">
					</c:if>
				</c:forEach>
				<c:if test="${checkCnt == 0 }">
					<c:forEach items="${videoVOList }" var="videoVO_list">
						<c:if test="${videoVO_list.video_small_category == gVO_list.gallery_idx }">
							<video class="thumbnail_gallery${st.index }" src="${root }/gallery_file/${videoVO_list.video_path }"></video>
							<img class="thumbnailV_gallery${st.index}" id="play_btn" src="${root }/img/view/gallery/play_btn.svg">
						</c:if>
					</c:forEach>
				</c:if>
				<script>
					function removeThumbnail() {
						var target = document.querySelectorAll('.thumbnail_gallery${st.index}')
						for(let i = 0; i < target.length; i++){
							if(i > 0) {
								target[i].remove();
							}
						}
					}
					function removeThumbnailV() {
						var target = document.querySelectorAll('.thumbnailV_gallery${st.index}')
						for(let i = 0; i < target.length; i++){
							if(i > 0) {
								target[i].remove();
							}
						}
					}
					removeThumbnail()
					removeThumbnailV()
				</script>
				</a>
			</div>
			<!-- title / date -->
			<div class="gl_td_div">
				<!-- title -->
				<div class="gl_title"><a href="${root }/gallery_detail?no=${gVO_list.gallery_idx}">${gVO_list.gallery_title }</a></div>
				<!-- date -->
				<div class="gl_date">${gVO_list.gallery_write_time }</div>
			</div>
		</div>
		</c:forEach>
		<!-- each gallery -->
<!-- 		<div class="gl_each"> -->
			<!-- image -->
<%-- 			<div class="gl_img_div"><a href="${root }/gallery_detail"><img src="${root }/img/view/gallery/sample_gallery12.svg"></a></div> --%>
			<!-- title / date -->
<!-- 			<div class="gl_td_div"> -->
<!-- 				title -->
<%-- 				<div class="gl_title"><a href="${root }/gallery_detail">오랜만에 간 바다 구경</a></div> --%>
<!-- 				date -->
<!-- 				<div class="gl_date">2021-09-12</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
	
	<!-- search / write -->
	<div class="search_wrap wrap">
		<div class="search_div_wrap">
			<form style="display: flex;">
				<div class="search_div"><input type="search" name="search_keyword" placeholder="제목으로 입력해주세요."><img src="${root }/img/view/tour/tour_icon_search.svg"></div>
				<div class="search_btn"><input type="submit" value="검색"></div>
			</form>
		</div>
		<div class="write_btn"><button onclick="location.href = '${root }/gallery_write'">게시글 등록</button></div>
	</div>
	
	<!-- 페이징 -->
	<div class="paging">
		<c:if test="${paging.nowPage != 1 }">
			<a href="gallery_list?nowPage=1&cntPerPage=${paging.cntPerPage }">&lt;&lt;</a>
			<a href="gallery_list?nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<div class="num">${p }</div>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="gallery_list?nowPage=${p }&cntPerPage=${paging.cntPerPage }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }">
			<a href="gallery_list?nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }">&gt;</a>
			<a href="gallery_list?nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }">&gt;&gt;</a>
		</c:if>
	</div>
</div>

<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>