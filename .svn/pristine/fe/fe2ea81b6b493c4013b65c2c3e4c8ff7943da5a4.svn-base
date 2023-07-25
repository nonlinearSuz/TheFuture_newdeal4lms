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
	var pageSize = 10;     
	var pageBlockSize = 5;    
	
	
	
	/** OnLoad event */ 
	$(function() {
		
		comcombo("room_no", "room_no", "all","");
		fRegisterButtonClickEvent();
		fn_noticelist();
		
	});
	


	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_noticelist();
					break;
				case 'btnSave' :
					fn_save();
					break;	
				case 'btnDelete' :
					$("#action").val("D");	
					fn_save();
					break;	
				case 'btnDeleteFile' :
					$("#action").val("D");	
					fn_savefile();
					break;		
				case 'btnSaveFile' :
					fn_savefile();
					break;	
				case 'btnClose' :
				case 'btnCloseFile' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	function fn_noticelist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			sname : $("#sname").val()
		  ,	searchKey : $("#searchKey").val()
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcollabck = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listnotice").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_noticelist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#noticePagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/admmtd/resourcelist.do", "post", "text", false, param, listcollabck) ;
			
	}
	
	
	
	
	
	
	
	
	function fn_openpopup() {
		
		popupinit();

		gfModalPop("#layer1");
	}
	
	
	function popupinit(object) {
		
		if(object == "" || object == null || object == undefined) {
		    $("#item_no").val("");
			$("#item_nm").val("");		
			$("#item_vol").val("");
			$("#item_etc").val("");
			$("#room_no").val("");
				
			$("#btnDelete").hide();
			
			$("#action").val("I");	
		} else {
		    $("#item_no").val(object.item_no);
			$("#item_nm").val(object.item_nm);		
			$("#item_vol").val(object.item_vol);
			$("#item_etc").val(object.item_etc);
			$("#room_no").val(object.room_no);
			
			$("#btnDelete").show();
			
			$("#action").val("U");	
		}
	}
	
	
	
	// 한건 조회 
	
	
	function fn_selectone(no) {
		
	
		var param = {
				item_no : no
		}
		
		
				
		var selectoncallback = function(returndata) {	
			
			console.log( JSON.stringify(returndata) );
			
			popupinit(returndata.resourcesearch);

			gfModalPop("#layer1");
			
		}
		
		callAjax("/admmtd/resourceselectone.do", "post", "json", false, param, selectoncallback) ;
		
	}
	
	
	
	
	function fn_save() {
		
		if ( ! fn_Validate() ) {
			return;
		}
		
		var param = {
					action : $("#action").val(),
					item_no : $("#item_no").val(),
					item_nm :$("#item_nm").val(),	
					item_vol :$("#item_vol").val(),
					item_etc :$("#item_etc").val(),
					room_no :$("#room_no").val(),
					
		}
		
		var savecollback = function(reval) {
			console.log( JSON.stringify(reval));
			
						if(reval.returncval > 0) {
							alert("저장 되었습니다.");
							gfCloseModal();
							
							if($("#action").val() == "U") {
								fn_noticelist($("#pageno").val());
							} else {
								fn_noticelist();
							}
						}  else {
							alert("오류가 발생 되었습니다.");				
						}
					}
					
		callAjax("/admmtd/itemsave.do", "post", "json", false, $("#myForm").serialize() , savecollback) ;
		
	}
	
	function fn_Validate() {

		var chk = checkNotEmpty(
				[
						[ "item_nm", "장비명을 입력해 주세요." ]
					,	[ "item_vol", "수량을 입력해 주세요" ]
					,	[ "room_no", "강의실을 선택해 주세요" ]	
		      	]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	

	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="item_no"  name="item_no"  />
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
                                        <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
                                        <span class="btn_nav bold">행정 관리</span> <span class="btn_nav bold">장비 관리
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
                                    </p>


						<p class="conTitle">
							<span>장비 관리</span> <span class="fr"> 
							 <select id="searchKey" name="searchKey" style="width: 150px; " >
							        <option value="" >전체</option>
									<option value="lec" >강의실명</option>
									<option value="item" >장비명</option>
							</select> 
							<input type="text" style="width: 200px; height: 28px; " id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<div class="noticeList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
                                                <col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th colspan="4">장비 상세 목록</th>
									</tr>
									<tr>
	                            			 <th scope="col">강의실 명</th>
	                            			 <th scope="col">장비명</th>
                                             <th scope="col">갯수</th>
                                             <th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listnotice"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
						
                     
					</div> <!--// content -->


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
				<strong>장비 등록</strong>
			</dt>
                        <dd class="content">
                            <!-- s : 여기에 내용입력 -->
                            <table class="row">
                                <caption>caption</caption>

                                <tbody>
                                    <tr>
                                        <th scope="row">장비명</th>
                                        <td colspan="3"><input type="text" class="inputTxt p100" name="item_nm" id="item_nm" /></td>
                                    </tr>
                                     <tr>
                                        <th scope="row">갯수</th>
                                        <td colspan="3"><input type="text" class="inputTxt p100" name="item_vol" id="item_vol" 
                                         oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder = "숫자를 입력하세요."/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <th scope="row">강의실명</th>
                                        <td>
                                        <select id="room_no" name="room_no" style="width: 100%;" >                                        		
                                        </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">비고</th>
                                         <td colspan="3"><input type="text" class="inputTxt p100" name="item_etc" id="item_etc" /></td>       
                                    </tr>

                                </tbody>
                            </table>
                                        
                            <!-- e : 여기에 내용입력 -->

                            <div class="btn_areaC mt30">
                                <a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
                                <a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
                                <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
                            </div>
                        </dd>
                    </dl>
                    <a href="" class="closePop"><span class="hidden">닫기</span></a>
                </div>



</form>
</body>
</html>