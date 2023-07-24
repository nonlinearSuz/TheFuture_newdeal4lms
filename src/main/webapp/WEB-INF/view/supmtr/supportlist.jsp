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
		<!-- 주석!! -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>학습자료</title>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

</head>
<body>
<script type="text/javascript">


//페이징 설정
var pageSize = 10; //한페이지당 몇개씩 보여줄래
var pageBlockSize= 5; //페이지번호갯수 몇개까지 보여줄래 (page navigation번호)

	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;
	
	/** OnLoad event */ //html만 뿌려놓은상태
	$(function() {
		// 버튼 이벤트 등록 :나중에 가져와라;; 검색버튼 누르면!
		fRegisterButtonClickEvent();
		fn_setSelectBox();
		fn_studyFileList();
		//fn_noticeList();
	});
	
	
	function fn_setSelectBox(){
		//이미 세션에 user_id가있음, user_id가 가르치는 lec_no, lec_name을 가져오면된다.
		//alert('실행 되었습니다.fn_setSelectBox 설정하기');
		
		var param = {}
		//넘길값도 없다?? 이미세션에 id가있음;
		var selectcallback = function(returnvalue){
			
			console.log('select함수 실행하고 컨트롤러에서 컬백받는 value :'+ returnvalue);
			//앞으로 추가해줘야함 option에 넣을것들;;
			

			//tbody 영역 
			$("#leclist").empty().append(returnvalue);
			$("#lecselect").empty().append(returnvalue);
			
		}
		
		
		callAjax("/supmtr/selectList.do", "post", "text", false, param, selectcallback);
		

	}
	
	
	
	/** 버튼 이벤트 등록 */

	   //현재페이지를 reloading href="" 전체페이지리로딩
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) { //a태그 애들중, name인 btn을 클릭을하면
			e.preventDefault(); //전체페이지 reloading을 막기위해서.. a태그 href / from submit 버튼
//event 클릭했을당시 js정보 e
			var btnId = $(this).attr('id');
//클릭하고 들어온놈 = this   btnSearch // btnSearch3 의 id값을꺼내와라
			switch (btnId) {
				case 'btnSave' :
					fn_save();
					break;
				case 'btnDelete' :
					$("#action").val("D");
					fn_save();
					break;
				case 'btnDeleteFile':
					$("#action").val("D");
					fn_savefile();
					break;
				case 'btnUpdateFile':
					$("#action").val("U");
					fn_savefile();
					break;	
				case 'btnSaveFile' :
					fn_savefile();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnSearch':
					fn_studyFileList();
					break;
				case 'btnClose' :
					
				case 'btnCloseFile' :
					gfCloseModal();
					break;
			}
		});
	}
	   
	   
	   function fn_studyFileList(pageNum){
			
			pageNum = pageNum || 1; //undefined 이면 1값을 세팅해라.
			

			
		//	alert('실행 되었습니다.fn_studyFileList');

		//	alert('검색 optionvalue값: ' + $("#leclist").val()); //1
			var search_lec_no = $("#leclist").val();
			$("#lec_no").val(search_lec_no); //input type hidden값에 설정해둠 ==> 자료등록할때 같이 넘어가라고;
			

			
			var param = {
					lec_no : $("#leclist").val()		
				  , pageSize : pageSize
				  , pageBlockSize : pageBlockSize
				  , pageNum : pageNum
				}
		
			
			
			//callback 함수만들자. 함수형 변수  리턴받을 변수이름?
			var listcallback = function(returnvalue){
				//컨트롤러에서 리턴받는 데이터 (listgrd.jsp --> list.jsp)
				console.log('list함수 실행하고 컨트롤러에서 컬백받는 value :'+ returnvalue);
				
				$("#liststudyfile").empty().append(returnvalue); 
							//tbody 영역 
				
							
				var totalCnt = $("#totalCnt").val();
				console.log("totalCnt: "+ totalCnt);
				var currentLec_no = $("#lec_no").val();
				console.log("현재 강의넘버 : "+  currentLec_no);
							
					
				//페이지 네비게이션 getPaginationHtml 공통함수
				var paginationHtml = getPaginationHtml(pageNum, totalCnt, pageSize, pageBlockSize, 'fn_studyFileList');
				console.log("paginationHtml : " + paginationHtml);
				//swal(paginationHtml);
				$("#noticePagination").empty().append( paginationHtml );
				
				$("#pageno").val(pageNum); //현재보고있는 currentpage = pagenum
			}
			
			callAjax("/supmtr/studyfilelist.do", "post", "text", false, param, listcallback);
			
			
		}
		    
		
	////////////////////////////////////파일업로드//////////////////////////////////
	function fn_openpopupfile(){
		
		popupinitfile();
		//모달팝업
		
		 gfModalPop("#layer2");
	}
		
	function popupinitfile(object) {
		
		
		if(object == "" || object == null || object == undefined) {
			$("#study_file_title").val("");		//신규버튼 누를때 초기화
			$("#study_file_cont").val("");
			$("#notice_no").val("");
			$("#upfile").val("");	
			$("#enr_date").val("");
			$("#lecselect").val($("#leclist").val()); //내가 검색했던 과정에서 들어온것이다.
			
			$("#previewdiv").empty();// val("") 와의 차이
			
			$("#btnDeleteFile").hide(); //삭제버튼 숨김
			$("#btnUpdateFile").hide(); //삭제버튼 숨김
			$("#btnSaveFile").show();
			$("#action").val("I");	// action이라는 히든값 저장부를때 파라미터로 던진다.
		} else {
	
		 
			// alert("파일뿌려주기");
			console.log("파일뿌려주는 값: " + object);
			console.log( JSON.stringify(object) );
			
			$("#lecselect").val(object.lec_no);//과정명 select box설정해주기.
			$("#study_file_title").val(object.study_file_title);		 //값이 들어오는 경우 수정버튼
			$("#study_file_cont").val(object.study_file_cont);
			$("#study_file_no").val(object.study_file_no); //??
			$("#lec_no").val(object.lec_no); //?? selectbox에서 선택가능하게하던지.. 이게아니라 select one할떄필요한거?
			$("#enr_date").val(object.enr_date);
			$("#upfile").val("");		//upfile? ** 다시 파일선택창 초기화??
			
					//=======
							var inserthtml = "<a href='javascript:fn_filedownload()'>";
				
				if(object.file_name == "" || object.file_name == null || object.file_name == undefined) {
					inserthtml += "";
				} else {
					var selfile = object.file_name;
				    var selfilearr = selfile.split(".");
				    var lastindex = selfilearr.length - 1; //파일명에 .이 들어간 경우를 고려
				    if(selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpge" || selfilearr[lastindex].toLowerCase() == "png") {
				    	  inserthtml += "<img src='" + object.file_logic_path + "' style='width:100px; height:80px' />";
				    } else {
				    	  inserthtml += object.file_name;
				    	  //이미지파일이 아니면 파일이름만 넣는다.
				    }				
				} 
				

				inserthtml += "</a>"
				
				$("#previewdiv").empty().append(inserthtml); //미리보기
				$("#btnSaveFile").hide();
				$("#btnDeleteFile").show(); //삭제 및 수정버튼을 보여주고
				$("#btnUpdateFile").show();
				$("#action").val("U");	 //업데이트형태로 간다.
				//------------					
				var user_type_mtr = '<%=(String)session.getAttribute("userType")%>';
				console.log(user_type_mtr);
				if(user_type_mtr == 'S'){
				$("#btnDeleteFile").hide();
				$("#btnSaveFile").hide();
				$("#btnUpdateFile").hide();
				


				}
		
		
		}
		
		
		
		
	   }
	
	
	
	 //미리보기
	 function preview(event){
		 //dashboardMgr.jsp
		 var image = event.target; //change이미지바꿈. 타겟리턴 = file 태그자체를 리턴
		 
		 alert(image.files[0].name);
	

		 
		// //확장자가 찍히면된다.
		 
		 
		 if(image.files[0]){ //파일이 선택되었으면
			
			 //확장자 구하기
			 	var selfile = image.files[0].name;
			 	var selfilearr = selfile.split(".");
			 var inserthtml = "";
			 var lastindex = selfilearr.length -1; //파일명이 .이 들어간경우를 고려
			// alert(lastindex);
			 
			// alert(selfilearr[lastindex]); 
			 if(selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() =="png"){
				 //이경우는 이미지서비스이다.
				 inserthtml = "<img src='" + window.URL.createObjectURL(image.files[0]) + "'  style='width:100px; height:80px'/>"
					
			 } else{
				 //이미지파일이 아니면 파일 이름만 넣는다.
				 inserthtml = selfile;
			 }
			 
			 		 
			 
			// alert(window.URL.createObjectURL(image.files[0])); //window 브라우저 함수 파라미터로 파일넘겨주면 임시url을 만들어준다.
		 //	vuevar.inputtext = "asdf";
			 this.imgpath = window.URL.createObjectURL(image.files[0]);
			
		
			$("#previewdiv").empty().append(inserthtml);
			
		 }
		 
		 
	 }
	 
	 
	 
	 function fn_selectonefile(stufile_no, lec_number){
		 //alert(no);
		 //ajax controller
		 var param = {
			study_file_no : stufile_no
			,lec_no : lec_number
		 }
		 
		 var selectoncallback = function(returndata){
				console.log( JSON.stringify(returndata) );
				
				popupinitfile(returndata.stufileSearch);
				// 모달 팝업
				gfModalPop("#layer2");
			 
		 }
		 
		 callAjax("/supmtr/studyfileSelectOne.do", "post", "json", false, param, selectoncallback);
			//목록 text타입리턴타입 //나머지는 json리턴타입
		 
		 
	 }    
	 
	 
	 //등록
		function fn_savefile(){
			 if(!fn_Validate()){
				 return;
			 }
			 
		
			 var frm = document.getElementById("myForm");
			 frm.enctype = 'multipart/form-data';
			 var fileData = new FormData(frm); //파일정보까지 둘둘말아 던진다.
			 console.log(fileData);
			 
			 //콜백함수정의
			 var filesavecallback = function (returnval){
					 //반환값이 json
					console.log(JSON.stringify(returnval));
					 
					if(returnval.returnVal > 0) {
						alert("저장 되었습니다.");
						gfCloseModal();
						
						if($("#action").val() == "U") {
							fn_studyFileList($("#pageno").val());
						} else {
							fn_studyFileList();
						}
					}  else {
						alert("오류가 발생 되었습니다.");				
					}
					 
			 }
			 
			 
			 
			callAjaxFileUploadSetFormData("/supmtr/studyfileSaveFile.do", "post", "json", true, fileData, filesavecallback);

		 }
		function fn_Validate() {

			var chk = checkNotEmpty(
					[		
					 		[	"lecselect" , "과정명을 선택해주세요."	]
						,	[ "study_file_title", "제목을 입력해 주세요." ]
						,	[ "study_file_cont", "내용을 입력해 주세요" ]
					]
			);

			if (!chk) {
				return;
			}

			return true;
		}
	 
		 //파일 다운로드
		 function fn_filedownload(){
			 alert("다운로드");
			 
			 //공지사항번호 
			 //파일번호 히든값
			 
			 var params = "";
				params += "<input type='hidden' name='study_file_no' id='study_file_no' value='"+ $("#study_file_no").val() +"' />";
				params += "<input type='hidden' name='lec_no' id='lec_no' value='"+ $("#lec_no").val() +"' />";
				
				jQuery("<form action='/supmtr/downloadnoticefile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
				
		 	// params ==> notice_no hidden 들어감
		 
		 }

</script>



<form id="myForm" action=""  method="">

	<input type="hidden" id="action" name="action" />
 <input type="hidden" id="study_file_no"  name="study_file_no"  />
<input type="hidden" id="lec_no" name="lec_no"/> <!-- select box도 form데이터할때 같이 넘어간다. -->
	<input type="hidden" id="pageno"  name="pageno"  />
 <!-- 목록조회할떄 현재보고있는 페이지번호 -->

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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">학습자료
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침★</a>
						</p>
				
						<p class="conTitle">
							
	
							
							<span>학습 자료</span> <span class="fr">
													
			
							 <select id="leclist" name="leclist" style="width: 150px;" >						
						    		<option value="" >전체</option>				    									
							</select> 
							
	                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							<!-- 선생님일 경우에만 학습자료 등록가능 -->
							<c:choose>
    					<c:when test="${sessionScope.userType=='T'}">
        					 <a	 class="btnType blue" href="javascript:fn_openpopupfile();" name="modal"><span>학습 자료 등록 </span></a>
					
  						  </c:when>
							</c:choose>
						
							</span>
						</p>
			
						<div class="studyfileList">	
									
							<table class="col">
								<caption>스터디파일목록</caption>
								<colgroup>
									<col width="15%">
									<col width="10%">
									<col width="45%">
									<col width="30%">							
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">글번호</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>						
									</tr>
								</thead>
								<tbody id="liststudyfile"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
						
						
						
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                  
     	                     
                           </td> 
                           
                        </tr>
                     </table> 
                     
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
				<strong>그룹코드 관리</strong>
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
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="notice_title" id="notice_title" /></td>
									
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="notice_cont" id="notice_cont" /></td>					
						</tr>
				
				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학습 자료 </strong>
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
						<th scope="row">과정명 <span class="font_red">*</span></th>
							<td colspan="3"><select id="lecselect" name="lecselect" ></select></select></td>						
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="1.5"><input type="text" class="inputTxt p100"
								name="study_file_title" id="study_file_title" /></td>
							<th scope="row">등록일자 </th>
							<td colspan="1.5"><input type="text" class="inputTxt p100"
								name="enr_date" id="enr_date" disabled/></td>
						</tr>
						<tr>
							<th scope="row">자료 내용 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="study_file_cont" id="study_file_cont" /></td>					
						</tr>
						<tr>
							<th scope="row">파일업로드 <span class="font_red">*</span></th>
							<td  colspan="3"><input type="file" class="inputTxt p100"
								name="upfile" id="upfile" onchange="javascript:preview(event)" /></td>	
						
						</tr>
						<tr>
							<td colspan="4">
							<div id="previewdiv" ></div>
							</td> <!-- 이미지가있으면 미리보게하고, 파일업로드시 표시가능, 다운로드도 가능하게한다. -->				
						</tr>
				
				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveFile" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnUpdateFile" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDeleteFile" name="btn"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseFile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 -->
</form>



</body>
</html>