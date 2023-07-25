<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시험 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	// 시험등록 페이징 설정
	var pageSizeTest = 5;
	var pageBlockSizeTest = 5;
	
	// 상세등록 페이징 설정
	var pageSizeQ = 5;
	var pageBlockSizeQ = 5;
	
	$(function() {
		
		 vueinit();
		 
		fn_ListExam();
		 		 
		 fRegisterButtonClickEvent();
		
		
		
	});

	
	function vueinit() {
			
		testlist = new Vue({
          	  el : "#testgrid",
         data : {
        	        listitem : [],
                    pagenav : "",
                    pageno:0
         },
         methods : {
        	 fn_ListTestDetail: function(test_no, test_name) {
                		 
        		 fn_ListTestDetail(test_no, test_name);
        		 
        	 },
        	 openModalExam: function(test_no) {
        		 
        		 openModalExam(test_no);
        		 
        	 },
        	 
         }
});
				
		
		layer1 = new Vue({
            el : "#layer1",
        data : {
        		  test_name : "",
    	          action : "",
           } 
});


}		
	
	
	function fn_ListExam(currentPage){
			
			currentPage = currentPage || 1;
			
			var sname = $('#sname');

			console.log("currentPage : " + currentPage);
			
			var param = {	
						sname : sname.val()
					,	currentPage : currentPage
					,	pageSize : pageSizeTest
					  , pageBlockSize : pageBlockSizeTest
			}
			
			var listCallback = function(returnvalue) {

				testlist.listitem =  returnvalue.stufileSearchList;
				
			var totalexam = returnvalue.totalexam;
				
			var paginationHtml = getPaginationHtml(currentPage, totalexam, pageSizeTest, pageBlockSizeTest, 'fn_ListExam');
			console.log("paginationHtml : " + paginationHtml);	
				
			testlist.pagenav = 	paginationHtml;
			
			testlist.pageno = currentPage;
				
			};

			callAjax("/exmexm/testlistvue.do", "post", "json", false, param, listCallback);
		}
	
	
	
	/** 시험 등록 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//swal(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listExam').empty();
		
		// 신규 목록 생성
		$("#listExam").append(data);
		
		// 총 개수 추출
		
		var totalexam = $("#totalexam").val();
		

		
		// 페이지 네비게이션 생성
		
	
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
		

		
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageComnGrpCod" value="1">
	<input type="hidden" id="currentPageComnDtlCod" value="1">
	<input type="hidden" id="examtest_no" name="examtest_no">
	<input type="hidden" id="examtest_name" name="examtest_name">
	<input type="hidden" id="test_no" name="test_no">
	<input type="hidden" id="dt_test_no" name="dt_test_no">

	<input type="hidden" name="action" id="action" value="">

	
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
								class="btn_nav bold">성적관리</span> <span class="btn_nav bold">시험관리</span>
								<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>시험 목록</span> <span class="fr">
							시험명
     	                       <input type="text" style="width: 150px; height: 25px;" id="sname" name="sname">                    
	                           <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
							
							<a class="btnType blue" href="javascript:openModalExam();" name="modal"><span>시험등록</span></a>
							</span>
						</p>
						
						<div class="testgrid">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="70%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">시험이름</th>
										<th scope="col">수정</th>
									</tr>
								</thead>
								<tbody id="listExam">
								   <template v-for="(list,index) in listitem"  v-if="listitem.length">
											<tr>
												<td>{{list.test_no}}</td>
												<td @click="fn_ListTestDetail(list.test_no,list.test_name)" >{{ list.test_name }}</td>
												<td @click="openModalExam(list.test_no)">
													<span>수정</span>
												</td>
											</tr>
									</template>
								</tbody>
							</table>
							<div class="paging_area"  id="testnav" v-html="testnav"> </div>
						</div>
	
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
                           
     	                  
                           </td> 
                           
                        </tr>
                     </table> 
                     
						<p class="conTitle mt50">
							<span>시험 문제 목록</span> <span class="fr"> <a
								class="btnType blue"  href="javascript:openModalTestDetail();" name="modal"><span>문제등록</span></a>
							</span>
						</p>
	
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">문제번호</th>
										<th scope="col">문제</th>
										<th scope="col">보기1</th>
										<th scope="col">보기2</th>
										<th scope="col">보기3</th>
										<th scope="col">보기4</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="listTestDetail">
									<tr>
										<td colspan="7">시험명을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="comnDtlCodPagination"> </div>

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
				<strong>시험 등록</strong>
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
							<th scope="row">시험명</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="test_name" id="test_name" /></td>
						</tr>
				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveExam" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteExam" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseExam" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
	
<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>문제 등록</strong>
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
							<th scope="row"><input type="hidden" id="que_no" name="que_no">시험명</th>
							
							<td colspan="3"><input type="text" class="inputTxt p100" name="dt_test_name" id="dt_test_name" /></td>
						</tr>
						<tr>
							<th scope="row">문제</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="que_content" id="que_content" /></td>
						</tr>
						<tr>
							<th scope="row">보기1</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="opt_1" id="opt_1" /></td>
						</tr>
						<tr>
							<th scope="row">보기2</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="opt_2" id="opt_2" /></td>
						</tr>
						<tr>
							<th scope="row">보기3</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="opt_3" id="opt_3" /></td>
						</tr>
						<tr>
							<th scope="row">보기4</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="opt_4" id="opt_4" /></td>
						</tr>
						<tr>
							<th scope="row">정답</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="answer" id="answer"     oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                        placeholder = "보기 번호를 숫자로만 입력하세요." /></td>
						</tr>
						<tr>
							<th scope="row">배점</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="score" id="score"     oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                        placeholder = "숫자로 입력하세요." /></td>
						</tr>
						
					
						
				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveQ" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteQ" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseQ" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!--// 모달팝업 -->
</form>
</body>
</html>