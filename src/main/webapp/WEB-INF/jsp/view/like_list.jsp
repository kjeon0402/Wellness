<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/like_list.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
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
</head>
<body>
	
	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />

	<c:if test="${empty member }">
		<script>
			alert('로그인이 필요한 페이지입니다.')
			location.href = '${root}/login'
		</script>
	</c:if>
	<c:if test="${not empty member }">
		<div class="mypage_main_wrap">
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
			<div class="like_list_count">총(전체) ${mwVOCnt }건</div>
			<div style="margin-bottom: 10px;">
				<span class="tour_list" onclick="location.href = '${root}/like_list'" style="font-size: 12px; font-weight: bold; color: #707070; cursor: pointer;">관광지</span>
				<span style="font-size: 12px; color: #707070;">|</span>
				<span class="package_list" onclick="location.href = '${root}/like_list_package'" style="font-size: 12px; color: #707070; cursor: pointer;">패키지</span>
				<script>
					var link = window.location.href
					if(link.indexOf('package') != -1) {
						var package_list = document.querySelector('.package_list')
						var tour_list = document.querySelector('.tour_list')
						package_list.style.fontWeight = 'bold'
						tour_list.style.fontWeight = ''
					}
				</script>
			</div>
			<c:forEach items="${mwVOList }" var="mwVOList">
			<c:if test="${mwVOList.package_idx == '' }">
				<div class="like_list_one">
					<div class="left_like_img" style="background-image: url('${root }/tourimg/${mwVOList.img_path }');" onclick="location.href = '${root}/tour_detail?category=&no=${mwVOList.tour_idx }'"></div>
					<div class="right_like_content">
						<div class="like_content_title">${mwVOList.tour_name }</div>
						<div class="like_content_content">
							<p>주소 : ${mwVOList.tour_address }</p>
							<p>연락처 : ${mwVOList.tour_tel }</p>
							<p>운영 및 일시 시간 : ${mwVOList.tour_operation }</p>
							<p>이용요금 : ${mwVOList.tour_fee }</p>
							<p>※ 운영 및 일시시간 / 이용요금은 상세페이지 참고</p>
						</div>
						<div class="button_area">
							<div class="show_detail"><a href="${root }/tour_detail?category=&no=${mwVOList.tour_idx}">자세히보기</a></div>
	<!-- 						<div class="reserve">예약하기</div> -->
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${mwVOList.tour_idx == '' }">
				<div class="like_list_one">
					<div class="left_like_img" style="background-image: url('${root }/packageimg/${mwVOList.img_path }');" onclick="location.href = '${root}/package_detail?no=${mwVOList.package_idx }'"></div>
					<div class="right_like_content">
						<div class="like_content_title">${mwVOList.package_name }</div>
						<div class="like_content_content">
							<p>관광지 1 : ${mwVOList.p_tour_name1 }</p>
							<c:if test="${mwVOList.p_tour_name2 != null }">
							<p>관광지 2 : ${mwVOList.p_tour_name2 }</p>
							</c:if>
							<c:if test="${mwVOList.p_tour_name3 != null }">
							<p>관광지 3 : ${mwVOList.p_tour_name3 }</p>
							</c:if>
							<c:if test="${mwVOList.p_tour_name4 != null }">
							<p>관광지 4 : ${mwVOList.p_tour_name4 }</p>
							</c:if>
							<c:if test="${mwVOList.p_tour_name5 != null }">
							<p>관광지 5 : ${mwVOList.p_tour_name5 }</p>
							</c:if>
							<p>이용요금 : ${mwVOList.package_price }</p>
						</div>
						<div class="button_area">
							<div class="show_detail"><a href="${root }/package_detail?no=${mwVOList.package_idx}">자세히보기</a></div>
	<!-- 						<div class="reserve">예약하기</div> -->
						</div>
					</div>
				</div>
			</c:if>
			</c:forEach>
<!-- 			<div class="paging"> -->
<%-- 	            <c:if test="${paging.nowPage != 1 }"> --%>
<%-- 	            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=1&cntPerPage=${paging.cntPerPage }}#comment_write_form">&lt;&lt;</a> --%>
<%-- 	            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }#comment_write_form">&lt;</a> --%>
<%-- 	            </c:if> --%>
<%-- 	            <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p"> --%>
<%-- 	            	<c:choose> --%>
<%-- 	            		<c:when test="${p == paging.nowPage }"> --%>
<%-- 				<div class="num">${p }</div>                			 --%>
<%-- 	            		</c:when> --%>
<%-- 	            		<c:when test="${p != paging.nowPage }"> --%>
<%-- 	            			<a href="community_detail?bc_idx=${paging.idx }&nowPage=${p }&cntPerPage=${paging.cntPerPage }#comment_write_form">${p }</a> --%>
<%-- 	            		</c:when> --%>
<%-- 	            	</c:choose> --%>
<%-- 	            </c:forEach> --%>
<%-- 	            <c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }"> --%>
<%-- 	            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;</a> --%>
<%-- 	            	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;&gt;</a> --%>
<%-- 	            </c:if> --%>
<!-- 	        </div> -->
		</div>
	</c:if>
<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>