<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강신청 승인</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
	/* 페이지 설정 */
    var pageSize = 10;
    var pageBlockSize = 5;
    var filter = null;
   
    
   /*  onload event */
    
    $(function(){
    	fRegisterButtonClickEvent();
    	    	
    	fn_approvalist();
    	
	});

   
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_approvalist();
					break;	
				case 'btnPendingSearch' :
					filter ="pending";
					fn_approvalist();
					break;
				case 'btnApprovalSearch' :
					filter ="approval";
					fn_approvalist();
					break;
				case 'btnDisapprovalSearch' :
					filter ="disapproval";
					fn_approvalist();
					break;
				case 'btnTotalSearch' :
					filter ="total";
					fn_approvalist();
					break;
			}
		});
	}  
	
	
	
	
	function fn_approvalist(pagenum){
		
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

			$("#listapprove").empty().append(returnvalue);

			var  totalcnt = $("#totalcnt").val();

			console.log("totalcnt : " + totalcnt);

			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_approvalist');
			console.log("paginationHtml : " + paginationHtml);

			$("#approvePagination").empty().append( paginationHtml );

			$("#pageno").val(pagenum);
		}

		callAjax("/supath/approvalist.do", "post", "text", false, param, listcallback) ;
	}
	
	
	
	/* 승인 및 반려 */
	function fn_approve(stuid,lecno,accyn) {
	
		/* 승인 전 확인 메세지 */
		var result = confirm('진행하시겠습니까?');
		
		if (result){
			var param = { 
					stud_id : stuid
					,lec_no : lecno
					,acc_yn : accyn
					}
			
			var aprovecallback = function(reval) {
				fn_approvalist($("#pageno").val())
				
				if(accyn == "Y") {
					alert("승인되었습니다.");
				} else {
					alert("반려되었습니다.");
				}
				
				console.log(JSON.stringify(reval));
			};			
						
			callAjax("/supath/approvelecture.do", "post", "json", false, param , aprovecallback) ;
		}else{
			alert("오류가 발생했습니다.")
		}		
	}

	
	
function fn_leclist(){
		
		var param ={
				searchKey : $("#searchKey").val()
				, lec_name : $("#lec_name").val()
				, lec_no : $("#lec_no").val()
				
		}
		var leclistcallback = function(returnvalue) {
			console.log(returnvalue);

			$("#listlecture").empty().append(returnvalue);

		}

		callAjax("/supath/leclist.do", "post", "text", false, param, leclistcallback) ;
	}
	
	
	
	


</script>

</head>
<body>
<form id="myForm" action=""  method="">
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
							<a href="../supath/approval.do" class="btn_set refresh">새로고침</a> 
						</p>

						<p class="conTitle">
							<span>수강 신청 승인</span> 
							<span class="fr">
 							 <span><b>강 의 명</b>&nbsp&nbsp </span> 
							  <select id="searchKey" name="searchKey" style="width: 100px;">
							  		<option value="" id="option1" selected="selected">전체</option>
							  		<c:forEach items="${lecsearchlist}" var="list" varStatus="status">
										<option value="${list.lec_no}">${list.lec_name}</option>										
								</c:forEach>
									  
							     </select>                
	                              <a href="" class="btnType blue" id="btnSearch" name="btn" id="searchEnter"><span>검  색</span></a>
							   
							</span>
							
    
						</p>
						
						<div class="myLectureList" style="margin-bottom:10px">
						<a href="" class="btnType blue" id="btnApprovalSearch" name="btn"><span>승인 학생</span></a> 
						<a href="" class="btnType blue" id="btnPendingSearch" name="btn"><span>승인 대기 학생</span></a>
						<a href="" class="btnType blue" id="btnDisapprovalSearch" name="btn"><span>반려 학생</span></a>
						<a href="" class="btnType grey" id="btnTotalSearch" name="btn"><span>전체 학생</span></a>
						</div>
						
						<div class="approveList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="27%">
									<col width="27%">
									<col width="10">
									<col width="10%">
									<col width="10%">
									<col width="16%">

									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의 기간</th>
										<th scope="col">강의명</th>
										<th scope="col">신청인</th>
										<th scope="col">신청인 아이디</th>
										<th scope="col">진행 상태</th>
										<th scope="col">승인/반려</th>
									
									</tr>
								</thead>
								<tbody id="listapprove"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="approvePagination"> </div>
						
                       

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


</form>
</body>
</html>