<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<link href="${root }/img/view/header/logo.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${root }/css/reserve.css">
<meta charset="UTF-8">
<title>BusanWellnessLife</title>
</head>
<body>
	<c:if test="${empty member }">
		<script>
			alert('로그인이 필요한 페이지입니다.')
			location.href = '${root}/login'
		</script>
	</c:if>
	<jsp:include page="/WEB-INF/jsp/header/header.jsp" />
	<jsp:include page="/WEB-INF/jsp/header/header_tourist.jsp" />
	
	<div class="reserve_wrap_main">
		<div class="left_area">
			<div class="package_img">
				<img src="${root }/packageimg/${pVO.package_thumbnail}">
			</div>
			<div class="package_headline">
				<div class="package_headline_top">
					<div class="package_name">${pVO.package_category }</div>
					<div class="package_rest">잔여 ${pVO.max_num - pVO.number_of_reservation }</div>
				</div>
				<div class="package_headline_bottom">${pVO.package_start_date } ~ ${pVO.package_end_date }</div>
			</div>
			<div class="package_contents_list">
				<div class="package_contents">
					<div class="package_content" onclick="categorySelect(event)">${pVO.tour_name1 }</div>
					<c:if test="${not empty pVO.tour_name2 }">
					<div class="package_content" onclick="categorySelect(event)">${pVO.tour_name2 }</div>
					</c:if>
					<c:if test="${not empty pVO.tour_name3 }">
					<div class="package_content" onclick="categorySelect(event)">${pVO.tour_name3 }</div>
					</c:if>
					<c:if test="${not empty pVO.tour_name4 }">
					<div class="package_content" onclick="categorySelect(event)">${pVO.tour_name4 }</div>
					</c:if>
					<c:if test="${not empty pVO.tour_name5 }">
					<div class="package_content" onclick="categorySelect(event)">${pVO.tour_name5 }</div>
					</c:if>
				</div>
				<script>
					function categorySelect(event) {
						let tnValue = event.target.innerText
						console.log(tnValue)
						location.href = '${root}/reserve_tourname?no=${pVO.package_idx}&tourname=' + tnValue
					}		
				</script>
				<script>
					function whatTour() {
						var tname = '${tVO.tour_name}'
						var tnames = document.querySelectorAll('.package_content')
						for(let i = 0; i < tnames.length; i++) {
							tnames[i].style.color = '#707070'
							tnames[i].style.borderBottom = 'none'
							if(tname == tnames[i].innerText) {
								tnames[i].style.color = '#72866C'
								tnames[i].style.borderBottom = '2px solid #72866C'
							}
						}
					}
					whatTour()
				</script>
				<div class="package_contents_info">
					<c:if test="${not empty tVO.tour_address }">
					<div class="address"><span>주 소 : </span>${tVO.tour_address } ${tVO.tour_address_detail }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_tel }">
					<div class="tel"><span>연락처 : </span>${tVO.tour_tel }</div>
					</c:if>
					<c:if test="${not empty tVO.tour_transportation }">
					<div class="address"><span>교통정보 : </span>${tVO.tour_transportation }</div>
					</c:if>
				</div>
			</div>
		</div>
		<div class="right_area">
			<div class="reserve_member_info">
				<form class="reserve_form" method="POST">
				<input type="hidden" name="package_idx" value="${pVO.package_idx }">
					<div class="reserve_member_info_input">
						<div class="reserve_info_title">
							<div class="left">예약자 정보</div>
							<div class="right"><span>* </span>필수 입력 항목</div>
						</div>
						<div class="reserve_name">
							<div class="title"><span>* </span>예약자</div>
							<div class="reserve_name_input">
								<input type="hidden" name="member_idx" value=${member.member_idx }>
								<input type="hidden" name="member_userid" value=${member.member_userid }>
								<input type="text" name="member_name" value="${member.member_name }" required="required">
							</div>
						</div>
						<div class="reserve_tel">
							<div class="title"><span>* </span>연락처</div>
							<div class="reserve_tel_input">
								<input type="text" name="member_phone" value="${member.member_phone }" required="required">
							</div>
						</div>
						<div class="reserve_email">
							<div class="title"><span>* </span>이메일</div>
							<div class="reserve_email_input">
								<input type="text" name="member_email" value="${member.member_email }" required="required">
							</div>
						</div>
					</div>
					<div class="reserve_date">
						<div class="reserve_date_title">날짜선택</div>
						<div class="reserve_calandar">
							<div class="reserve_calandar_input">
								<input type="date" name="reserve_theday" required="required">
							</div>
						</div>
					</div>
					<div class="reserve_price_count">
						<div class="reserve_price_count_title">가격/수량선택</div>
						<div class="reserve_package_info">
							<div class="reserve_package_info_detail">
								<div class="reserve_package_name">${pVO.package_name }<input type="hidden" name="package_name" value="${pVO.package_name }"></div>
								<div class="reserve_package_price">
									<input type="hidden" id="package_price_value" name="package_price" value="${pVO.package_price }" readonly>
									${pVO.package_price }원
								</div>
							</div>
							<div class="count_people">
								<div class="minus" onclick="minusHandler()">-</div>
								<input id="cntPeople" type="number" name="reserve_count" value="1" min="1" max="${pVO.max_num - pVO.number_of_reservation }">
								<div class="plus" onclick="plusHandler()">+</div>
							</div>
						</div>
						<div class="package_price_sum">
							${pVO.package_price }
						</div>
						<input type="hidden" id="sum_price_value" name="sum_price" value="${pVO.package_price }">
					</div>
					<div class="reserve_btn">
						<a href=""><button>예약하기</button></a>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div class="sizeModal">
		<div class="textModal">부산웰니스라이프는<br>PC 1920*1080 해상도에<br>최적화되어있습니다.</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/footer/footer.jsp" />

