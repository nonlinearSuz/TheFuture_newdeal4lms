<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강사관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;     		//  한 페이지에 표시될 데이터 수
	var pageBlockSize = 5;    // 블록 단위로 잡히는 페이징 처리 수
	var filter = null;					// 조회 필터 조건을 저장하는 변수, 승인여부

	/* *OnLoad 이벤트 */
	$(function() {
		
		fRegisterButtonClickEvent();		// 버튼 이벤트 등록
		fn_teacherlist();								// 강사목록 조회
		
		// 조회 날짜 입력 오류 체크
		$("#endDate").change(function() {
			  if ($("#endDate").val() < $("#startDate").val()) {
				alert("날짜를 잘못 입력하셨습니다.");
			    $("#endDate").val('');	  // endDate 초기화
			  }
			});
						
			$("#startDate").change(function() {
			  if ($("#startDate").val() > $("#endDate").val() && $("#endDate").val() != "") {
				alert("날짜를 잘못 입력하셨습니다.");
			    $("#startDate").val('');	 // startDate 초기화
			  }
			});
	});
	

	/** 버튼 클릭 이벤트를 등록하는 함수 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			console.log("btnId : " + btnId);
		
			switch (btnId) {
				case 'btnSearch' :			// 강사 목록 조회 버튼 클릭시
					filter=null;					// 필터를 초기화 하고
					fn_teacherlist();			// 강사 목록을 조회
					break;
					
				case 'btnpopClose' :		//팝업 닫기 버튼 클릭 시
				case 'btnClose' :			
					gfCloseModal();			//모달 팝업이 닫힘
					break;
					
				// 강사 목록 필터를 승인된 강사 또는 미승인 강사로 설정하여 조회합니다.
				case 'btnApprovalSearch':	// "승인 강사" 버튼 클릭시
					filter = "approval";			// filter 값으로 approval이 저장되고
					fn_teacherlist();					// 승인여부가 approval인 강사만 조회
					break;
				case 'btnUnapprovalSearch':
					filter = "unapproval";
					fn_teacherlist();
					break;
					
				case 'btnView' :			//날짜 옆 조회버튼
					var startDate = $('#startDate').val().split("-").join("");
				    var endDate = $('#endDate').val().split("-").join("");
					filter=null;
					console.log("Start value:", startDate);
					console.log("End value:", endDate);
					// 날짜 범위를 설정하여 강사 목록을 조회
					var dateRange = {
							  startDate: startDate,
							  endDate: endDate
							};
					fn_teacherlist("", dateRange);
					break;
			}
		});
	}

	/** 강사 목록 조회 */
	function fn_teacherlist(pagenum, obj) {
	
		pagenum = pagenum || 1;				    // 기본값 설정

		var param = {
	       searchKey : $("#searchKey").val()		// 전체/강사명/ID
		  , 	sname : $("#sname").val() 				//검색어
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		  , value : filter
		} 
		
		 // obj 가 null 이면 "" 공백으로 전환(null로 넘겨주면 컨트롤러에서 에러남), 그렇지 않은 경우 obj의 속성을 param에 추가 
		if(obj == null) { 
			obj = "";
		} else {
			var keys = Object.keys(obj);			//객체의 모든 키들을 배열로 반환
			for(i = 0; i < keys.length; i++) {	 	// 반복문을 사용하여 배열에 포함된 각 속성들을
				param[keys[i]] = obj[keys[i]];		// param에 추가
			};
		}
		
		    // 결과 처리 콜백 함수
			var listcallback = function(returnvalue) {
 				$("#listnotice").empty().append(returnvalue);	//조회 결과를 웹페이지 #listnotice 요소에 출력
	 			var  totalcnt = $("#totalcnt").val();						// 서버에 전달된 총 강사 수를 가져옴
				
	 			//페이징 처리를 위한 HTML코드 생성.
				var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_teacherlist');
				
				$("#noticePagination").empty().append( paginationHtml );  //생성된 페이징HTML코드를 웹페이지#noticePagination 요소에 추가
				$("#pageno").val(pagenum); 														// 현재 페이지 번호를 숨겨진 입력 필드 #pageno에 설정
		}
		callAjax("/admhrd/teacherlist.do", "post", "text", false, param, listcallback) ;	
		//서버에 강사 목록조회 요청. callAjax가 함수와 서버와의 통신을 담당, 
		// 'param'객체를 파라미터로 전달, 조회결과를 처리하는 콜백함수 'listcallback'을 함께 전달
	}
	
	/**  승인 버튼 */
	// 강사 승인 상태를 변경하는 함수, 강사의 loginID를 매개변수로 받습니다.
	function fn_approval(loginID) {
		 if (confirm("승인여부를 변경하시겠습니까?")) {
			 var param = {
						loginID : loginID
	            } ;
	             var listcallback = function() {
	                  alert("변경되었습니다.");
	            };
	             callAjax("/admhrd/approval.do", "post", "text", false, param, listcallback) ;
	        } else {
	            return false;
	        }	
	}
	
     /** 탈퇴 버튼 */
    // 강사 탈퇴를 처리하는 함수, 강사의 loginID와 진행중인 강의 수 lecCount를 매개변수로 받음
		function fn_teacherWithdrawal(loginID, lecCount) {
    		if(lecCount > 0) {	// 진행중인 강의가 1개 이상이면 탈퇴 불가
    			alert("진행 또는 예정인 강의가 있어 탈퇴가 불가합니다.");
    		} else { 
			 if (confirm("정말 탈퇴처리 하시겠습니까?")) { 
				//사용자가 확인 버튼을 누르면 loginID를 파라미터로 설정하여 서버에 탈퇴 요청
				 var param = {
					loginID : loginID
	            } ;
				// 탈퇴요청 후에 콜 함수 listcallback 실행
	             var listcallback = function(returnvalue) {
	                  // 강사 목록을 새로 조회하여 최신 상태로 업데이트
	                  alert("탈퇴가 완료되었습니다.");
	            };
	             callAjax("/admhrd/teacherWithdrawal.do", "post", "text", false, param, listcallback) ;
	        } else {
	        	// 사용자가 확인을 취소한 경우 함수 실행 중단
	            return false;
	        }
	   }
    }
	
	/**  강사의 상세정보를 조회하고 팝업에 표시하는 함수*/
	function fn_selectone(loginID) {		// 강사의 로그인ID를 매개변수로 받음
		var param = {
			 loginID: loginID
		}
		var selectonecallback = function(returndata) {			
			
			//서버에서 전달된 데이터를 모달 팝업 내의 #layer1 요소에 추가
			$("#layer1").empty().append(returndata);	 
			
			// 모달 팝업
			gfModalPop("#layer1");	// 데이터를 표시한 모달 팝업을 연다
			
		}
		callAjax("/admhrd/teacherselectone.do", "post", "text", false, param, selectonecallback) ;
	}
	
