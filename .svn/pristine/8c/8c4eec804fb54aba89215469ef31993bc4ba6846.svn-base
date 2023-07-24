<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의실 관리</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


 
<script type="text/javascript">
	/** 페이지 설정 */
    var pageSize = 5;
    var pageBlockSize = 5;
    
    var pageSizeitem = 5;
    var pageBlockSizeitem = 5;
    
   
    
    /** onload event */
    $(function(){
    	fRegisterButtonClickEvent();
    
    	fn_roomlist(); 	
    	
	});

    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_roomlist();
					break;
				case 'btnSave' :
					fn_save();
					break;
				case 'btnDelete' :
					$("#action").val("D")
					fn_save();
					break;				
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}  
	
	
	function fn_roomlist(pagenum){
		
		pagenum = pagenum || 1;
		
		var param ={
				searchKey : $("#searchKey").val()
				, sname : $("#sname").val()
				, rm_yn : $("#rm_yn").val()
				, pageSize : pageSize
				, pageBlockSize : pageBlockSize
				, pagenum : pagenum
				
		}
		var listcallback = function(returnvalue) {
			console.log(returnvalue);

			$("#listroom").empty().append(returnvalue);

			var  totalcnt = $("#totalcnt").val();

			console.log("totalcnt : " + totalcnt);

			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_roomlist');
			console.log("paginationHtml : " + paginationHtml);

			$("#roomPagination").empty().append( paginationHtml );

			$("#pageno").val(pagenum);
		}

		callAjax("/admrmd/roomlist.do", "post", "text", false, param, listcallback) ;
		
		
	}
	
	function fn_openpopup() {

		popupinit();

		// 모달 팝업
		gfModalPop("#layer1");


	}
	
	
	
	function popupinit(object) {
		
		if(object == "" || object == null || object == undefined) {
			$("#rm_name").val("");
			$("#rm_max").val("");
			$("#rm_size").val("");
			$("#enr_user").val("");
			$("#enr_date").val("");
			$("#rm_yn").val("");
			$("#room_no").val("");
			
			
			$("#btnDelete").hide();

			$("#action").val("I");
		} else {
			$("#rm_name").val(object.rm_name);
			$("#rm_max").val(object.rm_max);
			$("#rm_size").val(object.rm_size);
			$("#enr_user").val(object.enr_user);
			$("#enr_date").val(object.enr_date);
			$("input:radio[name='rm_avail']:radio[value='Y']").prop('checked', true); //선택하기
			$("#room_no").val(object.room_no);
			
			
			$("#btnDelete").hide();

			$("#action").val("U");
		
		}
		
	}
	
	function fn_selectone(no) {
		var param = {
				room_no : no
		}
		var selectonecallback = function(returndata) {
			console.log("좋은 말로 할 때 해라 진짜" + JSON.stringify(returndata) );

			popupinit(returndata.roomsearch);

			// 모달 팝업
			gfModalPop("#layer1");

		}

		callAjax("/admrmd/selectoneroom.do", "post", "json", false, param, selectonecallback) ;

	}
	
	
	
	function fn_save() {

		if ( ! fn_Validate() ) {
			return;
		}

		var param = {
				action : $("#action").val(),
				room_no : $("#room_no").val(),
				rm_name : $("#rm_name").val(),
				rm_max : $("#rm_max").val(),
				rm_size : $("#rm_size").val(),
				enr_user1 : '${loginId}',
				enr_date : $("#enr_date").val(),
				rm_avail : $(':radio[name="rm_avail"]:checked').val()
				
		}
		console.log("fn_save_param : " + JSON.stringify(param)) ;

		 var savecallback = function(reval) {
			console.log( JSON.stringify(reval) );

			if(reval.returnval > 0) {
				alert("완료 되었습니다.");
				gfCloseModal();

				if($("#action").val() == "U") {
					fn_roomlist($("#pageno").val());
				} else {
					fn_roomlist();
				}
			}  else {
				alert("오류가 발생 되었습니다.");
			}
		}

		callAjax("/admrmd/roomsave.do", "post", "json", false, param , savecallback) ;

	}
	
	

	
	function fn_Validate() {

		var chk = checkNotEmpty(
				[
						[ "rm_name", "강의실 이름을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	function fn_itemlistsearch(currentPage, LL_room_no) {
			$("#room_no_E").val(LL_room_no);
			fn_itemlist(currentPage);
			
		}
	
	
	
	function fn_itemlist(currentPage){
			
		currentPage = currentPage || 1;
			var param ={
					  room_no : $("#room_no_E").val()
					, pageSize : pageSizeitem
					, currentPage : currentPage
					
			}
			var itemlistcallback = function(returnvalue) {
				itemlistresult(returnvalue,currentPage);
			};
	
			callAjax("/admrmd/itemlist.do", "post", "text", false, param, itemlistcallback) ;
		
		
	}
	
	
	
	function itemlistresult(returnvalue,currentPage) {
		
		$("#listitem").empty().append(returnvalue);

		var  totalcount = $("#totalcount").val();		
		var paginationHtml = getPaginationHtml(currentPage, totalcount, pageSizeitem, pageBlockSizeitem, 'fn_itemlist');
	
		$("#itemPagination").empty().append( paginationHtml );
		$("#currentPageitem").val(currentPage);
	}
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////	
	function fn_openpopupuse() {
        popupinitfile();

		// 모달 팝업
		gfModalPop("#layer2");
	}
	
	
	
	
	function popupinituse(object) {
		
		if(object == "" || object == null || object == undefined) {
			$("#lec_no").val("");
			$("#lec_name").val("");
			$("#lec_start").val("");
			$("#lec_end").val("");
			$("#room_no").val("");
			$("#btnDelete").hide();

			$("#action").val("I");
		} else {
			$("#lec_no").val(object.lec_no);
			$("#lec_name").val(object.lec_name);
			$("#lec_start").val(object.lec_start);
			$("#lec_end").val(object.lec_end);
			$("#room_no").val(object.room_no);
			$("#btnDelete").show();

			$("#action").val("U");
		}
		
	}
	
	
	
	function fn_usability(no) {

		//alert(no);

		var param = {
			room_no : no
		}

		var selectonecallback = function(returndata) {
			console.log( JSON.stringify(returndata) );

			popupinituse(returndata.lecview);

			// 모달 팝업
			gfModalPop("#layer2");

		}

		callAjax("/admrmd/usability.do", "post", "json", false, param, selectonecallback) ;

	}
	
		

</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" id="action"  name="action"  />
    <input type="hidden" id="pageno"  name="pageno"  />
	<input type="hidden" id="room_no"  name="room_no"  />
	<input type="hidden" id="room_no_E"  name="room_no_E"  />
	<input type="hidden" id="currentPageitem"  name="currentPageitem" value="1" />
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
							<span class="btn_nav bold">행정관리</span> 
							<span class="btn_nav bold">강의실 관리</span> 
							<a href="../admrmd/room.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의실 관리</span> 
							<span class="fr">
							  <select id="rm_yn"  name="rm_yn" style="width: 80px;">
							            <option value="" >전체</option>
							    		<option value="Y" >사용</option>
							    		<option value="N" >미사용</option>
							     </select>  
							     
							  <select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
							            <option value="" >전체</option>
							            <option value="name" >강의실 명</option>
							    		<option value="capacity" >허용인원</option>
							     </select>
							     <input type="text" style="width: 130px; height: 28px;" id="sname" name="sname">                    
	                              <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							     <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
    
						</p>
						
						<div class="roomList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									
									<!-- 예약 구현 시 사용 -->
									<%-- <col width="18%">
									<col width="17%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="15%"> --%>
									
									<col width="19%">
									<col width="14%">
									<col width="13%">
									<col width="13%">
									<col width="18%">
									<col width="13%">
									<col width="13%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의실 명</th>
										<th scope="col">허용인원</th>
										<th scope="col">크기</th>
										
										
										<th scope="col">작성자</th>
										<th scope="col">작성 일자</th>
										
										<th scope="col">사용여부</th>
									<!-- 예약 구현 시 사용 -->
										<!-- <th scope="col">수정/예약</th> -->
										<th scope="col">수정</th>
									</tr>
								</thead>
								<tbody id="listroom"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="roomPagination"> </div>
						
                       
                       


					 <!-- 장비내역 -->
					<div class="itemlilst" id="itemlilst" style="padding-top:30px;">
						
						<p class="conTitle">
							<span>강의실 장비 목록</span>
						</p>
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="50%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">장비명</th>
									<th scope="col">수량</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody id="listitem"></tbody>
						</table>
						<div class="paging_area" id="itemPagination"></div>
					</div>

                         

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</div>






	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">

		<dl>
			<dt>
				<strong>강의실 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의실 명<span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="rm_name" id="rm_name" /></td>
						</tr>
						<tr>
							<th scope="row">허용인원 </th>
							<td><input type="text" class="inputTxt p100" name="rm_max" id="rm_max" /></td>
							<th scope="row">크기 </th>
							<td><input type="text" class="inputTxt p100" name="rm_size" id="rm_size" /></td>
							
							
						</tr>
				
						<tr>
							<th scope="row">사용 여부</th>
							<td colspan="3">
							   <input type="radio" 	name="rm_avail" id="rm_avail_y" value='Y' /> <label for="radio1-1">사용</label>
								<input type="radio" name="rm_avail" id="rm_avail_n" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
				    <input type="hidden" name="Action" id="Action" value="">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
	  <div id="usability">
		<dl>
			<dt>
				<strong>강의실 관리</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
					<tr>
							<th scope="row">강의번호 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="lec_no" name="lec_no" v-model="lec_no" /></td>
							<th scope="row">강의명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="lec_name" name="lec_name" v-model="lec_name" /></td>
						</tr>
						<tr>
							<th scope="row">강의시작시간 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="lec_start" name="lec_start" v-model="lec_start"  /></td>
							<th scope="row">강의종료시간 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_cod_nm" name="lec_end" v-model="lec_end"  /></td>
						</tr>
						
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
   </div>
</form>
</body>
</html>