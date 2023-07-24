<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>나의 수강 신청 내역</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

                              
<script type="text/javascript">
	/* 페이지 설정 */
    var pageSize = 10;
    var pageBlockSize = 5;
    var filter = null;
   
    
   	/* onload event */
    $(function(){
    	fRegisterButtonClickEvent();
    	    	
    	fn_myLecturelist();
    	    	
	});

	
   	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_myLecturelist();
					break;
				case 'approvebtn' :
					fn_cancel();
					break;
				case 'btnPendingSearch' :
					filter ="pending";
					fn_myLecturelist();
					break;
				case 'btnApprovalSearch' :
					filter ="approval";
					fn_myLecturelist();
					break;
				case 'btnDisapprovalSearch' :
					filter ="disapproval";
					fn_myLecturelist();
					break;
				case 'btnCancelSearch' :
					filter ="cancel";
					fn_myLecturelist();
					break;
				case 'btnTotalSearch' :
					filter ="total";
					fn_myLecturelist();
					break;
			}
		});
	}  
	
	
   	
   	
	function fn_myLecturelist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param ={
				searchKey : $("#searchKey").val()
				, sname : $("#sname").val()
				, acc_yn : $("#acc_yn").val()
				, pageSize : pageSize
				, pageBlockSize : pageBlockSize
				, pagenum : pagenum
				, value : filter
				
		}
		var listcallback = function(returnvalue) {
			console.log(returnvalue);

			$("#listmyLecture").empty().append(returnvalue);

			var  totalcnt = $("#totalcnt").val();

			console.log("totalcnt : " + totalcnt);

			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_myLecturelist');
			console.log("paginationHtml : " + paginationHtml);

			$("#myLecturePagination").empty().append( paginationHtml );

			$("#pageno").val(pagenum);
		}

		callAjax("/supmya/myLecturelist.do", "post", "text", false, param, listcallback) ;
		
	}
	
	
	
	
	function fn_cancel(loginid,lecno,accyn) {
		
		var result = confirm('취소하시겠습니까?');
		
		if (result){
			var param = { 
					loginID : loginid
					,lec_no : lecno
					,acc_yn : accyn
					}
			
			var cancelcallback = function(reval) {
				fn_myLecturelist($("#pageno").val())
				alert("취소되었습니다.");
				
				console.log(JSON.stringify(reval));
			};			
						
			callAjax("/supmya/cancelmylecture.do", "post", "json", false, param , cancelcallback) ;
		}else{
			alert("오류가 발생했습니다.")
		}	
		
	}
	
	
	
	
function fn_apply(loginid,lecno,accyn) {
		
		var result = confirm('재신청하시겠습니까?');
		
		if (result){
			var param = { 
					loginID : loginid
					,lec_no : lecno
					,acc_yn : accyn
					}
			
			var applycallback = function(reval) {
				fn_myLecturelist($("#pageno").val())
				alert("신청되었습니다.");
				
				console.log(JSON.stringify(reval));
			};			
						
			callAjax("/supmya/applymylecture.do", "post", "json", false, param , applycallback) ;
		}else{
			alert("오류가 발생했습니다.")
		}	
		
	}


</script>

</head>
<body>
<form id="myForm" action=""  method="" onsubmit = "retrun false">
    <input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="lec_no"  name="lec_no"  />
	<input type="hidden" id="pageno"  name="pageno"  />
	<input type="hidden" id="loginid"  name='${loginId}'  />   <!-- 이 정보로 loginid  -->
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
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">나의 수강 신청 내역</span> 
							<a href="../supmya/myLecture.do" class="btn_set refresh">새로고침</a>
						</p>



						<p class="conTitle">
							<span>나의 수강 신청 내역</span> 
							<span class="fr">
							<span><b>강 의 명</b>&nbsp&nbsp </span> 
							     <input type="text" style="width: 150px; height: 25px;" id="sname" name="sname">                    
	                              <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span>
						</p>
						
																
						<div class="myLectureList" style="margin-bottom:10px">
						<a href="" class="btnType blue" id="btnApprovalSearch" name="btn"><span>수강 강의</span></a> 
						<a href="" class="btnType blue" id="btnPendingSearch" name="btn"><span>승인 대기 강의</span></a>
						<a href="" class="btnType blue" id="btnDisapprovalSearch" name="btn"><span>반려 강의</span></a>
						<a href="" class="btnType blue" id="btnCancelSearch" name="btn"><span>수강 취소</span></a>
						<a href="" class="btnType grey" id="btnTotalSearch" name="btn"><span>전체</span></a>
						</div>
						
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="23%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="12%">
									<col width="10%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의 기간</th>
										<th scope="col">강의명</th>
										<th scope="col">담당 교수</th>
										
										<th scope="col">시험 성적</th>
										<th scope="col">과락 여부</th>
										
										<th scope="col">진행 상태</th>
										<th scope="col">취소/재신청</th>
									</tr>
								</thead>
								<tbody id="listmyLecture"></tbody>
							</table>
							
							<div class="paging_area"  id="myLecturePagination"> </div>
						</div>
	
                       </div>

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				
				</div>
				</li>
			</ul>
		
	</div>

</form>
</body>
</html>