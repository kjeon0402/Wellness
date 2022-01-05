<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/my_reserve.css">
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
	<c:if test="${empty member }">
		<script>
			alert('로그인이 필요한 메뉴입니다.')
			location.href = 'login'
		</script>
	</c:if>
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
		<div class="my_reserve_title">${member.member_grade == 3 ? '전체 예약현황' : '나의 예약현황' }</div>
		<table class="reserve_list">
        	<tr>
        		<th><input type="checkbox" class="checkbox_manage_posting" name="checkbox_controller" onclick="selectAll(this)"></th>
        		<th style="display: ${member.member_grade == 3 ? '' : 'none'}">NO</th>
        		<th>패키지명</th>
        		<c:if test="${member.member_grade == 3 }">
        		<th>아이디</th>
        		</c:if>
        		<th>예약자명</th>
        		<th>예약인원</th>
        		<th>예약일</th>
        		<th>이용예정일</th>
        		<th>가격</th>
        		<th>처리현황</th>
        	</tr>
        	<c:forEach items="${mpVOList }" var="mpVOList">
	        	<tr>
	        		<td>
	        			<input type="checkbox" class="checkbox_manage_posting" name="checkbox_each" value="${mpVOList.reservation_idx }">
	        		</td>
	        		<td style="display: ${member.member_grade == 3 ? '' : 'none'}">${mpVOList.reservation_idx }</td>
	        		<td><a href="${root }/package_detail?no=${mpVOList.package_idx}">${mpVOList.package_name }</a></td>
	        		<c:if test="${member.member_grade == 3 }">
	        		<td>${mpVOList.member_userid }</td>
	        		</c:if>
	        		<td>${mpVOList.member_name }</td>
	        		<td>${mpVOList.reserve_count }</td>
	        		<td>${mpVOList.reserve_date }</td>
	        		<td>${mpVOList.reserve_theday }</td>
	        		<td><fmt:formatNumber value="${mpVOList.sum_price }" pattern="#,###" /></td>
	        		<td class="color_td">
	        			<c:if test="${mpVOList.paycheck == 'n'}">입금대기</c:if>
	        			<c:if test="${mpVOList.paycheck == 'c'}">취소요청</c:if>
	        			<c:if test="${mpVOList.paycheck == 'y'}">예약완료</c:if>
	        			<c:if test="${mpVOList.paycheck == 'x'}">취소완료</c:if>
	        		</td>
	        	</tr>
        	</c:forEach>
        </table>
        <script>
        	var colorTd = document.querySelectorAll('.color_td')
        	for(let i = 0; i < colorTd.length; i++){
        		if(colorTd[i].innerText.indexOf('입금대기') != -1) {
        			colorTd[i].style.color = 'blue'
        		}else if(colorTd[i].innerText.indexOf('취소요청') != -1) {
        			colorTd[i].style.color = 'orange'
        		}else if(colorTd[i].innerText.indexOf('예약완료') != -1) {
        			colorTd[i].style.color = 'green'
        		}else {
        			colorTd[i].style.color = 'red'
        		}
        	}
        </script>
        <div class="reserve_option_btn">
        	<div class="cancel" onclick="delete_my_reserve()">${member.member_grade == 3 ? '취소확인' : '취소' }</div>
        	<c:if test="${member.member_grade == 3 }">
        		<div class="cancel" onclick="confirm_my_reserve()">입금확인</div>
        	</c:if>
        </div>
        <script>
       	// 나의 예약현황 체크박스 선택 삭제
       	function delete_my_reserve() {
       		if($('input[name="checkbox_each"]:checked').length == 0) {
    			alert('선택된 예약이 없습니다.')
    		}
       		if($('input[name="checkbox_each"]:checked').length != 0) {
	       		var confirm_val = confirm("정말 취소하시겠습니까?")
	       		if(confirm_val) {
	       			var check = [];
	       			
	       			$('input[name="checkbox_each"]:checked').each(function(e) {
	       				check.push($(this).val());
	       			})
	       			var list = {
	       				'check' : check
	       			}
	       			
	       			$.ajax({
	       				url : 'delete_my_reserve',
	       				type : 'POST',
	       				data : list,
	       				success : function(data) {
	       					if($.trim(data) == 0) {
	       						alert('예약이 취소되었습니다.');
	       						location.href = 'my_reserve';
	       					} else {
	       						alert('예약을 취소할 수 없습니다.');
	       					}
	       				},
	       				error : function() {
	       					alert('에러입니다.')
	       				}
	       			})
	       		}
       		}
       	}
       	
       	// 입금확인
       	function confirm_my_reserve() {
       		if($('input[name="checkbox_each"]:checked').length == 0) {
    			alert('선택된 예약이 없습니다.')
    		}
       		if($('input[name="checkbox_each"]:checked').length != 0) {
	       		var confirm_val = confirm("입금이 완료 되었습니까?")
	       		if(confirm_val) {
	       			var check = [];
	       			
	       			$('input[name="checkbox_each"]:checked').each(function(e) {
	       				check.push($(this).val());
	       			})
	       			var list = {
	       				'check' : check
	       			}
	       			
	       			$.ajax({
	       				url : 'confirm_my_reserve',
	       				type : 'POST',
	       				data : list,
	       				success : function(data) {
	       					if($.trim(data) == 0) {
	       						alert('예약이 완료되었습니다.');
	       						location.href = 'my_reserve';
	       					} else {
	       						alert('예약을 완료할 수 없습니다.');
	       					}
	       				},
	       				error : function() {
	       					alert('에러입니다.')
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