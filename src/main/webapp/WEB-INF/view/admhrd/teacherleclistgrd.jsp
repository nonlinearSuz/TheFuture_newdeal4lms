<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.time.LocalDate"%>

<script type="text/javascript">
// 회원정보(비고) 수정
function fn_userEtc() {
	
	var loginID =  $('#teacher_id').text();	
	var userEtc = $('#userEtc').val();
	
	console.log("loginID : " + $('#teacher_id').text());
	console.log("userEtc : " + $('#userEtc').val());
	 if (confirm("저장하시겠습니까?") == true) {
			
		 	// Ajax 요청에 전달할 매개변수를 객체 형태로 param 변수에 정의 
		 	var param = {
					loginID : loginID
					,userEtc : userEtc
            } ;
             var listcallback = function(returnvalue) {
            	 // Ajax 요청이 성공적으로 완료되면 실행될 콜백 함수를 정의
            	 // 콜백 함수는 returnvalue라는 매개변수를 받아서 사용
                  alert("저장되었습니다.");
                  gfCloseModal();
            };
             callAjax("/admhrd/userEtc.do", "post", "text", false, param, listcallback) ;
        } else {
            return false;
        }	
}
</script>

<dl>
	<dt>
		<strong>강사 정보</strong>
	</dt>
	<dd class="content">
		<!-- s : 여기에 내용입력 -->
		<table class="row">
			<caption>caption</caption>
			<colgroup>
				<col width="120px">
				<col width="200px">
				<col width="120px">
				<col width="200px">
			</colgroup>

			<tbody>
				<tr>
					<th class="row">ID</th>
					<td id="teacher_id" colspan="3">${teachersearch.loginID}</td>
				</tr>
				<tr>
					<th class="row">이름</th>
					<td id="teacher_name">${teachersearch.name}</td>
					<th class="row">생년월일</th>
					<td id="teacher_birth">${teachersearch.user_birth}</td>
				</tr>
				<tr>
					<th class="row">전화번호</th>
					<td id="teacher_hp">${teachersearch.user_hp}</td>
					<th class="row">성별</th>
					<td id="teacher_gender">${teachersearch.user_gender}</td>
				</tr>
				<tr>
					<th class="row">이메일</th>
					<td id="teacher_email" colspan="3">
						${teachersearch.user_email}</td>
				</tr>
				<tr>
					<th class="row">주소</th>
					<td id="teacher_address" colspan="3">
						${teachersearch.user_addr}</td>
				</tr>
				<tr>
					<th class="row">상세주소</th>
					<td id="address_detail" colspan="3">
						${teachersearch.addr_detail}</td>
				</tr>
				<tr>
					<th class="row">비고</th>
					<td colspan="3"><input type="text"
						style="height: 20px; width: 400px;" id="userEtc" name="userEtc"
						value="${teachersearch.user_etc}"></td>
				</tr>

				<tr>
					<td colspan="4">
						<p class="conTitle mt20">
							<span>강의 목록</span>
						</p>
                  		<div style="max-height: 300px; overflow-y: auto;">
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="10%">
								<col width="35%">
								<col width="35%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">강의ID</th>
									<th scope="col">강의명</th>
									<th scope="col">기간</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty leclist}">
	                              <tr>
	                                 <td colspan="5">데이터가 존재하지 않습니다.</td>
	                              </tr>
	                           </c:if>
								<c:forEach items="${leclist}" var="list">
									<tr>
										<td>${list.lec_no}</td>
										<td>${list.lec_name}</td>
										<td>${list.lec_start}~${list.lec_end}</td>
										<td><c:set var="start" value="${list.lec_start}" /> <c:set
												var="end" value="${list.lec_end}" /> <c:set var="now"
												value="<%=LocalDate.now()%>" /> <c:choose>
												<c:when test="${now < start}">
															예정
												</c:when>
												<c:when test="${now > end}">
															완료
												</c:when>
												<c:otherwise>
															진행중
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
							</tbody>
						</table>
						</div>
						<div class="btn_areaC mt30">
						<a href="#" class="btnType blue" id="btnpopUpdate" name="btn" 
						onclick="fn_userEtc();"><span>수정</span></a>
							<a href=javascript:gfCloseModal() class="btnType gray" id="btnpopClose" name="btn"><span>닫기</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</dd>
</dl>

