<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/tour_list_nature.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />
	
	<div class="m_cate">
		<span><a href="${root}/tour_list_nature">자연교감</a></span>
		<span><a href="${root}/tour_list_ocean">오션레져</a></span>
		<span><a href="${root}/tour_list_cosmetic">뷰티&헬스,스파</a></span>
		<span><a href="${root}/tour_list_meal">영양&식당</a></span>
		<span><a href="${root}/tour_list_hotel">호텔&리조트</a></span>
	</div>

	<!-- tour_list wrap -->
	<div class="tour_list_wrap">
		<!-- 카테고리 버튼 -->
		<div class="cate_wrap">
			<div class="btn_wrap">
				<div><button style="border: 1px solid #72886C; background-color: #72886C; color: white;" onclick="location.href='${root}/tour_list_nature'">자연교감</button></div>
				<div><button onclick="location.href='${root}/tour_list_ocean'">오션레져</button></div>
				<div><button onclick="location.href='${root}/tour_list_cosmetic'">뷰티&헬스,스파</button></div>
				<div><button onclick="location.href='${root}/tour_list_meal'">영양&식당</button></div>
				<div><button onclick="location.href='${root}/tour_list_hotel'">호텔&리조트</button></div>
			</div>
		</div>
		<!-- 정렬(최신/인기순) -->
		<div class="sort_wrap">
			<div class="sort_span_wrap">
				<span style="font-weight: bold; color: #72886C;" class="s_span" onclick="location.href = '${root}/tour_list_nature'">최신순</span>
				<span class="s_span">|</span>
				<span style="cursor: pointer;" class="s_span" onclick="location.href = '${root}/tour_list_nature_popular'">인기순</span>
				<script>
					function newORpop() {
						var link = window.location.href
						if(link.indexOf('popular') != -1 ){
							var wichSpan = document.querySelectorAll('.s_span')
							wichSpan[0].style.fontWeight = ''
							wichSpan[0].style.color = 'black'
							wichSpan[2].style.fontWeight = 'bold'
							wichSpan[2].style.color = '#72886C'
						}
					}
					newORpop()
				</script>
			</div>
		</div>
		<!-- 리스트 -->
		<div class="tour_list_wrap">
			<div class="list_wrap">
				<c:forEach items="${natureList }" var="nature_list" varStatus="st">
				<!-- list each -->
				<div class="list_each">
					<div class="each_image_div"><!-- <a href="${root }/tour_detail?category=nature&no=${nature_list.tour_idx }"> --><img src="${root }/tourimg/${not empty natureImgList[st.index].img_path ? natureImgList[st.index].img_path : 'sample_image.svg'}"><!-- </a> --></div>
					<div class="icon_like_div">
<%-- 						<img src="${root }/img/view/tour/tour_heart_clear.svg" onclick="heartClearOrFull(event)"> --%>
						<c:if test="${empty member }">
							<img src="${root }/img/view/tour/tour_heart_clear.svg" onclick="heartClearOrFull(event)">
						</c:if>
						<c:if test="${not empty member }">
							<c:set var="checkLikeIsHere" value="0" />
							<c:forEach items="${membersLike }" var="members_like">
								<c:if test="${members_like.wish_small_category == nature_list.tour_idx }">
									<c:set var="checkLikeIsHere" value="${checkLikeIsHere + 1 }" />
								</c:if>
							</c:forEach>
							<img src="${root }/img/view/tour//tour_heart_${checkLikeIsHere == 0 ? 'clear' : 'full' }.svg" onclick="heartClearOrFull(event)">
						</c:if>
					</div>
					<div class="each_content_div">
						<div class="ecd_title"><span class="ttvalue">${nature_list.tour_name }</span><a href="${root }/tour_detail?category=nature&no=${nature_list.tour_idx}"><button>자세히보기</button></a></div>
						<c:if test="${not empty nature_list.tour_address }">
						<div class="ecd_address">주소 : ${nature_list.tour_address } ${nature_list.tour_address_detail }</div>
						</c:if>
						<c:if test="${not empty nature_list.tour_tel }">
						<div class="ecd_tel">연락처 : ${nature_list.tour_tel }</div>
						</c:if>
						<c:if test="${not empty nature_list.tour_operation1 }">
						<div class="ecd_time1">운영 및 일시 시간 : ${nature_list.tour_operation1 }</div>
						<div class="ecd_time2">※ 상세페이지 참고</div>
						</c:if>
<%-- 						<c:if test="${not empty nature_list.tour_operation2 }"> --%>
<%-- 						<div class="ecd_time1">${nature_list.tour_operation2 }</div> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${not empty nature_list.tour_operation3 }"> --%>
<%-- 						<div class="ecd_time1">${nature_list.tour_operation3 }</div> --%>
<%-- 						</c:if> --%>
<!-- 						<div class="ecd_time2">09:00~17:00(10월~2월)/입장마감시간 : 16:30</div> -->
						<c:if test="${not empty nature_list.tour_fee1 }">	
						<div class="ecd_cost1">이용요금 : ${nature_list.tour_fee1 }</div>
						<div class="ecd_cost2">※ 해당하는 자는 신분증 또는 증빙자료 지참 / ※ 상세페이지 참고</div>
						</c:if>
