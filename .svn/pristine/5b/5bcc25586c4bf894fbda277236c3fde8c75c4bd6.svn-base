<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Q&A</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	var pageSize = 10;  
	var pageBlockSize = 5;    
	
	$(function() {	
		
 		comcombo("category_name","category_name","all","");
		comcombo("category_name","category_namepopup","all","");
		comcombo("category_name","category_namepopup2","all","");
		
		// 버튼 이벤트 등록
		ButtonClickEvent();
		
		qnaList();
		
	});
	
	function ButtonClickEvent() {
		$('a[id=closePop]').click(function(e) {
			e.preventDefault();
			
			var closeId = $(this).attr('id');
			
			switch(closeId) {
			case 'closePop' :
				qnaList();
				break;
			}
		});
		
		$('a[id=closeReplyPop]').click(function(e) {
			e.preventDefault();
			
			var closeRpId = $(this).attr('id');
			
			switch(closeRpId) {
			case 'closeReplyPop' :
				qnaList();
				break;
			}
		});
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault(); 

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					qnaList();
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
					qnaList();
					break;
					
			}
		});
		
	} 
	
	function qnaList(pagenum) {
		
		pagenum = pagenum || 1;
		
			var param = { 
				categoryName : $("#category_name").val()
			  ,	searchKey : $("#searchKey").val()
			  , sname : $("#sname").val()
			  , pageSize : pageSize
			  , pageBlockSize : pageBlockSize
			  , pagenum : pagenum
			}
		
		var listcollabck = function(returnvalue) {
			console.log(returnvalue);
	
			$("#listQna").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'qnaList');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#noticePagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/cmmqna/qnalist.do", "post", "text", false, param, listcollabck) ;
			
	}
	
	function fn_openpopup() {
		
		popupinit(); 
		
		// 모달 팝업
		gfModalPop("#layer1");
	
	}
	
	function popupinit(object) {
		
		if(object == "" || object == null || object == undefined) {
			$("#qna_no").val("");
			$("#qna_title").val("");
			$("#category_no").val("");
			$("#category_namepopup").val("");
			$("#category_name").val("");
			$("#qna_contents").val("");

			$("#btnSave").show();
			$("#btnUpdate").hide();
			$("#btnDelete").hide();
			$("#btnReply").hide();
			
			$("#action").val("I");	
		} else { 
			$("#qna_no").val(object.qna_no);
			$("#qna_title").val(object.qna_title);
			$("#title").val(object.qna_title);
			$("#category_no").val(object.category_no);
			$("#qna_contents").val(object.qna_contents);
			$("#qna_contentsTo").val(object.qna_contents); 
			
			$("#btnSave").hide();
			
			$("action").val("U");
		}
	}
	
	// 한건 조회
	function fn_selectone(no ,category_namepopup) {
		
		var param = {
				category_no : category_namepopup
			,	qna_no : no
		}
		
		console.log("fn_selectone_param" + JSON.stringify(param));
		
		var selectoncallback = function(returndata) {
			console.log("=====selectonecallback===== returndata");
			console.log(returndata);
			console.log(JSON.stringify(param));
			
			$("#action").val("U");
			$("#qna_no").val(no);
			$("#rpy_no").val();
			$("#reaction").val("I");
			
			$("#layer2").empty().append(returndata);
			
			console.log("category_namepopup : " + category_namepopup);
			console.log("no : " + no);
			
			comcombo("category_name","category_namepopup2","all",category_namepopup.trim());
			// 모달 팝업
			gfModalPop("#layer2");
			
		}
		
		callAjax("/cmmqna/detailQnaList.do", "post", "text", false, param, selectoncallback) ;
		
	}
	
	// 수정 버튼(상세 정보)
 	function fn_saves(no) {

 		$("#action").val("U");
		$("#qna_no").val(no);
		fn_save();
	}
	
	//글 삭제
	function fn_saved(no) {
		$("#qna_no").val(no);
		$("#action").val("D");
		fn_save();
	}
	
	// 글 등록 
	function fn_save() {
		
		if ( ! fn_Validate() ) {
			return;
		} 
	
		var param = {
				action : $("#action").val(), 
				qna_no : $("#qna_no").val(),
				qna_title : $("#qna_title").val(), //글 제목
 				title : $("#title").val(),
				category_no : $("#category_namepopup").val(), // 숫자 1
				category_name : $("#category_name").val(),
				qna_contents : $("#qna_contents").val(), //글 내용
				qna_contentsTo : $("#qna_contentsTo").val(), //글 내용
				enr_user : '${loginId}'
		}
		
		console.log("fn_save_param" + JSON.stringify(param));
		
		var savecollback = function(reval) {
			console.log( JSON.stringify(reval) );
			
			if(reval.returnval > 0) {
				alert("수행 되었습니다.");
				gfCloseModal();
				
				if($("#action").val() == "U") {
					qnaList($("#pageno").val());
				} else {
					qnaList();
				} 
				
			}  else {
				alert("오류가 발생 되었습니다.");				
			}
			
		}

		callAjax("/cmmqna/qnaSave.do", "post", "json", false, param , savecollback) ; 
		
	}
	
 	//댓글 등록
 	function fn_reply() {
		if(!fn_rV()) {
			return;
		}
 		var rpy_no = $("#rpy_no").val();
 		
 		var param = {
 				reaction : $("#reaction").val(),
 				rpy_no : $("#rpy_no").val(),
 				qna_no : $("#qna_no").val(),
				category_no : $("#category_namepopup2").val(), // 숫자 1
				category_name : $("#category_name").val(),
				rpy_content : $("#rpy_content").val(),
 				rpy_contents : $("#rpy_contents" + rpy_no).val(),
 				enr_user : '${loginId}'
 		}
 		
 		var resultCallback = function(data) {
 			console.log(JSON.stringify(data));
 			
 			if(data.returnval > 0) {
 				
 				if($("#reaction").val() == "U") {
 					alert("수정되었습니다.")
 					gfModalPop("#layer2");
 				} else if($("#reaction").val() == "I"){
 					alert("작성되었습니다.");
 					qnaList();
 					gfCloseModal();
 				} else {
 					gfCloseModal();
 				}
 			} else {
 				alert("오류 발생");
 			}
 		}
 		
 		callAjax("/cmmqna/insertQnaRp.do", "post", "json", false, param, resultCallback);
 	}
 	
 	function fn_replyes(rpy_no) {
 		$("#rpy_no").val(rpy_no);
 		$("#reaction").val("U");
 		fn_reply();
 	}
 	
 	function fn_replyed(rpy_no) {
 		$("#rpy_no").val(rpy_no);
 		$("#reaction").val("D");
 		fn_reply();
 	}
	
	// 유효성 검사
	function fn_Validate() {
		var action = $("#action").val();
		
		if(action === "I") {
	 		var chk = checkNotEmpty(
					[		
					 		["qna_title", "제목을 입력해 주세요."]
					 	,	["qna_contents", "내용을 입력해 주세요"]	
					]
			); 
	 		
	 		if(!chk) {
	 			return;
	 		}
		}

 		if(action === "U") {
 	 		var chking = checkNotEmpty(
 	 	 			[
 	 	 			 		["title", "제목을 입력해주세요!"]
 	 	 			 	,	["qna_contentsTo", "내용을 입력해주세요!"]
 	 	 			 ]	
 	 	 		);
 	 		
 	 		if(!chking) {
 	 			return;
 	 		}
 		}
 		
		return true;
	}
	
	function fn_rV() {
		var reaction = $("#reaction").val();
		
		if(reaction === "I") {
			var check = checkNotEmpty([
			  		 ["rpy_content", "글을 작성해주세요!"]                         
			  ]);
			
			if(!check) {
				return;
			}
		}
		
		return true;
	}
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="reaction"  name="reaction"  />
	<input type="hidden" id="qna_no"  name="qna_no"  />
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
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">Q&A
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>Q&A</span> <span class="fr">  
							 <select id="category_name" name="category_name" style="width: 150px;" >
 							        <option value="" >전체</option>
									<option value="1" >행정관련</option>
									<option value="2" >학습관련</option>
									<option value="3">기타</option> 
							</select>
							<select id="searchKey" name="searchKey" style="width: 150px;" >
									<option value="title" >글제목</option>
									<option value="cont" >글내용</option>
									<option value="writer">작성자</option>
							</select>
							<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>작성</span></a>
							</span>
						</p>		
						<div class="qnaList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="25%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">카테고리</th>
										<th scope="col">글제목</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>

									</tr>
								</thead>
								<tbody id="listQna"></tbody>
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
	
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>Q&A</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
                                 <col width="120px">
                                 <col width="70px">
                                 <col width="70px">
                                 <col width="*">
                                 <col width="90px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">글제목</th>
							<td colspan="5"><input type="text" class="inputTxt p100" name="qna_title" id="qna_title" /></td>
						</tr>
						<tr>
							<th scope="row">카테고리</th>
							<td>
								<select id="category_namepopup" name="category_namepopup"></select>
							</td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="5"  style="text-align: left;">
							    <textarea id="qna_contents" name="qna_contents"> </textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="javascript:fn_save();" class="btnType blue" id="btnSave" name="btn"><span>작성</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="closePop"><span class="hidden">닫기</span></a>
	</div>

   <div id="layer2" class="layerPop layerType2" style="width: 800px;">  
      
   </div>
</form>
</body>
</html>