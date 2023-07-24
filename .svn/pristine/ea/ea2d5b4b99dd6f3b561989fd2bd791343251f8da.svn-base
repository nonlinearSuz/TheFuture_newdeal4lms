<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
			<!-- 관리자로 접속할 경우 밖으로 나가라.. -->
		<c:choose>
			<c:when test="${sessionScope.userType == 'M'}">
						  <c:redirect url="/dashboard/dashboard.do"/>
			</c:when>	
		</c:choose>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
table.type11 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: center;
  line-height: 1.5;
  margin: 0px 5px;
}
table.type11 th {
  width: 155px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #fff;
  background: #ce4869 ;
}
table.type11 td {
  width: 155px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #eee;
}
</style>

<title>나의 예약</title>
<!--     
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> -->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
//페이징 설정
var pageSize = 5; //한페이지당 몇개씩 보여줄래
var pageBlockSize= 5; //페이지번호갯수 몇개까지 보여줄래 (page navigation번호)

//날짜설정
var today = new Date();
var year = today.getFullYear();
var month = ('0' + (today.getMonth() + 1)).slice(-2);
var day = ('0' + today.getDate()).slice(-2);
var dateString = year + '-' + month  + '-' + day; //

var hours = ('0' + today.getHours()).slice(-2); 
var minutes = ('0' + today.getMinutes()).slice(-2);
var seconds = ('0' + today.getSeconds()).slice(-2); 

var timeString = hours + ':' + minutes  + ':' + seconds;

var nowpoint = dateString + " " + timeString;



/** OnLoad event */
$(function() {
	// 버튼 이벤트 등록 :나중에 가져와라;; 검색버튼 누르면!
	//fRegisterButtonClickEvent();

	
	fn_myRsvList();	

});

function fn_myRsvList(pageNum){
	
	pageNum = pageNum || 1; //undefined 이면 1값을 세팅해라.
	//alert('실행 되었습니다. 내 예약목록 fn_myRsvList');
	$("#host").empty();
	$("#participants").empty();
	$("#studytime").empty();
	$("#studytitle").empty();
	$("#studycont").empty();
	$("#countpeople").empty();
	
	
	var param = {
			//lec_no : $("#leclist").val()	 검색 조건을 아직 설정X	
		   pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pageNum : pageNum
		}
		

	var listcallback = function(returnvalue){
		//컨트롤러에서 리턴받는 데이터 (listgrd.jsp --> list.jsp)
		console.log('list함수 실행하고 컨트롤러에서 컬백받는 value :'+ returnvalue);
		
		$("#myrsvlist").empty().append(returnvalue); 
					//tbody 영역 
		
					
		var totalCnt = $("#myBook_totalCnt").val();
		console.log("totalCnt: "+ totalCnt);

				
		//페이지 네비게이션 getPaginationHtml 공통함수
		var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSize, pageBlockSize, 'fn_myRsvList');
		console.log("paginationHtml : " + paginationHtml);
		$("#myrsvPagination").empty().append( paginationHtml );
	}

	callAjax("/rsvapl/myrsvlist.do", "post", "text", false, param, listcallback);
}


function fn_delete(book_no, cnt){
	if(confirm("참석자가 없어야 취소가능합니다. 삭제하시겠습니까?")){
		if(cnt>1){
			swal("참석자가 존재하여 삭제할 수 없습니다.");
			return;			
		}
		
	}else{
		return;
	}

	var param = {
			book_no: book_no
			,cnt : cnt
	}
	
	 var listcallback = function(reval){
		console.log(reval);//object
		console.log(JSON.stringify(reval)); //{"returnVal":1}
		 if(reval.returnVal > 0 && reval.returnValMeeting>0){
				swal("삭제 되었습니다.");
				fn_myRsvList();
				
		
		 } else {
			 alert("오류가 발생되었습니다.");
		 }
		
		
	}
	 callAjax("/rsvapl/myBookDelete.do", "post", "json", false, param, listcallback);
}