<%-- 						<c:if test="${not empty nature_list.tour_fee2 }">	 --%>
<%-- 						<div class="ecd_cost1">${nature_list.tour_fee2 }</div> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${not empty nature_list.tour_fee3 }">	 --%>
<%-- 						<div class="ecd_cost1">${nature_list.tour_fee3 }</div> --%>
<%-- 						</c:if> --%>
<%-- 						<div class="ecd_btn"><a href="${root }/tour_detail?category=nature&no=${nature_list.tour_idx}"><button>자세히보기</button></a></div> --%>
					</div>
				</div>
				</c:forEach>
<!-- 				<div class="list_each"> -->
<%-- 					<div class="each_image_div"><a href="${root }/tour_detail"><img src="${root }/img/view/tour/sample_tour_list.svg"></a></div> --%>
<%-- 					<div class="icon_like_div"><img src="${root }/img/view/tour/tour_heart_clear.svg" onclick="heartClearOrFull(event)"></div> --%>
<!-- 					<div class="each_content_div"> -->
<!-- 						<div class="ecd_title">송도용궁구름다리</div> -->
<!-- 						<div class="ecd_address">주소 : 부산 서구 암남동 620-53 암남공원 안</div> -->
<!-- 						<div class="ecd_tel">연락처 : 051-240-4087</div> -->
<!-- 						<div class="ecd_time1">운영 및 일시 시간 : 09:00~18:00(3월~9월)/입장마감시간 : 17:30</div> -->
<!-- 						<div class="ecd_time2">09:00~17:00(10월~2월)/입장마감시간 : 16:30</div> -->
<!-- 						<div class="ecd_cost1">이용요금 : 일반 1,000원 무료 (7세 미만, 장애의 정도가 심한 장애인 종전1~3급, 국가유공자, 부산 서구민)</div> -->
<!-- 						<div class="ecd_cost2">※ 해당하는 자는 신분증 또는 증빙자료 지참</div> -->
<%-- 						<div class="ecd_btn"><a href="${root }/tour_detail"><button>자세히보기</button></a></div> --%>
<!-- 					</div> -->
<!-- 				</div> -->
				<script>
					function heartClearOrFull(event) {
						// 로그인 여부 확인 시작 ####################
						var memberInfo = '${member.member_idx}'
						if(memberInfo == '') {
							alert('로그인이 필요한 기능입니다.')
							return
						}
						// 로그인 여부 확인 종료 ####################
						
						var iSrc = event.target.src
						
						// 관광지 제목 받기
						var tour_title = event.target.parentNode.parentNode.getElementsByTagName('div')[2].getElementsByTagName('div')[0].getElementsByTagName('span')[0].innerText
						console.log(tour_title)
						
						if(iSrc.indexOf('clear') !== -1) {
							event.target.src = '${root}/img/view/tour/tour_heart_full.svg'
							
							// 좋아요 + 1
							$.ajax({
								type : "GET",
								url : "ajax_tour_list_like_plus",
								data : { "tour_title" : tour_title,
										"member_idx" : memberInfo	
								},
								success : function(result) {
									console.log('좋아요 + 1')
								},
								error : function(a, b, c){
									console.log('Err a : ' + a)
									console.log('Err b : ' + b)
									console.log('Err c : ' + c)
									console.log('ERROR msg : ' + a + b + c)
								}
							})
						}else {
							event.target.src = '${root}/img/view/tour/tour_heart_clear.svg'
							
							// 좋아요 - 1
							$.ajax({
								type : "GET",
								url : "ajax_tour_list_like_minus",
								data : { "tour_title" : tour_title,
									"member_idx" : memberInfo	
								},
								success : function(result) {
									console.log('좋아요 - 1')
								},
								error : function(a, b, c){
									console.log('Err a : ' + a)
									console.log('Err b : ' + b)
									console.log('Err c : ' + c)
									console.log('ERROR msg : ' + a + b + c)
								}
							})
						}
					}
				</script>
			</div>
		</div>
		<!-- 검색 -->
		<div class="search_wrap">
			<div class="search_div_wrap">
				<form style="display: flex;">
				<div class="search_div"><input type="search" name="search_keyword" placeholder="제목으로 입력해주세요."><img src="${root }/img/view/tour/tour_icon_search.svg"></div>
				<div class="search_btn"><input type="submit" value="검색"></div>
				</form>
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
<!-- 	<div class="sizeModal"> -->
<!-- 		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div> -->
<!-- 	</div> -->
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>