</body>
<script>
var package_price_sum = document.querySelector('.package_price_sum')
let priceComma = package_price_sum.innerText.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
package_price_sum.innerText = priceComma + ' 원'

function minusHandler() {
	var cntPeople = document.getElementById('cntPeople')
	if(cntPeople.value <= 1){
		alert('인원 수는 1명 이상이어야합니다.')
	}else {
		cntPeople.value = parseInt(cntPeople.value) - 1
		var package_price_sum = document.querySelector('.package_price_sum')
		var sum_price_value = document.getElementById('sum_price_value')
		let sumValue = parseInt('${pVO.package_price}') * parseInt(cntPeople.value)
		sum_price_value.value = sumValue
		package_price_sum.innerText = parseInt('${pVO.package_price}') * parseInt(cntPeople.value)
		let priceComma = package_price_sum.innerText.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
		package_price_sum.innerText = priceComma + ' 원'
	}
	console.log(sum_price_value.value)
}
function plusHandler() {
	var cntPeople = document.getElementById('cntPeople')
	if(cntPeople.value >= parseInt(parseInt('${pVO.max_num - pVO.number_of_reservation}'))){
		alert('인원 수는 ' + '${pVO.max_num - pVO.number_of_reservation}명 이하여야합니다.')
	}else {
		cntPeople.value = parseInt(cntPeople.value) + 1
		var package_price_sum = document.querySelector('.package_price_sum')
		var sum_price_value = document.getElementById('sum_price_value')
		let sumValue = parseInt('${pVO.package_price}') * parseInt(cntPeople.value)
		sum_price_value.value = sumValue
		package_price_sum.innerText = parseInt('${pVO.package_price}') * parseInt(cntPeople.value)
		let priceComma = package_price_sum.innerText.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
		package_price_sum.innerText = priceComma + ' 원'
	}
	console.log(sum_price_value.value)
}
</script>
</html>