<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/my_posting_event.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
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
<script>
//체크박스 전체선택/해제
function checkSelectAll() {
	const checkboxes = document.querySelectorAll('.checkbox_manage_posting')
	const checked = document.querySelectorAll('.checkbox_manage_posting:checked')
	const selectAll = document.querySelector('.checkbox_controller')
	
	if(checkboxes.length === checked.length) {
		selectAll.checked = true
	} else {
		selectAll.checked = false;
	}
}

function selectAll(selectAll) {
	const checkboxes = document.getElementsByName('checkbox_each')
	
	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked
	})
}
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_mypage.jsp" />

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
		<div class="my_posting_title">내 게시글 관리</div>
		<c:if test="${member.member_grade == 3 }">
			<div style="margin-bottom: 15px; font-size: 14px; color: #707070;">
				<span class="myposting_category" onclick="location.href = '${root}/my_posting_notice'">공지사항</span>
				<span>|</span>
				<span style="font-weight: bold;" class="myposting_category" onclick="location.href = '${root}/my_posting_event'">이벤트</span>
				<span>|</span>
				<span class="myposting_category" onclick="location.href = '${root}/my_posting'">갤러리</span>
				<span>|</span>
				<span class="myposting_category" onclick="location.href = '${root}/my_posting_event_wellness'">웰니스행사</span>
			</div>
		</c:if>
		<input type="hidden" name="member_idx" value="${member.member_idx }">
		<table class="posting_list">
        	<tr>
        		<th><input type="checkbox" class="checkbox_manage_posting" name="checkbox_controller" onclick="selectAll(this)"></th>
        		<th>NO</th>
        		<th>제목</th>
        		<th>작성일</th>
        		<th>조회수</th>
        	</tr>
        	<c:forEach items="${mypostingList }" var="myposting_list" varStatus="st">
	        	<tr>
	        		<td>
	        			<input type="checkbox" class="checkbox_manage_posting" name="checkbox_each" value="${myposting_list.event_homepage_idx }">
	        		</td>
	        		<td>${myposting_list.event_homepage_idx }</td>
	        		<td><a href="${root }/event_detail?no=${myposting_list.event_homepage_idx }">${myposting_list.event_homepage_title }</a></td>
	        		<td>${myposting_list.event_homepage_write_time }</td>
	        		<td>${myposting_list.event_homepage_count }</td>
	        	</tr>
        	</c:forEach>
        </table>
        <div class="posting_option_btn">
        	<input type="button" value="삭제" class="cancel" onclick="delete_my_posting()">
        	<input type="button" value="수정" class="modify" onclick="modify_my_posting()">
        </div>
        <script>
        // 내 게시글 체크박스 수정
        	function modify_my_posting() {
        		if($('input[name="checkbox_each"]:checked').length == 0) {
        			alert('선택된 게시물이 없습니다.')
        		}
        		if($('input[name="checkbox_each"]:checked').length != 1 && $('input[name="checkbox_each"]:checked').length != 0) {
        			alert('수정할 게시물은 하나만 선택해야합니다.')
        		}
        		if($('input[name="checkbox_each"]:checked').length == 1) {
        			var confirm_val = confirm("수정 페이지로 이동합니다.")
        			if(confirm_val) {
        				location.href = 'event_modify?no=' + $('input[name="checkbox_each"]:checked').val()
        			}
        		}
        	}
        </script>
        <script>
        // 내 게시글 체크박스 선택 삭제
        	function delete_my_posting() {
        		if($('input[name="checkbox_each"]:checked').length == 0) {
        			alert('선택된 게시물이 없습니다.')
        		}
        		if($('input[name="checkbox_each"]:checked').length != 0) {
	        		var confirm_val = confirm("정말 삭제하시겠습니까?")
	        		if(confirm_val) {
	        			var check = [];
	        			
	        			$('input[name="checkbox_each"]:checked').each(function(e) {
	        				check.push($(this).val());
	        			})
	        			var list = {
	        				'check' : check
	        			}
	        			
	        			$.ajax({
	        				url : 'delete_my_posting_event',
	        				type : 'POST',
	        				data : list,
	        				success : function(data) {
	        					if($.trim(data) == 0) {
	        						alert('글이 삭제되었습니다.');
	        						location.href = 'my_posting_event';
	        					} else {
	        						alert('삭제할 수 없습니다.');
	        					}
	        				},
	        				error : function() {
	        					alert("에러입니다.")
	        				}
	        			})
	        		}
        		}
        	}
        </script>
<!--         <div class="paging"> -->
<%--             <c:if test="${paging.nowPage != 1 }"> --%>
<%--             	<a href="community_detail?bc_idx=${paging.idx }&nowPage=1&cntPerPage=${paging.cntPerPage }}#comment_write_form">&lt;&lt;</a> --%>
<%--             	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage }#comment_write_form">&lt;</a> --%>
<%--             </c:if> --%>
<%--             <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p"> --%>
<%--             	<c:choose> --%>
<%--             		<c:when test="${p == paging.nowPage }"> --%>
<%-- 			<div class="num">${p }</div>                			 --%>
<%--             		</c:when> --%>
<%--             		<c:when test="${p != paging.nowPage }"> --%>
<%--             			<a href="community_detail?bc_idx=${paging.idx }&nowPage=${p }&cntPerPage=${paging.cntPerPage }#comment_write_form">${p }</a> --%>
<%--             		</c:when> --%>
<%--             	</c:choose> --%>
<%--             </c:forEach> --%>
<%--             <c:if test="${paging.lastPage != 0 && paging.nowPage != paging.lastPage }"> --%>
<%--             	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.nowPage + 1 }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;</a> --%>
<%--             	<a href="community_detail?bc_idx=${paging.idx }&nowPage=${paging.endPage }&cntPerPage=${paging.cntPerPage }}#comment_write_form">&gt;&gt;</a> --%>
<%--             </c:if> --%>
<!--         </div> -->
	</div>

<div class="sizeModal">
	<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
</div>
<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />
</body>
</html>