</script>

</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->
	<form id="myForm" action="" method="">
		<input type="hidden" id="action" name="action" /> <input
			type="hidden" id="notice_no" name="notice_no" /> <input
			type="hidden" id="pageno" name="pageno" /> <input type="hidden"
			id="teacher_user" name="loginID" value="">

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
								<span class="btn_nav bold">행정관리</span> 
								<span class="btn_nav bold">강사 관리</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강사 목록</span> 
								<span class="fr"> 
								<select	id="searchKey" name="searchKey" style="width: 150px;">
										<option value="">전체</option>
										<option value="name">강사명</option>
										<option value="loginID">ID</option>
								</select> 
								<input type="text" style="width: 300px; height: 25px;"id="sname" name="sname"> 
								<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검 색</span></a>
								</span>
							</p>



							<a href="" class="btnType blue" id="btnApprovalSearch" name="btn"><span>승인
									강사</span></a> <a href="" class="btnType blue" id="btnUnapprovalSearch"
								name="btn"><span>미승인 강사</span></a> <span
								style="margin-left: 275px;"></span> 가입일 조회 <input type="date"
								id="startDate" th:field="*{start}"
								style="height: 30px; width: 150px;"> ~ <input
								type="date" id="endDate" th:field="*{end}"
								style="height: 30px; width: 150px;"> <span
								style="margin-left: 10px;"></span> <a href=""
								class="btnType blue" id="btnView" name="btn"
								style="margin-bottom: 10px;"><span>조회</span></a>
							<div class="divtTeacherList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="30%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강사명(ID)</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입일자</th>
											<th scope="col">승인여부</th>
											<th scope="col">탈퇴</th>
										</tr>
									</thead>
									<tbody id="listnotice"></tbody>
								</table>
							</div>
							<div class="paging_area" id="noticePagination"></div>

						</div> <!--// content -->

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