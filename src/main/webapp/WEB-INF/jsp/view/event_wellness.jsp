<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/event_wellness.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>


<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_news.jsp" />

	<div class="event_wellness_list_wrap">
		<div class="event_wellness_top_menu">
			<div class="search_menu">
				<select class="search_kind">
					<option value="all">전체</option>
				</select>
				<form>
				<div class="search_keyword"><input class="text" name="search_keyword" placeholder="제목으로 입력해주세요"></div>
				<div class="search_img">
					<div class="search_icon" style="background-image: url('${root}/img/view/notice/search_icon.svg');"></div>
				</div>
				<div class="search_btn">
					<input type="submit" value="검색">
				</div>
				</form>
			</div>
			<div class="sort_count">
				<select class="sort_count_select">
					<option value="ten">10</option>
				</select>
			</div>
		</div>
		
		<div class="event_wellness_list_main">
			<table class="event_wellness_list">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회순</th>					
				</tr>
				<c:forEach items="${e_wVOList }" var="e_wVO_list">
				<tr>
					<td>${e_wVO_list.event_wellness_idx }</td>
					<td><a href="event_wellness_detail?no=${e_wVO_list.event_wellness_idx }">${e_wVO_list.event_wellness_title }</a></td>
					<td>${e_wVO_list.event_wellness_write_time }</td>
					<td>${e_wVO_list.event_wellness_count }</td>
				</tr>
				</c:forEach>
<!-- 				<tr> -->
<!-- 					<td>14</td> -->
<!-- 					<td><a href="">순다리 리트리트 스파(파라다이스 호텔 부산) 관련 스파 체험단 모집합니다.</a></td> -->
<!-- 					<td>2021-09-11</td> -->
<!-- 					<td>234</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>13</td> -->
<!-- 					<td><a href="">바쁜 현대인들을 위한 자연교감 패키지 체험 일정</a></td> -->
<!-- 					<td>2021-09-11</td> -->
<!-- 					<td>234</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>12</td> -->
<!-- 					<td><a href="">범어사 템플스테이의 체험 모집 및 후기 작성</a></td> -->
<!-- 					<td>2021-09-11</td> -->
<!-- 					<td>234</td> -->
<!-- 				</tr> -->
			</table>
		</div>
		
		<c:if test="${member.member_grade == 3 }">
		<div class="write_wrap">
			<div class="write_btn"><button onclick="location.href = '${root }/event_wellness_write'">게시글 등록</button></div>
		</div>
		</c:if>
		
		<div class="paging">
             <c:if test="${paging.nowPage != 1 }">
             	<a href="notice?nowPage=1&cntPerPage=${paging.cntPerPage }">&lt;&lt;</a>
             	<a href="notice?nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }">&lt;</a>
             </c:if>
             <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
             	<c:choose>
             		<c:when test="${p == paging.nowPage }">
				<div class="num">${p }</div>                			
             		</c:when>
             		<c:when test="${p != paging.nowPage }">
             			<a href="notice?nowPage=${p }&cntPerPage=${paging.cntPerPage }">${p }</a>
             		</c:when>
             	</c:choose>
             </c:forEach>
             <c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }">
             	<a href="notice?nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }">&gt;</a>
             	<a href="notice?nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }">&gt;&gt;</a>
             </c:if>
         </div>
	</div>
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
</html>