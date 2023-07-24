<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;  
	var pageBlockSize = 1;    
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		ButtonClickEvent();
		
		noticeList();
		
	});
	

	/** 버튼 이벤트 등록 */

	function ButtonClickEvent() {
		$('a[id=closePop]').click(function(e) {
			e.preventDefault();
			
			var closeId = $(this).attr('Id');
			
			switch(closeId) {
			case 'closePop' :
				noticeList();
				break;
			}
		});
		
		$('a[id=closeReplyPop]').click(function(e) {
			e.preventDefault();
			
			var closeRpId = $(this).attr('Id');
			
			switch(closeRpId) {
			case 'closeReplyPop' :
				noticeList();
				break;
			}
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); // event의 고유 동작 중단 시키기.
			//e.stoppropagation => 상위 elements의 event 전파 중단.

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					noticeList();
					break;
				case 'btnSave' : 
					fn_save();
					break;
				case 'btnUpdate' :
					$("#action").val("U");
					fn_save();
					break; 
				case 'btnDelete' :
					$("#action").val("D");	
					fn_save();
					break;	
				case 'btnClose' :
					gfCloseModal();
					noticeList();
					break;
				//댓글 창으로
				case 'btnReply' :
					gfModalPop("#layer2");
					break;
				//댓글 등록
				case 'btnReplySave' :
					fn_reply();
					break;
				//댓글 삭제
				case 'btnReplyDelete' :
					fn_reply();
					break;
			}
		});
	}
	
	// 게시글 화면 기능(페이지 당)
	function noticeList(pagenum) {
		
		pagenum = pagenum || 1;
		
			var param = { // parameter 값
			  searchKey : $("#searchKey").val()
			  , sname : $("#sname").val()
			  , pageSize : pageSize
			  , pageBlockSize : pageBlockSize
			  , pagenum : pagenum
			}
		
		var listcollabck = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listnotice").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'noticeList');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#noticePagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/cmmntc/noticelist.do", "post", "text", false, param, listcollabck) ;
			
	}
	
	//댓글창 띄우는 modal
	function fn_openReplyPopUp() {
		openReplyPopUpInit();
		
		gfModalPop("#layer2");
	}
	
	//modal 내용
	function openReplyPopUpInit(object) {
		
		if(object == "" || object == null || object == undefined) {
				$("#nt_no").val("");
				$("#noti_title").val("");
				$("#noti_contents").val("");
				$("#rpy_no").val("");
				$("#rpy_contents").val("");
				$("#enr_user").val("");
				$("#enr_date").val("");
				$("#upd_user").val("");
				$("#upd_date").val("");
				
				$("#btnReplySave").show();
				$("#btnReplyUpdate").hide();
				$("#btnReplyDelete").hide();
				
				$("#action").val("I");
		} else {
			$("#nt_no").val(object.nt_no);
			$("#noti_title").val(object.nt_title);
			$("#noti_contents").val(object.nt_contents);
			$("#rpy_no").val(object.rpy_no);
			$("#rpy_contents").val(object.rpy_contents);
			
			$("#action").val("U");
			
			
			var noticeListRv = noticeRvList;
			 if(noticeListRv.length <1) {
				 $("#re_title").hide();
				 $("#re_body").hide();
			 } else {
				 $("#re_title").show();
				 $("#re_body").show();
			 }

			 //댓글
			 $(".re_body").html("");
			 for(var i=0; i<noticeListRv.length; i++) {
				 var $td1 = $("<td>");
				 var $td2 = $("<td>").css("word-break", "break-all");
				 var $td3 = $("<td>");
				 var $tr = $("<tr>");
			
			 	var $a = $("<a>").attr("href", "").addClass("deleteBtn").text("delete").css("color", "red");
			 	//댓글 작성자일시 삭제버튼 생성
			 	if(noticeListRv[i].enr_user == "${loginID}") {
			 		$td2.append(noticeListRv[i].rpy_contents + " ").append($a);
			 	} else {
			 		$td2.append(noticeListRv[i].rpy_contents + " ");
			 	}
			 	
			 	$td1.append(noticeListRv[i].ui.name);
			 	$td3.append(noticeListRv[i].enr_date);
			 	$tr.append($td1).append($td2).append($td3);
			 	$(".re_body").append($tr);
			 } 
		}
	}
	
	//댓글 작성
	function fn_reply() {
		var param = {
				action : $("#action").val(),
				rpy_no : $("#rpy_no").val(),
				nt_no : $("#nt_no").val(),
				nt_title : $("#noti_title").val(),
				nt_contents : $("#noti_contents").val(),
				rpy_contents : $("#rpy_contents").val(),
				enr_user : '${loginId}'
		}
		
		var resultCallback = function(data) {
			console.log(JSON.stringify(data));
			
			if(data.returnval > 0) {
				alert("수행되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					
				} else {
					
				} 
			} else {
				alert("오류가 발생하였습니다.");
			}
		} 
		
		callAjax("/cmmntc/insertRp.do", "post", "json", false, param, resultCallback);
	}
	
	function fn_openpopup() {
		
		popupinit(); // clean()
		
		// 모달 팝업
		gfModalPop("#layer1");
		
	}
		
 	function popupinit(object) {
		
		if(object == "" || object == null || object == undefined) {
			$("#nt_no").val("");
			$("#nt_title").val("");		
			$("#nt_contents").val("");
			
			$("#noti_no").text("");
			$("#noti_writer").text("");
			$("#noti_date").text("");
			$("#noti_cnt").text("");

			$("#btnSave").show();
			$("#btnUpdate").hide();
			$("#btnDelete").hide();
			
			$("#action").val("I");	
		} else {
			$("#nt_no").val(object.nt_no);
			$("#nt_title").val(object.nt_title);		
			$("#nt_contents").val(object.nt_contents);
			
			$("#noti_no").text(object.nt_no);
			$("#noti_writer").text(object.enr_user);
			$("#noti_date").text(object.enr_date);
			$("#noti_cnt").text(object.nt_cnt);
			
			$("#btnSave").hide();
			$("#btnUpdate").show();
			$("#btnDelete").show();	
			
			$("#action").val("U");	
		}
	} 
	
	// 한건 조회
	function selectone(no) {
		
		//alert(no);
		
		var param = {
				nt_no : no
		}
		
		console.log("selectone_param" + JSON.stringify(param));
		
		var selectoncallback = function(returndata) {			
			console.log( JSON.stringify(returndata) );
			
			popupinit(returndata.noticesearch);
			
			
			// 모달 팝업
			gfModalPop("#layer1");
			/* console.log("!!!!!!! return data~~" + JSON.stringify(returndata.noticesearch.enr_user,returndata.loginID));/*  */ 
			/* fn_btnYN(returndata.noticesearch.enr_user,returndata.loginID); */
			/* console.log(JSON.stringify(returndata.noticesearch)); */
		}
		
		callAjax("/cmmntc/noticeselectone.do", "post", "json", false, param, selectoncallback) ;
		
	}
	
	
	
	 function fn_btnYN (enrUserParam,loginIDParam){
		
		console.log("fn_btnYN ---------- ing~ ");
		
/* 		const enrUser = "${list.enr_user}"; // 작성자의 아이디
	    const loginID = "${sessionScope.loginID}"; // 세션의 아이디 */
	    
		const enrUser = enrUserParam; // 작성자의 아이디
	    const loginID =  loginIDParam; // 세션의 아이디


	    if (enrUser != loginID) {
	    	document.getElementById("btnUpdate").show();
	        document.getElementById("btnDelete").show();
	    } else {
	    	document.getElementById("btnUpdate").hide();
	        document.getElementById("btnDelete").hide();
	    }

	} 
	
	// 글 등록
	function fn_save() {
		
		if ( ! fn_Validate() ) {
			return;
		}
		
		var param = {
				action : $("#action").val(), 
				nt_no : $("#nt_no").val(), //글 번호
				nt_title : $("#nt_title").val(), //글 제목
				nt_contents : $("#nt_contents").val(), //글 내용
				enr_user : '${loginId}'
		}
		console.log("fn_save_param" + JSON.stringify(param));
		var savecollback = function(reval) {
			console.log( JSON.stringify(reval) );
			
			if(reval.returnval > 0) {
				alert("작성 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					noticeList($("#pageno").val());
				} else {
					noticeList();
				}
				
			}  else {
				alert("오류가 발생 되었습니다.");				
			}
			

		}
		
		callAjax("/cmmntc/noticesave.do", "post", "json", false, param , savecollback);
		
	}
	
	// 유효성 검사
	function fn_Validate() {

		var chk = checkNotEmpty(
				[
						[ "nt_title", "제목을 입력해 주세요." ]
					,	[ "nt_contents", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	//////////////////////////   위는 파일 업이 처리
	/////////////////////////    file upload
	
	// 첨부파일 기능 시 팝업 처리
/* 	function fn_openpopupfile() {
        popupinitfile(); // clean()
		
		// 모달 팝업
		gfModalPop("#layer2");
	} */
	
/* 	function fn_savefile() {
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		var filesavecallback = function(returnval) {
			console.log( JSON.stringify(returnval) );
			
			if(returnval.returncval > 0) {
				alert("저장 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					noticelist($("#pageno").val());
				} else {
					noticelist();
				}
			}  else {
				alert("오류가 발생 되었습니다.");				
			}
		}
				
		callAjaxFileUploadSetFormData("/supntc/noticesavefile.do", "post", "json", true, fileData, filesavecallback);
		
	} */
/* 	 function Update(no) {
		var a ="<input type='text' id='re_tit' value='${detail.notice_tit}'>";
		$("#tit").text('').append(a);
		var b ="<textarea id='re_con' class='inputTxt p100' style='min-height:250px; resize:none;'>${detail.notice_con}</textarea>";
		$("#con").text('').append(b);
		$("#updateBtn").hide();
		$("#updateBtnResult").show();
} */
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="nt_no"  name="nt_no"  />
	<input type="hidden" id="rpy_no"  name="rpy_no"  />
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
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">공지사항
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지사항</span> <span class="fr">  
							 <select id="searchKey" name="searchKey" style="width: 150px;" >
							        <option value="" >전체</option>
									<option value="title" >글제목</option>
									<option value="cont" >글내용</option>
									<option value="writer">작성자</option>
							</select> 
							<input type="text" style="width: 250px; height: 25px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
			                <c:if test="${sessionScope.userType eq 'T' || sessionScope.userType eq 'S' }">
								 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal" ><span>작성</span></a>
							</c:if>
							</span>
						</p>
						
						<div class="noticeList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="40%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">글번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="listnotice"></tbody>
							</table>
						</div>
						<div class="paging_area"  id="noticePagination"> </div>&nbsp;		 
					</div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
<%-- 	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록하기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
                                 <col width="70px">
                                 <col width="90px">
                                 <col width="70px">
                                 <col width="*px">
                                 <col width="70px">
                                 <col width="90px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글번호</th>
							<td id="noti_no"></td>
							<th scope="row">제목</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="nt_title" id="nt_title" /></td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td id="noti_writer"></td>
							<th scope="row">등록일</th>
							<td colspan="2" id="noti_date"></td>
							<th scope="row">조회수</th>
							<td id="noti_cnt" ></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="5"  style="text-align: left;">
							    <textarea id="nt_contents" name="nt_contents"> </textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>작성</span></a>
					<a href="javscript:fn_openReplyPopUp" class="btnType blue" id="btnReply" name="btn"><span>댓글 작성</span></a>
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="closePop"><span class="hidden">닫기</span></a>
	</div> --%>

   <div id="layer2" class="layerPop layerType2" style="width: 800px;">
      		<dl>
			<dt>
				<strong>댓글</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->	
				<div style="height: 100px; overflow: auto !important;">
		            <!-- 댓글 테이블 -->
		            <table class="row" id="rv_area" >
		               <caption>caption</caption>
		               <colgroup>
		                  <col width="120px">
		                  <col width="*">
		                  <col width="100px">
		               </colgroup>
		
		               <tbody id="re_title">
		                  <tr>
		                     <th scope="row">댓글작성자</th>
		                     <th scope="row">댓글내용</th>
		                     <th scope="row">댓글작성일</th>
		                  </tr>
		               </tbody>
		               
		               <tbody class="re_body">
		                  <tr><!-- 댓글 부분--></tr>
		               </tbody>
		            </table>
				</div>
				<div class="paging_area"  id="noticeRv"> </div>&nbsp;
            	<input type="text"  id="qnaRv" style="height: 28px; width: 400px;">
	            <a href="" class="btnType blue" id="btnReplySave" name="btn" ><span>작성</span></a>
            	<a href="" class="btnType blue" id="btnReplyUpdate" name="btn"><span>수정</span></a>
           	 	<a href="" class="btnType gray" id="btnReplyDelete" name="btn"><span>삭제</span></a>
			</dd>
		</dl>
		<a href="" class="closePop" id="closeReplyPop"><span class="hidden">닫기</span></a>
   </div>
	<!--// 모달팝업 -->
</form>
</body>
</html>