function fn_withdraw(book_no){
	if(confirm("정말 탈퇴하시겠습니까?")){
		
	}else{
		return;
	}
	var param= {
			book_no : book_no
	}
	var outcallback = function(reval) {
		console.log(JSON.stringify(reval));
		console.log(reval.oneBook);
		
		if(reval.returnVal <0){
			swal("오류가 발생했습니다.");
			
		}else{
			swal("탈퇴에 성공하였습니다.");
			//fn_makeTable();
			//gfCloseModal();
			fn_myRsvList();
		
		}
		
	};	
	
	callAjax("/rsvrem/outMeeting.do", "post", "json", false, param , outcallback) ;
}


function fn_rsvinfo(book_no){

	var param= {
			book_no : book_no
	}
	var infocallback = function(reval) {
		console.log(JSON.stringify(reval));
		console.log(reval.oneBook);
		
		//alert(reval.oneBook.loginID);
		$("#host").empty().append(reval.oneBook.name+" (" +reval.oneBook.loginID+ ") ");
		$("#participants").empty().append(reval.oneBook.concatname+ " ("+reval.oneBook.concatloginID+") ");
	//	$("#participants").empty().append(reval.oneBook.concatname);
		$("#studytime").empty().append(reval.oneBook.book_date+" "+reval.oneBook.startTime+"시 ~ "+
				reval.oneBook.endTime+"시 ");
		$("#studytitle").empty().append(reval.oneBook.book_title);
		$("#studycont").empty().append(reval.oneBook.book_cont.replace("\r\n", "<br>").replace(" ", "&nbsp;"));
		$("#countpeople").empty().append(reval.oneBook.cnt+"/"+reval.oneBook.book_per_cnt);
	
	};	
	
	callAjax("/rsvrem/selectOne.do", "post", "json", false, param , infocallback) ;
}

</script>
</head>
<body>

	<input type="hidden" id="pageno"  name="pageno"  />
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
								class="btn_nav bold">예약관리</span> <span class="btn_nav bold">나의예약
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침★</a>
						</p>
				
						<p class="conTitle">
							
	
							
							<span>내 예약 현황</span> 
							
					<!-- 	<span class="fr">													
								 <select id="leclist" name="leclist" style="width: 150px;" >
										<option value="" >전체</option>									    				    									
								</select> 							
	                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</span> -->
							
						</p>
			
						<div class="myRsvList">
					
			
							<table class="col">
								<caption>나의 예약 목록</caption>
								<colgroup>
									<col width="5%">
									<col width="15%">
									<col width="10%">
									<col width="30%">									
									<col width="25%">
									<col width="15%">							
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">스터디룸 이름</th>
										<th scope="col">예약상태</th>
										<th scope="col">예약제목</th>
										<th scope="col">예약시간</th>
										<th scope="col">취소/탈퇴</th>						
									</tr>
								</thead>
								<tbody id="myrsvlist"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="myrsvPagination"> </div>
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                  
     	                     
                           </td> 
                           
                        </tr>
                     </table> 
                     
                     <br>
    			      <p class="conTitle" style="margin-bottom: 1%;">
									<span style="font-size:1.6em;">예약 상세 </span> 
									<span class="fr"> 
										 스터디 이용 수칙
									</span>
								</p>	
					<div class="fixed-table-body">		
							<table class="col">
								<caption>예약상세보기</caption>
								<colgroup>
									<col width="20%">
									<col width="50%">
									<col width="10%">
									<col width="20%">							
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">방장 이름(ID)</th>
										<th scope="col">참여자 이름(ID)</th>
										<th scope="col">참여자 수</th>										
										<th scope="col">스터디 시간</th>																
									</tr>
						
								</thead>
								<tbody>
									<tr>
									<td id="host">방장바보</td>
									<td id="participants">참여자들</td>
									<td id="countpeople">참여자수</td>
									<td id="studytime">시간임~</td>
									</tr>
								</tbody>
							</table>
							
							<table class="col">
								<caption>예약상세보기2</caption>
								<colgroup>
									<col width="40%">
									<col width="60%">	
									<col width="60%">
									<col width="60%">												
								</colgroup>
	
								<thead>							
									<tr>
										<th scope="col">스터디 제목</th>									
										<th scope="col" colspan=3>스터디 내용</th>							
										
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="studytitle">시간임~</td>										
											<td id="studycont" colspan="3"
											style="word-break:break-all;word-wrap:break-word"
											>
											
											</td>
							

											
									
									</tr>
								</tbody>
							</table>
                     
    				</div>
                           
					</div> <!--// content -->
					


					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>



</body>
</html>