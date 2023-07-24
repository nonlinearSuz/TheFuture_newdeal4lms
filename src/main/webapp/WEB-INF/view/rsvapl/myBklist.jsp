<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 예약 현황</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
/** OnLoad event */ //html만 뿌려놓은상태
$(function() {
	// 버튼 이벤트 등록 :나중에 가져와라;; 검색버튼 누르면!
	//fRegisterButtonClickEvent(); 
	
	
	
	//colorSelectEvent(); //색상선택버튼
	//dateSelectEvent(); //날짜조회버튼
	
	myBookingList(); //내 예약현황
});

var today = new Date();
var year = today.getFullYear();
var month = ('0' + (today.getMonth() + 1)).slice(-2);
var day = ('0' + today.getDate()).slice(-2);
var dateString = year + '-' + month  + '-' + day; //



function myBookingList(){
	
	var param = {
			today: dateString
	}
	
	 var listcallback = function(returndata){
		console.log(returndata);
		$("#myBooking_tbody").empty().append(returndata); 
	}
	 callAjax("/rsvrem/myBookList.do", "post", "text", false, param, listcallback);
}	

</script>


</head>

<body>
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">예약</span> <span class="btn_nav bold">예약관리
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침★</a>
						</p>
				
						<p class="conTitle">
							
	
							
							<span>내 예약 현황</span> <span class="fr"></span>
							
								<div class="myBookingList">
			<h1 style="font-size:15px">내 예약 현황</h1>
			<br>
								
								<table class="col">
								<caption>예약목록</caption>
								<colgroup>
									<col width="15%">
									<col width="55%">
									<col width="15%">
									<col width="15%">
										
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">스터디룸명</th>
										<th scope="col">예약시간</th>
										<th scope="col">수정</th>
										<th scope="col">취소/반납</th>
							
													
									</tr>
								</thead>
								<tbody id="myBooking_tbody">
								
								</tbody>
							</table>
							</div>
							
							
							
							
							
							
							
							
					<h3 class="hidden">풋터 영역</h3>
					
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
						
</body>
</html>