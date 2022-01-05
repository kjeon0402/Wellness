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
/* 페이징 */
.paging {
	display: flex;
	justify-content: center;
}

.paging>a {
	width: 20px;
	height: 20px;
	padding: 10px;
	border: 1px solid #EDED;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-right: 5px;
}
.paging>div {
	background-color: #444547;
	color: white;
	padding: 10px;
	width: 20px;
	height: 20px;
	display: flex;
	justify-content: center;
	border: 1px solid #EDED;
}
/* 페이징 END */
.package_list_wrap {
	width: 100%;
}
.cate_wrap {
	width: 50%;
	margin: 100px auto 50px auto;
}
.cate_wrap button {
	width: 180px;
	height: 60px;
	border: 1px solid #707070;
	background-color: white;
	cursor: pointer;
	font-size: 17px;
	font-weight: bold;
	margin-right: 20px;
}
.btn_wrap {
	display: flex;
	justify-content: center;
}
.sort_span_wrap {
	width: 50%;
	margin: 0 auto;
	font-size: 13px;
}
.s_span:first-child, .s_span:last-child {
	cursor: pointer;
}
.s_span:first-child {
	color: #72886C;
	font-weight: bold;
}
.search_wrap {
	width: 100%;
}
.search_div_wrap {
	width: 50%;
	margin: 50px auto;
	display: flex;
}
.search_div {
	border: 1px solid #707070;
	padding: 5px;
	margin-right: 15px;
}
.search_div input[type=search] {
	border: none;
	outline: none;
	height: 25px;
	width: 250px;
}
.search_btn button {
	width: 50px;
	height: 37px;
	background-color: #72886C;
	color: white;
	border: none;
	cursor: pointer;
}
.package_list_wrap > .package_thumbnail_wrap {
	width: 50%;
	margin: auto;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list {
	width: 100%;
	display: flex;
	flex-flow: wrap;
	justify-content: space-between;
	margin-top: 20px;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail {
	width: 32%;
	margin-bottom: 35px;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .thumbnail_img > .each_image_div img {
	width: 100%;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .thumbnail_img > .icon_like_div {
	width: 0;
	height: 0;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .thumbnail_img > .icon_like_div > img {
	position: relative;
	top: -23px;
    left: 281px;
    cursor: pointer;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info {
	width: 100%;
	font-size: 13px;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info > .package_title {
	width: 100%;
	padding: 8px 0;
	font-size: 14px;
	font-weight: bold;
	border-bottom: 1px solid #707070;
	margin-bottom: 5px;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info > .package_price {
	color: #72866C;
	font-weight: bold;
	margin-bottom: 3px;
	
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info > .package_duration {
	font-size: 11px;
	margin-bottom: 12px;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info > .package_btn button {
	all: unset;
	width: 65px;
	font-size: 11px;
	padding: 2px 5px;
	border: 1px solid #72866C;
	border-radius: 50px;
	text-align: center;
	cursor: pointer;
	color: #72866C;
}
.package_list_wrap > .package_thumbnail_wrap > .package_list > .package_thumbnail > .package_info > .package_btn > a > .reserve {
	color: white;
	background-color: #72866C;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />
	
	<div class="package_list_wrap">
		<!-- 카테고리 버튼 -->
		<div class="cate_wrap">
			<div class="btn_wrap">
				<div><button style="border: 1px solid #72886C; background-color: #72886C; color: white;" onclick="location.href='${root}/package_list_nature'">자연교감형 패키지</button></div>
				<div><button onclick="location.href='${root}/package_list_ocean'">해양체험형 패키지</button></div>
				<div><button onclick="location.href='${root}/package_list_story'">스토리텔링형 패키지</button></div>
			</div>
		</div>
		<!-- 정렬(최신/인기순) -->
		<div class="sort_wrap">
			<div class="sort_span_wrap">
				<span class="s_span">최신</span>
				<span class="s_span">|</span>
				<span class="s_span">인기순</span>
			</div>
		</div>
		<!-- 리스트 -->
		<div class="package_thumbnail_wrap">
			<div class="package_list">
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<div class="package_thumbnail">
					<div class="thumbnail_img">
						<div class="each_image_div"><a href="${root }/package_detail"><img src="${root }/img/view/package/package_list.svg"></a></div>
						<div class="icon_like_div"><img src="${root }/img/view/package/package_heart_clear.svg" onclick="heartClearOrFull(event)"></div>
					</div>
					<div class="package_info">
						<div class="package_title">자연교감형 패키지 A</div>
						<div class="package_price">250,000원</div>
						<div class="package_duration">2021.09.11 ~ 2021.09.15</div>
						<div class="package_btn">
							<a href="${root }/package_detail"><button>자세히보기</button></a>
							<a href=""><button class="reserve">예약하기</button></a>
						</div>
					</div>
				</div>
				<script>
					function heartClearOrFull(event) {
						var iSrc = event.target.src
						if(iSrc.indexOf('clear') !== -1) {
							event.target.src = '${root}/img/view/tour/tour_heart_full.svg'
						}else {
							event.target.src = '${root}/img/view/tour/tour_heart_clear.svg'
						}
					}
				</script>
			</div>
		</div>
		<!-- 검색 -->
		<div class="search_wrap">
			<div class="search_div_wrap">
				<div class="search_div"><input type="search" placeholder="제목으로 입력해주세요."><img src="${root }/img/view/package/package_icon_search.svg"></div>
				<div class="search_btn"><button>검색</button></div>
			</div>
		</div>
		<!-- 페이징 -->
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