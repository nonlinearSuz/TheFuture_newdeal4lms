<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>성적조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     		// 화면에 뿌릴 데이터 수 
	var pageBlockSize = 5;    // 블럭으로 잡히는 페이징처리 수
	var filter = getCookie('EMP_ID');

	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		var cookie_user_id = getCookie('EMP_ID');
		console.log("확1인 : " + cookie_user_id);
		fn_gradelist();

	});
	

	
	/** 버튼 이벤트 등록 */

	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			console.log("btnId : " + btnId);
			switch (btnId) {
				case 'btnSearch' :
					filter=null;
					fn_gradelist();
					break;

				case 'btnpopClose' :
				case 'btnClose' :
				case 'btnCloseFile' :
					gfCloseModal();
					break;
				case 'btnView' :
					  $("#gradestdlist").empty(); // gradestdlist 요소 초기화

					  var lec_no = $('#lec_no').val();
					  console.log("lec_no : " + lec_no);
					  var obj = {
					    lec_no: lec_no
					  };

					  if(lec_no == "all") {
						  fn_gradelist();
					  } else {
						  fn_gradelist("", obj); 
					  }
					  break;
				case 'btnQuit':
					//fn_gradelist("", "AccountCancel");
					break;
			}
		});
	}
	
	function fn_gradelist(pagenum, obj) {
		// 기본값 설정
		pagenum = pagenum || 1;

		var param = {
		    pageSize : pageSize							// 페이지당 항목 수
		  , pageBlockSize : pageBlockSize		// 페이지 블록 단위
		  , pagenum : pagenum							// 현재 페이지 번호
		  , value : filter											// 필터링 위한 값
		} 
		
		// obj 가 null 이면 "" 공백으로 전환, 그렇지 않은 경우 obj의 속성을 param에 추가
		if(obj == null) { 
			obj = "";
		} else {
			var keys = Object.keys(obj);
			for(i = 0; i < keys.length; i++) {
				param[keys[i]] = obj[keys[i]];
			};
		}
		
		// 결과 처리 콜백 함수
			var listcollabck = function(returnvalue) {
			console.log("확인 : " + returnvalue);
 			$("#gradelist").empty().append(returnvalue);
			
 			var  totalcnt = $("#totalcnt").val();
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_gradelist');
			console.log("paginationHtml : " + paginationHtml);
			
			$("#gradePagination").empty().append( paginationHtml );
			$("#pageno").val(pagenum); 
		}
		callAjax("/exmrex/gradelist.do", "post", "text", false, param, listcollabck) ;
	}
	
	
	function fn_selectone(pagenum, lec_no) {
		
		// 기본값 설정
		pagenum = pagenum || 1;

		var param = {
		    pageSize : pageSize						// 페이지당 항목 수
		  , pageBlockSize : pageBlockSize		// 페이지 블록 단위
		  , pagenum : pagenum							// 현재 페이지 번호
		  , lec_no : lec_no											// 필터링 위한 값
		} 
		
		// 결과 처리 콜백 함수
		var selectoncallback = function(returnvalue) {
		console.log("확인 : " + returnvalue);
		$("#gradestdlist").empty().append(returnvalue);
		
		var  totalcnt = $("#totalleccnt").val();
		console.log("totalleccnt : " + totalcnt);
		
		var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_selectone', [lec_no]);
		console.log("paginationHtml : " + paginationHtml);
		
		$("#gradestdPagination").empty().append( paginationHtml );
		$("#pagenolec").val(pagenum); 
		console.log("pagenum : " + pagenum);
		console.log("pageSize : " + pageSize);
		
	}
		callAjax("/exmrex/gradeselectone.do", "post", "text", true, param, selectoncallback) ;
	}
	
</script>

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->
	<form id="myForm" action="" method="">
		<input type="hidden" id="action" name="action" /> 
		<input type="hidden" id="notice_no" name="notice_no" /> 
		<input type="hidden" id="pageno" name="pageno" /> 
		<input type="hidden" id="pagenolec" name="pagenolec" /> 
		<input type="hidden" id="grade_user" name="loginID" value="">

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
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">성적관리</span> 
								<span class="btn_nav bold">성적 조회</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
							</p>
						
							<p class="conTitle">
								<span>성적 조회</span> <span class="fr"> <select id="lec_no">
										<option value="all" id="option1" selected="selected">강의 목록</option>
										<c:forEach var="dto" items="${lectureList}" varStatus="status">
											<option value="${dto.lec_no}" name="lec_no">${dto.lec_name}</option>
										</c:forEach>
								</select> <a class="btnType blue" id="btnView" name="btn"><span>검색</span></a>
								</span>
							</p>
						
                  		<div style="height: 400px; overflow-y: auto;">
							<table class="col">
								<thead>
									<tr>
										<th scope="col" colspan="5">성적 조회</th>
									</tr>
								</thead>
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="30%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col"><b>시험 이름</b></th>
										<th scope="col">시험 시작일</th>
										<th scope="col">시험 종료일</th>
									</tr>
								</thead>
								<tbody id="gradelist"></tbody>
							</table>
							<div class="paging_area" id="gradePagination"></div>
						</div>
						

                  		<div style="height: 400px; overflow-y: auto;">
						<table class="col">
							<thead>
								<tr>
									<th scope="col" colspan="5">시험 응시 상황</th>
								</tr>
							</thead>
							<caption>caption</caption>
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">학생ID</th>
									<th scope="col">학생 이름</th>
									<th scope="col">점수</th>
									<th scope="col">응시 날짜</th>
									<th scope="col">합격 여부</th>
								</tr>
							</thead>
							<tbody id="gradestdlist"></tbody>
						</table> <!--// content -->
						<div class="paging_area" id="gradestdPagination"></div>
						</div>
						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		</div>
	</form>
</body>
</html>