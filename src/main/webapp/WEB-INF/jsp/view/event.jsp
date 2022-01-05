<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/event.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

	<div class="event_main_wrap">
		<div class="event_kind">
			<ul>
				<li class="all_event" style="color: #72866C; font-weight: bold;"><a href="${root }/event">전체</a></li>
				<li class="doing_event"><a href="${root }/event_doing">진행</a></li>
				<li class="end_event"><a href="${root }/event_end">종료</a></li>
			</ul>
			<script>
				var link = window.location.href
				if(link.indexOf('doing') != -1) {
					var doing_event = document.querySelector('.doing_event')
					var all_event = document.querySelector('.all_event')
					all_event.style.color = 'black'
					all_event.style.fontWeight = ''
					doing_event.style.color = '#72866C'
					doing_event.style.fontWeight = 'bold'
				}else if(link.indexOf('end') != -1) {
					var end_event = document.querySelector('.end_event')
					var all_event = document.querySelector('.all_event')
					all_event.style.color = 'black'
					all_event.style.fontWeight = ''
					end_event.style.color = '#72866C'
					end_event.style.fontWeight = 'bold'
				}
			</script>
		</div>
		<div class="event_list">
			<c:forEach items="${eVOList }" var="eVO_list">
			<div class="event_one_thumbnail">
				<c:forEach items="${imgVOList }" var="imgVO_list">
					<c:if test="${imgVO_list.img_small_category == eVO_list.event_homepage_idx }">
						<c:if test="${empty imgVO_list.img_path }">
							<div class="event_one_img" style="background-image: url('${root}/tourimg/none_img1.jpg');" onclick="location.href = '${root }/event_detail?no=${eVO_list.event_homepage_idx }'"></div>
						</c:if>
						<c:if test="${not empty imgVO_list.img_path }">
							<div class="event_one_img" style="background-image: url('${root}/eventimg/${imgVO_list.img_path }');" onclick="location.href = '${root }/event_detail?no=${eVO_list.event_homepage_idx }'"></div>
						</c:if>
					</c:if>
				</c:forEach>
				<div class="event_one_title"><a href="${root }/event_detail?no=${eVO_list.event_homepage_idx }">${eVO_list.event_homepage_title } ${eVO_list.event_homepage_do_doing == 'e' ? '[종료]' : '' }</a></div>
				<div class="event_one_duration">${eVO_list.event_homepage_start_date } ~ ${eVO_list.event_homepage_end_date } ${eVO_list.event_homepage_do_doing == 'e' ? '[종료]' : '' }</div>
			</div>
			</c:forEach>
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail2.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail3.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail4.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail1.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail2.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail3.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail4.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail1.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail2.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail3.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
<!-- 			<div class="event_one_thumbnail"> -->
<%-- 				<div class="event_one_img" style="background-image: url('${root}/img/view/board/event_thumbnail4.png');"></div> --%>
<!-- 				<div class="event_one_title">9월 이달의 관광지 추천을 인스타그램에 사진을 올려주세요.</div> -->
<!-- 				<div class="event_one_duration">2021-09-01 ~ 2021-09-15</div> -->
<!-- 			</div> -->
		</div>
		<div class="event_search_div">
			<form>
				<div class="search_input">
					<input type="text" name="search_keyword" placeholder="제목으로 입력해주세요.">
					<div class="search_icon"></div>
				</div>
			<div class="search_btn"><input type="submit" value="검색"></div>
			</form>
		</div>
		
		<c:if test="${member.member_grade == 3 }">
		<div class="write_wrap">
			<div class="write_btn"><button onclick="location.href = '${root }/event_write'">게시글 등록</button></div>
		</div>
		</c:if>
		
		<div class="paging">
            <c:if test="${paging.nowPage != 1 }">
            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=1&cntPerPage=${paging.cntPerPage }}#comment_write_form">&lt;&lt;</a>
            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }#comment_write_form">&lt;</a>
            </c:if>
            <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
            	<c:choose>
            		<c:when test="${p == paging.nowPage }">
			<div class="num">${p }</div>                			
            		</c:when>
            		<c:when test="${p != paging.nowPage }">
            			<a href="community_detail?bc_idx=${paging.idx }&nowPage=${p }&cntPerPage=${paging.cntPerPage }#comment_write_form">${p }</a>
            		</c:when>
            	</c:choose>
            </c:forEach>
            <c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }">
            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;</a>
            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;&gt;</a>
            </c:if>
        </div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>