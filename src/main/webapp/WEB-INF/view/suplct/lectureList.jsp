<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title></title>
<style>
#same_time_check{
	     border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            margin-right:-4px;
                 border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;    
            margin-left:10px;
		 border: 1px solid skyblue;
            background-color: rgba(0,0,0,0);
            color: skyblue;
            padding: 5px;
	}
#same_time_check:hover{
		       color:white;
            background-color: skyblue;
	}

</style>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- 20230710 17h 08m 커밋용 주석 !!!!!-->


<script type="text/javascript">

	//[관리자] 강의 목록 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
	
	//[학생] 강의 목록 페이징 설정
 	var sTypePageSize = 10;
	var sTypePageBlockSize = 5;     
	
	//[관리자] 수강 학생  목록 페이징
	var pageSizeAttendee = 5;
	var pageBlockSizeAttendee= 5; 
	
	/** OnLoad event */ 
	$(function() {
		
		// 사용자 목록   User_type : M
		// combo box 종류  usr : 제품 전체   조회 대상 테이블  tb_userinfo   
		selectComCombo("usr","T","lec_prof","all","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "" 
		
		comcombo("room_no", "room_no", "all","");
		
		selectComCombo("test","","test_no","all",""); 
		
		selectComCombo("survey","","sv_no","all",""); 
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_lecturelist();
		
		sameButtonClickEvent(); //중복체크 버튼등록

	});
	
	/*콘솔*/
	function fn_console(event) {
		console.log('btn clicked!');
	}
	
	
	/** 버튼 이벤트 등록 */

	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearch' :
					fn_lecturelist();
					break;
				case 'btnAddLecture':
					fn_lectureAdd();
					break;	
				case 'btnSave' : 
					fn_save();
					break;
				case 'btnDelete' :
					$("#action").val("D");	
					fn_save();
					break;	
				case 'btnClose' :
					gfCloseModal();
					break;	
				case 'btnLecAprov"':
					
					break;
				case 'btnSignIn' : 
					fn_registercourse();
					break;	
				case 'btnSignWithdraw' : 
					fn_cancel();
					break;			
			}
		});
	}
	
	
	/*[관리자]강의 목록 */
	function fn_lecturelist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
		
		  	searchKey : $("#searchKey").val()
		  , 	sname : $("#sname").val()
		  , pageSize : pageSize
		  , sTypePageSize: sTypePageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcallabck = function(returnvalue) {
			console.log(returnvalue);
			
			$("#lecturenotice").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			
			
			var uType = '<%=(String)session.getAttribute("userType")%>';
			 var uid = '<%=(String)session.getAttribute("loginId")%>';
			 console.log("uType & id= "+ uType +","+uid);
			 
			if(uType == 'S'){
				
				console.log(" 학생 uType : "  +uType);
				console.log(" 학생 sTypePageSize : "  +sTypePageSize);
				var paginationHtml = getPaginationHtml(pagenum, totalcnt, sTypePageSize, pageBlockSize, 'fn_lecturelist');
				console.log("paginationHtml : " + paginationHtml);
				
				
				$("#lecturePagination").empty().append( paginationHtml );
				
				$("#pageno").val(pagenum);
				
				
			} else  { /* (uType == 'M' ||uType == 'T' ) */  
				
				console.log(" uType : "  +uType);
				var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageBlockSize, pageBlockSize, 'fn_lecturelist');
				console.log("paginationHtml : " + paginationHtml);
				
				
				$("#lecturePagination").empty().append( paginationHtml );
				
				$("#pageno").val(pagenum);
				
				
			} 
			
			
			
			
		}
		
		callAjax("/suplct/lectureList.do", "post", "text", false, param, listcallabck) ;
			
	}
	
	

	
	
	/*[관리자]*/
	function fn_listlecclick(lec_no) {
		
		$("#lec_no").val(lec_no);
		
		fn_attendeeList();
	}
	
	
	/*[관리자]수강 학생 리스트 뿌리기 */
 	function fn_attendeeList(stuPageNo) {
 		
		stuPageNo = stuPageNo || 1;
		
		
		var param = {
				lec_no : $("#lec_no").val()
			,	stuPageNo : stuPageNo
			,	pageSize : pageSizeAttendee
		}
		
		 var attListCallback = function(returnvalue) {
				console.log(returnvalue);
				
				$("#s_stuinfoList").empty().append(returnvalue);
				
				var  totalcnt = $("#stutotalcnt").val();
				
				console.log("totalcnt : " + totalcnt);
				
				var paginationHtml = getPaginationHtml(stuPageNo, totalcnt, pageSizeAttendee, pageBlockSizeAttendee, 'fn_attendeeList');
				console.log("paginationHtml : " + paginationHtml);
				 
				$("#stuPagination").empty().append( paginationHtml );
				
				$("#stuPageNo").val(stuPageNo);
			}
		
		callAjax("/suplct/lectureAttendee.do", "post", "text", true, param, attListCallback);
		
 	}
	
	
	/*[관리자]강의 등록*/
	function fn_lectureAdd(e) {
		popupinit();
		
		// 모달팝업
		gfModalPop("#layer1")
		console.log("Lecutre add btn clicked!"+e);
	}
	
	
	/*[관리자]팝업창 (Insert & Update)*/
	 function popupinit(object) {
			
			if(object == "" || object == null || object == undefined) {
				
				$("#lec_prof").prop('disabled',false);
			
				$("#lec_name").val("");		
				$("#max_no").val("");
				$("#lec_start").val("");
				$("#lec_end").val("");
				$("#lec_prof").val("");
				//선생님일 경우에는 lec_prof가 고정되어야함.
				var uType = '<%=(String)session.getAttribute("userType")%>';
				 var uid = '<%=(String)session.getAttribute("loginId")%>';
				 console.log("선생님 이름= "+ uType +","+uid);
				 
				if(uType == 'T'){
					$("#lec_prof").val(uid);
				
					
					$("#lec_prof").prop('disabled',true);
				}
				
				
				
				
				$("#sv_no").val("");
				$("#test_no").val("");
				$("#room_no").val("");
				$("#survey_list").val("");
				$("#test_list").val("");
				$("#previewdiv").empty();
				
				//추가.
				$("#lec_no").val("");  //hidden값 초기화
				$("#lec_stime").val("0"); //강의시작시간  
				$("#lec_etime").val("0");  
				$("input:checkbox[name='checkyoil']").attr("checked", false);
				$("#sameTimecheck").val("0"); //중복체크 초기화
				
				
				$("#btnDelete").hide();
				 
				$("#action").val("I");	
			} else {
				
				$("#lec_prof").prop('disabled',false);
			
				$("#sameTimecheck").val("0"); //중복체크 초기화
				$("#lec_name").val(object.lec_name);		
				$("#max_no").val(object.max_no);
				$("#sv_no").val(object.sv_no);
				$("#test_no").val(object.test_no);
				$("#lec_start").val(object.lec_start);
				$("#lec_end").val(object.lec_end);
				$("#lec_prof").val(object.lec_prof);
				
				//선생님일 경우에는 lec_prof가 고정되어야함.
				var uType = '<%=(String)session.getAttribute("userType")%>';
				 var uid = '<%=(String)session.getAttribute("loginId")%>';
				 console.log("선생님 이름= "+ uType +","+uid);
				 
				if(uType == 'T'){
					$("#lec_prof").val(uid);				
					
					$("#lec_prof").prop('disabled',true);

				}
				
				
				$("#room_no").val(object.room_no);
				$("#lec_no").val(object.lec_no); //선택한 번호 히든 태그에서 받아와서 백업 받는것![★]
				
				
				$("#lec_stime").val(object.startTime);
				$("#lec_etime").val(object.endTime);
				$("#acc_yn").val(object.acc_yn); //이부분은 학생일때만!!
				$("input:checkbox[name='checkyoil']").attr("checked", false); //일단모두 uncheck
				var strData = object.yoil;
				console.log(strData);
				if(strData !=null){
				var arrDay = strData.split(',');
			
				  for (var nArrCnt in arrDay) {

	                    $("input[name=checkyoil][value="+arrDay[nArrCnt]+"]").prop("checked",true);

	  				  } 
				}
				
				
				
				
				
				
				$("#upfile").val("");
				
				
				  var inserthtml = "<a href='javascript:fn_filedownload()'>";
		            
		            if(object.file_name == "" || object.file_name == null || object.file_name == undefined) {
		               inserthtml += "";
		            } else {
		               var selfile = object.file_name;
		                var selfilearr = selfile.split(".");
		                var lastindex = selfilearr.length - 1;
		                if(selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpge" || selfilearr[lastindex].toLowerCase() == "png") {
		                     inserthtml += "<img src='" + object.file_logic_path + "' style='width:100px; height:80px' />";
		                } else {
		                     inserthtml += object.file_name;
		                }            
		            } 
		            

		            inserthtml += "</a>"
		            
		            $("#previewdiv").empty().append(inserthtml);
		            
		            
		            $("#btnDelete").show();
		            
		            $("#action").val("U");   
			}
		}
	
	
	/*[관리자]저장*/
	 function fn_save() {
			 $("#lec_prof").prop('disabled',false);
			if ( ! fn_Validate() ) {
				return;
			}
		    if($("#action").val() == "D"){
	            if(confirm("정말 삭제하시겠습니까?")){
	               $("#sameTimecheck").val("1")
	               
	            }
	            else{
	               return;
	            }         
	         }
		    
		    
		    
			var frm = document.getElementById("myForm");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			console.log(fileData);
			
			var yoil = [];
			 $("input[name='checkyoil']:checked").each(function() {
			  
			  var tmpVal = $(this).val();
				
			    console.log(tmpVal);
			    yoil.push(tmpVal);
			   
			   
			  });
			 console.log("yoil=="+ yoil);
			 fileData.append('checkyoils',yoil);

			var savecallback = function(reval) {
				console.log( JSON.stringify(reval) );
				
				if(reval.returncval > 0) {
					alert("저장 되었습니다.");
					gfCloseModal();
					
					if($("#action").val() == "U") {
						fn_lecturelist($("#pageno").val());
					} else {
						fn_lecturelist();
					}
				}  else {
					alert("오류가 발생 되었습니다.");				
				}
			}
			

			 callAjaxFileUploadSetFormData("/suplct/lectureSave.do", "post", "json", true, fileData , savecallback) ; 
		}
		
	 /*[공통] 강의 목록 삭제 */
		function fn_lecDel(lec_no,lecDel_yn){
			console.log("삭제하고자 하는 강의 번호 : "+"");
			
			var param = {
					lec_no : lec_no
					, lecDel_yn: lecDel_yn
			}
			console.log(JSON.stringify(param),param);
			
			var rsCallBack = function(data){
				/* fn_save(data); */
				confirm("삭제하시겠습니까?");
				fn_lecturelist($("#pageno").val());
				alert("삭제 완료!");
			};
		
			callAjax("/suplct/delLec.do","post","json","true",param, rsCallBack);
			
		}
	
	
	/*[관리자]강의 계획서 유효성 체크(빈값 확인)*/
		function fn_Validate() {

			var chk = checkNotEmpty(
					[
							[ "lec_name", "강의명을 입력해주세요." ]
						,	[ "max_no", "최대인원을 입력해 주세요" ]
						,   [ "lec_prof", "강사명을 선택해 주세요" ]	
						,	[ "lec_room", "강의실을 입력해 주세요" ]
						,	[ "lec_start", "시작일자를 입력해 주세요" ]
						,	[ "lec_end", "종료일자를 입력해 주세요" ] 
						,	[ "test_no", "시험문제를 선택해 주세요" ] 
						,	[ "sv_no", "설문 문제를 선택해 주세요" ] 
							 
					]
			);

			if (!chk) {
				return;
			}

			return true;
		} 
		
	/*[관리자]하나 선택*/
	function fn_selectOne(lec_no){
		
		var param = {
				 lec_no : lec_no
				
		}
		
		var selectOneCallBack = function(returndata){
			console.log(JSON.stringify(returndata));
			
		 	popupinit(returndata.lecturesearch); 
		
		// 모달 팝업
		gfModalPop("#layer1");
		
		
		}
		callAjax("/suplct/lectureSelectOne.do","post","json",false,param,selectOneCallBack);	
		
	}
	
	/*[관리자]저장 파일 미리보기*/
 	function preview(event){
	
		var image = event.target;
		console.log("------ image------ ",image);
		 
		if(image.files[0]){
			//alert(window.URL.createObjectURL(image.files[0]));
			
			var selfile = image.files[0].name;
			/* console.log(selfile); */
	 		var selfilearr = selfile.split(".");
			insertHTML = "";
			var lastindex = selfilearr.length - 1;


			if(selfilearr[lastindex].toLowerCase() =="jpg" || selfilearr[lastindex].toLowerCase() =="png" || selfilearr[lastindex].toLowerCase() =="jpeg" || selfilearr[lastindex].toLowerCase()=="gif"){
				insertHTML =  "<img src='" + window.URL.createObjectURL(image.files[0]) + "' style='width:80px; height:80px' />";
				console.log(insertHTML);
			} else {
				insertHTML = selfile;
				console.log(insertHTML);
			}
			  alert(window.URL.createObjectURL(image.files[0]));
			$("#previewdiv").empty().append(insertHTML);
		
		}
	} 

	
	/*[관리자]*/
 	function fn_filedownload() {
 		
		alert("다운로드");
		
		var params = "";
		params += "<input type='hidden' name='lec_no' id='lec_no' value='"+ $("#lec_no").val() +"' />";
		
		jQuery("<form action='/suplct/downloadLectureFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
 	}
	
 	/** 관리자 학생 승인 */
	function fn_mastoStuLecSingInApprov(loginID,lec_no,acc_yn){
		
		
		var param = {
				lec_no : lec_no
				,loginID: loginID
			    ,acc_yn: acc_yn
			    
		}
		
		console.log(JSON.stringify(param),param);
		
		var rsCallBack = function(data){
			
			fn_lecturelist($("#pageno").val());
			alert("승인상태 변경 완료.");
			fn_attendeeList($("#pageno").val());
			
			
		};
	
		callAjax("/suplct/stuSignInApprove.do","post","json","true",param, rsCallBack); 
	  }
	 
	 //********************제출일마감일 datepicker**************************//
	    $(function(){
	       $("#lec_start").datepicker({
	         /*     showOn:  'button'
	                  , buttonImage: 'resources/images/icon2.png'  
	                , buttonImageOnly: true */
	                showOn: "both"
	                   , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	                       ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	                       ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트      
	                    , dateFormat : 'yy-mm-dd'
	       });
	       $("#lec_end").datepicker({
	          showOn: "both"
	                , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	                    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	                    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트      
	                    , dateFormat : 'yy-mm-dd'
	       });
	       
	        $('#lec_start').datepicker("option", "maxDate", $("#lec_end").val());
	          $('#lec_start').datepicker("option", "onClose", function (selectedDate){
	              $("#lec_end").datepicker( "option", "minDate", selectedDate );
	              });
	          
	     
	          $('#lec_end').datepicker("option", "minDate", $("#lec_start").val());
	          $('#lec_end').datepicker("option", "onClose", function (selectedDate){
	              $("#sdate").datepicker( "option", "maxDate", selectedDate );
	             });  
	          
	          $('#lec_start').datepicker('setDate', 'today');
	          $('#lec_end').datepicker('setDate', '+1D');


	          $('img.ui-datepicker-trigger').attr('align', 'absmiddle');
	    })
	    

	    /*[학생] 강의 상세 계획서 */
	    function fn_selectOneDtInfo(lec_no){
		
		var param = {
				 lec_no : lec_no
				
		}
		
		var dtInfoCallBack = function(returndata){

			console.log(JSON.stringify(returndata));
			/* console.log(JSON.stringify(returndata.lecDtInfo)); */
		 	  popupinit2(returndata.lecDtInfo); 
		
		// 모달 팝업
		gfModalPop("#lecDtModal");
		
		
		}
		callAjax("/suplct/selectOneDtInfo.do","post","json",false,param,dtInfoCallBack);	
		
	}
	
	 
	 /*[학생] 상세계획서 팝업 init */
	    function popupinit2(object) {
		 
		 
			console.log("hi!")	;
		
		
			if(object == "" || object == null || object == undefined) {
				$("#lec_name").val("");	
				$("#test_start").val("");
				$("#test_no").val("");
				$("#lec_start").val("");
				$("#lec_end").val("");
				$("#lec_starttime").val("");
				$("#lec_endtime").val("");
				$("#name").val("");
				$("#rm_name").val("");
				$("#user_email").val("");
				$("#user_hp").val("");
				$("#lec_goal").val("");
				$("#lec_contents").val("");
				$("#max_no").val("");
				
				$("#lec_no").val("");  //hidden값 초기화
				$("#lec_stime").val("0"); //강의시작시간  
				$("#lec_etime").val("0");  
				$("input:checkbox[name='checkyoil']").attr("checked", false);
				$("#courseEqTimeChk").val("0"); //수강신청 중복체크 초기화
				
				$("#previewdiv").empty();
				
				
				$("#btnDelete").hide();
				 
				$("#action").val("I");	
				
			} else {
				console.log("값이 있음.");
				$("#lec_name").text(object.lec_name);	
				$("#test_start").text(object.test_start);	
				$("#test_no").text(object.test_no);
				$("#lec_start").text(object.lec_start);
				$("#lec_end").text(object.lec_end);
				$("#lec_starttime").text(object.lec_starttime);
				$("#lec_endtime").text(object.lec_endtime);
				$("#name").text(object.name);
				$("#rm_name").text(object.rm_name);
				$("#user_email").text(object.user_email);
				$("#user_hp").text(object.user_hp);
				$("#lec_goal").text(object.lec_goal);
				$("#lec_contents").text(object.lec_contents);
				$("#max_no").text(object.max_no);
				$("#lec_no").val(object.lec_no);  //선택한 번호 히든 태그에서 받아와서 백업 받는것![★]
				
				$("#lec_stime").val(object.startTime);
				$("#lec_etime").val(object.endTime);
				$("#acc_yn").val(object.acc_yn); //이부분은 학생일때만!!
				
				$("#lec_stime").attr('disabled',true);
				$("#lec_etime").attr('disabled',true);
				
				$("input:checkbox[name='checkyoil']").attr("checked", false); //일단모두 uncheck
				var strData = object.yoil;
				console.log(strData);
				if(strData !=null){
				var arrDay = strData.split(',');
			
				  for (var nArrCnt in arrDay) {

	                    $("input[name=checkyoil][value="+arrDay[nArrCnt]+"]").prop("checked",true);

	  				  } 
				}
				
				
				if(object.acc_yn == "P" || object.acc_yn == "Y"){
					$("#btnSignIn").hide();
					$("#btnSignWithdraw").show();
				} else if( object.acc_yn == null || object.acc_yn == "C" || object.acc_yn == "N"){
					$("#btnSignIn").show();
					$("#btnSignWithdraw").hide();
				}
				
				
				$("#upfile").val("");
				
				
				var inserthtml = "<a href='javascript:fn_filedownload()'>";
				
				if(object.file_name == "" || object.file_name == null || object.file_name == undefined) {
					inserthtml += "";
				} else {
					var selfile = object.file_name;
				    var selfilearr = selfile.split(".");
				    var lastindex = selfilearr.length - 1;
				    if(selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpeg" || selfilearr[lastindex].toLowerCase() == "png") {
				    	  inserthtml += "<img src='" + object.file_logic_path + "' style='width:100px; height:80px' />";
				    } else {
				    	  inserthtml += object.file_name;
				    }				
				} 
				

				inserthtml += "</a>"
				
				$("#previewdiv").empty().append(inserthtml);
				
				
				$("#btnDelete").show();
				
				$("#action").val("U");	
			}
		}
	
	 
		  /*중복 체크 버튼*/
		  function sameButtonClickEvent(){ //중복체크 버튼
		$("#same_time_check").click(function(e){
			/* if ( ! fn_ValidateSameCheck() ) {
				return;
			} */
			var yoil = [];
			  $("input[name='checkyoil']:checked").each(function() {
				  
				  var tmpVal = $(this).val();
					
				    console.log(tmpVal);
				    yoil.push(tmpVal);
				   
				  });
				console.log(yoil);
				
			if(yoil.length == 0){
				alert("요일을 선택해주세요");
				return;
			}
			  
			var param = {
					room_no : $("#room_no").val(),
					lec_start : $("#lec_start").val(),
					lec_end : $("#lec_end").val(),
					lec_stime : $("#lec_stime").val(),
					lec_etime : $("#lec_etime").val(),
					"checkyoil" : yoil,
					lec_no : $("#lec_no").val()
			}
			
			$.ajax({
				url : '/suplct/sameTimeChecking.do',
				type : 'post',
				data : param, //data로 뭐가 넘어가는건지??
				dataType : 'json',
				async : true,
				success : function(param) {
					if($("#registerId").val()==""){
						console.log("입력 아이디 없음");
						swal("아이디를 입력해주세요.").then(function(){
							$("#registerId").focus();
						});
						$("#ckIdcheckreg").val("0");
					}
					 else if (param>=1){
						console.log("예약 있음");
						swal("이미 강의실에 배정된 시간입니다.").then(function(){
							$("#registerId").focus();
						});
						console.log(param);
						$("#sameTimecheck").val("0");
					
					} else if(param == 0){
						console.log("예약 없음");
						swal("사용할 수 있는 시간입니다.");
						$("#sameTimecheck").val("1");
					}
						else if(param == -1){
						console.log("아이디 없음");
						swal("시간을 다시 선택해주세요 .");
						$("#sameTimecheck").val("0");
					}
						else if(param == -2){
						console.log("강의실 선택X");
						swal("강의실을 선택해주세요 .");
						$("#sameTimecheck").val("0");		
							
					}
						else if(param == -3){
							console.log("요일선택X");
							swal("요일을 선택해주세요.");
							$("#sameTimecheck").val("0");		
								
					}
						else if(param == -4){
							console.log("날짜선택X");
							swal("강의일자를 선택해주세요.");
							$("#sameTimecheck").val("0");		
								
					}
						else if(param == -5){
							console.log("시작날짜>마지막날짜.");
							swal("시작날짜와 종료날짜를 다시 설정해주세요.");
							$("#sameTimecheck").val("0");		
								
					}
						else if(param == -6){
							console.log("미사용강의실.");
							swal("사용하지않는 강의실입니다. 다른강의실을 선택해주세요.");
							$("#sameTimecheck").val("0");		
								
					}
						
								
					
				}
			
			
			})//ajax끝
		 	  
		})//클릭 버튼이벤트 끝
		  }//함수끝
		  
		  // 수강신청 버튼 -수강신청중복검사
		function fn_registercourse(lec_no){
			  // alert("수강신청버튼이 클릭되었다.");
			 // alert("학생의 수강상태 == " +$("#acc_yn").val());
			  //alert($("#lec_no").val());
			  //지금 그 신청한 강의가~ 신청된 강의랑 중복이 되는지 체크하기.
			  //param lec_no로 넣고~ select one해와서 
			
			  if($("#acc_yn").val() == 'N'){
				  swal("반려당한 강의입니다.");
				  return;
			  }
			  
			  
			 var param = {				
					lec_no : $("#lec_no").val(),
					acc_yn : $("#acc_yn").val()
			}
			  
			  
			 $.ajax({
					url : '/suplct/enrollSameTimeChecking.do',
					type : 'post',
					data : param, 
					dataType : 'json',
					async : true,
					success : function(param) {
						if($("#registerId").val()==""){
							console.log("입력 아이디 없음");
							swal("아이디를 입력해주세요.").then(function(){
								$("#registerId").focus();
							});
							$("#ckIdcheckreg").val("0");
						}
						 else if (param>=1){
							console.log("예약 있음");
							swal("이미 수강신청에 배정된 시간입니다.").then(function(){
								$("#registerId").focus();
							});
							console.log(param);
							$("#courseEqTimeChk").val("0");
						
						} else if(param == 0){
							console.log("예약 없음");
							//swal("사용할 수 있는 시간입니다.");
							$("#courseEqTimeChk").val("1");
							//수강신청 로직..함수
							fn_registRequest($("#lec_no").val());
							
						}
							else if(param == -1){
							console.log("아이디 없음");
							swal("시간을 다시 선택해주세요 .");
							$("#courseEqTimeChk").val("0");
						}
							else if(param == -2){
							console.log("강의실 선택X");
							swal("강의실을 선택해주세요 .");
							$("#courseEqTimeChk").val("0");		
								
						} else if(param == -3){
							console.log("요일X");
							swal("요일이 배정되지않은 강의입니다.");
							$("#courseEqTimeChk").val("0");		
								
						}
						 else if(param == -4){
								console.log("이미 반려당함");
								swal("반려당한 강의입니다.");
								$("#courseEqTimeChk").val("0");		
									
							}
						 else if(param == -5){
								console.log("이미 강의가 종료함");
								swal("종료한 강의입니다.");
								$("#courseEqTimeChk").val("0");		
									
							}	
						 else if(param == -6){
								console.log("강의시간이 배정안됨.");
								swal("강의시간이 없는 강의입니다.");
								$("#courseEqTimeChk").val("0");		
									
							}	
							
						
					}
				
				
				})//ajax끝
			  
			  
		  }
		  
		  //수강 신청 버튼- 중복통과시 학생의 수강을 저장
		  function 	fn_registRequest(lec_no){
			 // alert("tb_request_list에 등록하기+++ "+ lec_no);
			  if(parseInt($("#courseEqTimeChk").val())==0){
				  swal("중복된 시간입니다. 다른강의를 선택해주세요.");
				  return;
			  }
			  
				 var param = {				
							lec_no : lec_no
					}
				 
					var savecallback = function(reval) {
						console.log("fn_save == action ~");
						console.log( JSON.stringify(reval) );
						
						if(reval.returncval > 0) {
							
							gfCloseModal();
							
							if($("#action").val() == "U") {
								fn_lecturelist($("#pageno").val());
								alert("저장 되었습니다.");
							} else{
								fn_lecturelist();
							}
							
						}  else {
							alert("오류가 발생 되었습니다.");				
						}
					}
					
				 
				callAjax("/suplct/registerCourse.do","post","json",false,param,savecallback);	
				 
		  }
		  
		  //수강취소
	function fn_cancel(){
		var uid = '<%=(String)session.getAttribute("loginId")%>';	
		
		var result = confirm('취소하시겠습니까?');
		
		if (result){
			var param = { 
					loginID : uid
					,lec_no : $("#lec_no").val()
					,acc_yn : 'C'
					}
			
			var cancelcallback = function(reval) {
				console.log(JSON.stringify(reval));
				console.log(reval.returnvalue);
				
				if(reval.returnvalue == -3){
					swal("강의가 시작되어서 취소하지못합니다.");
					
				}else{
					alert("취소되었습니다.");
					fn_lecturelist();
					gfCloseModal();
		
				}
				
			};			
						
			callAjax("/supmya/cancelmylecture.do", "post", "json", false, param , cancelcallback) ;
		}else{
			alert("오류가 발생했습니다.")
		}	
		
	} 
	  
</script>

</head>
<body>
<!--※ 관리자일 경우  -->
<c:choose>
	<c:when test="${sessionScope.userType =='M'}">
	<form id="myForm" action=""  method="">
		<input type="hidden" id="action"  name="action"  />
		<input type="hidden" id="lec_no"  name="lec_no"  />
		<input type="hidden" id="pageno"  name="pageno"  />
		<input type="hidden" id="stuPageNo"  name="stuPageNo"  />
		<input type="hidden" name="sameTimecheck" id="sameTimecheck" value="0"/>	

	
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
									class="btn_nav bold">학습 관리</span> <span class="btn_nav bold">강의 목록
									</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">강의관리</a>
							</p>
	
							<p class="conTitle">
								<span>강의 목록</span> <span class="fr"> 
								 <select id="searchKey" name="searchKey" style="width: 150px;" >
								        <option value="">전체</option>
								        <option value="subject" >과목</option>
										<option value="prof_nm" >강사명</option>
								</select> 
								<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
								<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
								<a href="javascript:fn_lectureAdd()" class="btnType blue" id="btnAddLecture" name="btn"><span>과정 등록</span></a>
								</span>
							</p>
							
							<div class="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="33%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
										<col width="10%">
										<col width="11%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">강사명</th>
											<th scope="col">강의시작일</th>
											<th scope="col">강의종료일</th>
											<th scope="col">신청인원</th>
											<th scope="col">정원</th>
											<th scope="col">수정/삭제</th>
										</tr>
									</thead>
									<tbody id="lecturenotice"></tbody>
								</table>
							</div>
		
							<div class="paging_area"  id="lecturePagination"> </div>
							
							<!-- 학생정보 -->
							<p class="conTitle" style="margin-top: 30px;">
								<span>수강생 목록</span> <span class="fr"> </span>
							</p>
							
							
							<div class="studentList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">아이디</th>
											<th scope="col">학생명</th>
											<th scope="col">과정명</th>
											<th scope="col">승인 상태</th>
											<th scope="col">승인 여부</th>
										</tr>
									</thead>
									<tbody id="s_stuinfoList"></tbody>
								</table>
							</div>
		
							<div class="paging_area"  id="stuPagination"> </div>
							
	                     
						</div> <!--// content -->
	
						<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	
		 <!-- 모달팝업 강의 등록 --> 
		<div id="layer1" class="layerPop layerType2" style="width: 800px;">
			<dl>
				<dt>
					<strong>강의 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row" >
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							
						</colgroup>
	
						<tbody >
							<tr>
								<th scope="row">강의명  <span class="font_red">*</span></th>
								<td colspan="15"><input type="text" class="inputTxt p100" name="lec_name" id="lec_name" /></td>
							</tr>
							<tr>
								<th scope="row">최대인원<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="max_no" id="max_no"   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="숫자만 입력하세요."/>
								</td>
							</tr>
							<tr>
								<th scope="row">강사명<span class="font_red">*</span></th>
								<td colspan="15">
									<select id="lec_prof" name="lec_prof" ></select>
								</td>
							</tr>
							<tr>
								<th scope="row">강의실<span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="room_no" name="room_no"></select>
								     <input type="button" id="same_time_check" value="중복체크"/>
								</td>
							</tr>
							<tr>
								<th scope="row">시작일자<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="lec_start" id="lec_start"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;">종료일자<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="lec_end" id="lec_end"/>
								</td>
							</tr>
								<tr>
								<th scope="row" style="width: 300px;">강의시간<span class="font_red">*</span></th>
								<td colspan="15">
								   <select id="lec_stime" name="lec_stime" style="width: 100px"  >
									<option value="0" selected>-시작시간-</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
				
								</select>
								~
									<select id="lec_etime" name="lec_etime" style="width: 100px" >
									<option value="0" selected>-종료시간 -</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
									
									<option value="18">18:00</option>
				
								</select>
								
								</td>
							</tr>
							<tr>
								<th scope="row">강의요일 <span class="font_red">*</span></th>
								<td colspan="15">
								   <input type="checkbox" name="checkyoil" value="월"/><font size="2">월</font> &nbsp;
								   <input type="checkbox"  name="checkyoil" value="화"/><font size="2">화</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="수"/><font size="2">수</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="목"/><font size="2">목</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="금"/><font size="2">금</font>
								</td>
							</tr>
							<tr>
								<th scope="row">시험 문제 <span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="test_no" name="test_no" ></select> 
								</td>
							</tr>
							<tr>
								<th scope="row">설문 문제 <span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="sv_no" name="sv_no" ></select> 
								</td>
							</tr>
							<tr>
								<th scope="row">강의계획서  <span class="font_red">*</span></th>
								<td colspan="7">
								    <input  type="file" id="upfile"  name="upfile"  onchange="javascript:preview(event)" onclick="javascript:fn_console();"/>
								</td>
								<td colspan=8>
								      <div id="previewdiv" >미리보기</div>
								</td>
							</tr>
					
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn" onclick="javascript:fn_console(event)"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDelete" name="btn" onclick="javascript:fn_console(event)"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	
	

	</form>
	</c:when>
</c:choose>

<!--※ 학생일 경우  -->
<c:choose>
	<c:when test="${sessionScope.userType =='S'}">
	<form id="myForm" action=""  method="">
		<input type="hidden" id="action"  name="action"  />
		<input type="hidden" id="lec_no"  name="lec_no"  />
		<input type="hidden" id="pageno"  name="pageno"  />
		<input type="hidden" id="stuPageNo"  name="stuPageNo"  />
		<input type="hidden" id="courseEqTimeChk"  name="courseEqTimeChk"  />
		<input type="hidden" id="acc_yn"  name="acc_yn"  />

	
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
								 <span class="btn_nav bold">학습 관리</span> <span class="btn_nav bold">강의 목록</span> 
								<a href="../system/comnCodMgr.do" class="btn_set refresh">강의 목록</a>
							</p>
	
							<p class="conTitle">
								<span>강의 목록</span> <span class="fr"> 
									 <select id="searchKey" name="searchKey" style="width: 150px;" >
									        <option value="">전체</option>
									        <option value="subject" >과목</option>
											<option value="prof_nm" >강사명</option>
									</select> 
									<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
									<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
								</span>
							</p>
							
							<div class="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="33%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
										<col width="10%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">강사명</th>
											<th scope="col">강의시작일</th>
											<th scope="col">강의종료일</th>
											<th scope="col">신청인원</th>
											<th scope="col">정원</th>
										</tr>
									</thead>
									<tbody id="lecturenotice"></tbody>
								</table>
							</div>
		
							<div class="paging_area"  id="lecturePagination"> </div>
			</div><!--// content -->	
			<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>	
	
	   <!--학생 조회 전용  강의 상세계획서 모달 팝업 -->
			 <div id="lecDtModal" class="layerPop layerType2" style="width:750px;">
				<dl>
					<dt>
						<strong>강의 계획서 </strong>
					</dt>
					<dd class="content">
		
						<!-- s : 여기에 내용입력 -->
		
							<table class="row"  style="margin-top:30px;">
							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">강의명 <span class="font_red">*</span></th>
									<td colspan="14">
										<span id="lec_name"  ></span>
									</td>
								</tr>
								<tr>
									<th scope="row">시험 일자<span class="font_red">*</span></th>
									<td colspan="14">
										<span class="inputTxt p100"  name="test_start"  id="test_start" ></span>
									</td>
								</tr>
								<tr>
									<th scope="row">시작 일자<span class="font_red">*</span></th>
									<td colspan="5">
										<span class="inputTxt p100"  name="lec_start" id="lec_start"></span>
									</td>
									<th scope="row">종료 일자<span class="font_red">*</span></th>
									<td colspan="8">
										<span class="inputTxt p100"  name="lec_end" id="lec_end"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">시작 시간<span class="font_red">*</span></th>
									<td colspan="5">
										<span class="inputTxt p100"  name="lec_start" id="lec_starttime" ></span>
									</td>
									<th scope="row">종료 시간<span class="font_red">*</span></th>
									<td colspan="8">
										<span class="inputTxt p100"  name="lec_end" id="lec_endtime"></span>
									</td>
								</tr>
								 <tr>
									<th scope="row">강사명<span class="font_red">*</span></th>
									<td colspan="5">
										<span class="inputTxt p100"  name="name" id="name"></span>
									</td>
									<th scope="row">강의실<span class="font_red">*</span></th>
									<td colspan="8">
										<span class="inputTxt p100"  name="rm_name" id="rm_name"></span>
								
									</td>
								</tr>
									 <tr>
									<th scope="row">강의시간<span class="font_red">*</span></th>
									<td colspan="5">
									     <select id="lec_stime" name="lec_stime" style="width: 77px"  >
									<option value="0" selected>-시작시간-</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
				
								</select>
								~
									<select id="lec_etime" name="lec_etime" style="width: 77px" >
									<option value="0" selected>-종료시간 -</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
									
									<option value="18">18:00</option>
				
								</select>
									</td>
									<th scope="row">강의요일<span class="font_red">*</span></th>
									<td colspan="8">
									      <input type="checkbox" name="checkyoil" value="월"/><font size="2">월</font> &nbsp;
								   <input type="checkbox"  name="checkyoil" value="화"/><font size="2">화</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="수"/><font size="2">수</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="목"/><font size="2">목</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="금"/><font size="2">금</font>
									</td>
								</tr>
								<tr>
									<th scope="row">이메일<span class="font_red">*</span></th>
									<td colspan="5">
										<span class="inputTxt p100"  name="user_email" id="user_email"></span>
									</td>
									<th scope="row">연락처<span class="font_red">*</span></th>
									<td colspan="8">
										<span class="inputTxt p100"  name="user_hp" id="user_hp" ></span>
									</td>
								</tr>
								<tr>
									<th scope="row">수업목표<span class="font_red">*</span></th>
									<td colspan="14">
										<span id="lec_goal" name="lec_goal"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">강의 내용 <span class="font_red">*</span></th>
									<td colspan="14" style="overflow:auto">
										<span id="lec_contents" name="lec_contents"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">첨부파일 <span class="font_red"></span></th>
									<td colspan="14">
										<span type="file" id="upfile"  name="upfile"  onchange="javascript:preview(event)" onclick="javascript:fn_console();"></span>
											<div id="previewdiv" >미리보기</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="" style="padding:30px 0px 5px 0px; display:flex; justify-content:center;">
							<a style="margin-right:15px;" href="" class="btnType blue" id="btnSignIn" name="btn"><span>신청</span></a>
							<a style="margin-left:10px; margin-right:10px;" href="" class="btnType blue" id="btnSignWithdraw" name="btn"><span>취소</span></a>
							<a href="" class="btnType blue" id="btnClose" name="btn"><span>닫기</span></a>  
						</div>
					</dd>
				</dl>
				<a href="" class="closePop"><span class="hidden">닫기</span></a>
			</div> 
		<!--학생 조회 전용  강의 상세계획서 모달 팝업 --> 
	</form>
	</c:when>
</c:choose>



<!--※ 강사일 경우  -->
<c:choose>
	<c:when test="${sessionScope.userType =='T'}">
	<form id="myForm" action=""  method="">
		<input type="hidden" id="action"  name="action"  />
		<input type="hidden" id="lec_no"  name="lec_no"  />
		<input type="hidden" id="pageno"  name="pageno"  />
		<input type="hidden" id="stuPageNo"  name="stuPageNo"  />
		<input type="hidden" name="sameTimecheck" id="sameTimecheck" value="0"/>	

	
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
									class="btn_nav bold">학습 관리</span> <span class="btn_nav bold"> 강의 목록
									</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">강의관리</a>
							</p>
	
							<p class="conTitle">
								<span>강의 목록</span> <span class="fr"> 
								 <select id="searchKey" name="searchKey" style="width: 150px;" >
								        <option value="">전체</option>
								        <option value="subject" >과목</option>
										<!-- <option value="prof_nm" >강사명</option> -->
								</select> 
								<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
								<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
								<a href="javascript:fn_lectureAdd()" class="btnType blue" id="btnAddLecture" name="btn"><span>과정 등록</span></a>
								</span>
							</p>
							
							<div class="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="33%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
										<col width="10%">
										<col width="11%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">강사명</th>
											<th scope="col">강의시작일</th>
											<th scope="col">강의종료일</th>
											<th scope="col">신청인원</th>
											<th scope="col">정원</th>
											<th scope="col">수정/삭제</th>
										</tr>
									</thead>
									<tbody id="lecturenotice"></tbody>
								</table>
							</div>
		
							<div class="paging_area"  id="lecturePagination"> </div>
							
							
							<!-- 학생정보 -->
							<p class="conTitle" style="margin-top: 30px;">
								<span>수강생 정보</span> <span class="fr"> </span>
							</p>
							
							
							<div class="studentList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%"> 
										<col width="15%">
										<col width="12%">
										<col width="19%">
									    <col width="19%">
									    <col width="10%">
									    <col width="10%">
									    
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">과정명</th>
											<th scope="col">아이디</th>
											<th scope="col">학생명</th>
										    <th scope="col">생년월일</th>
										    <th scope="col">연락처</th>
											<th scope="col">점수</th>
										    <th scope="col">승인여부</th>  
										</tr>
									</thead>
									<tbody id="s_stuinfoList"></tbody>
								</table>
							</div>
		
							<div class="paging_area"  id="stuPagination"> </div>
							
	                     
						</div> <!--// content -->
	
						<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	
		 <!-- 모달팝업 강의 등록 --> 
		<div id="layer1" class="layerPop layerType2" style="width: 800px;">
			<dl>
				<dt>
					<strong>강의 관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row" >
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							
						</colgroup>
	
						<tbody >
							<tr>
								<th scope="row">강의명  <span class="font_red">*</span></th>
								<td colspan="15"><input type="text" class="inputTxt p100" name="lec_name" id="lec_name" /></td>
							</tr>
							<tr>
								<th scope="row">최대인원<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="max_no" id="max_no"   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="숫자만 입력하세요."/>
								</td>
							</tr>
							<tr>
								<th scope="row">강사명<span class="font_red">*</span></th>
								<td colspan="15">
										<select id="lec_prof" name="lec_prof" ></select>
								</td>
							</tr>
							<tr>
								<th scope="row">강의실<span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="room_no" name="room_no"></select>
								      <input type="button" id="same_time_check" value="중복체크"/>
								</td>
							</tr>
							<tr>
								<th scope="row">시작일자<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="lec_start" id="lec_start"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;">종료일자<span class="font_red">*</span></th>
								<td colspan="15">
								    <input type="text" class="inputTxt p100"  name="lec_end" id="lec_end"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;">강의시간<span class="font_red">*</span></th>
								<td colspan="15">
								   <select id="lec_stime" name="lec_stime" style="width: 100px"  >
									<option value="0" selected>-시작시간-</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
				
								</select>
								~
									<select id="lec_etime" name="lec_etime" style="width: 100px" >
									<option value="0" selected>-종료시간 -</option>
									<option value="9">09:00</option>
				
									<option value="10">10:00</option>
								
									<option value="11">11:00</option>
								
									<option value="12">12:00</option>
								
									<option value="13">13:00</option>
								
									<option value="14">14:00</option>
								
									<option value="15">15:00</option>
								
									<option value="16">16:00</option>
								
									<option value="17">17:00</option>
									
									<option value="18">18:00</option>
				
								</select>
								
								</td>
							</tr>
							<tr>
								<th scope="row">강의요일 <span class="font_red">*</span></th>
								<td colspan="15">
								   <input type="checkbox" name="checkyoil" value="월"/><font size="2">월</font> &nbsp;
								   <input type="checkbox"  name="checkyoil" value="화"/><font size="2">화</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="수"/><font size="2">수</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="목"/><font size="2">목</font>&nbsp;
								   <input type="checkbox"  name="checkyoil" value="금"/><font size="2">금</font>
								</td>
							</tr>
							<tr>
								<th scope="row">시험 문제 <span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="test_no" name="test_no" ></select>
								</td>
							</tr>
							<tr>
								<th scope="row">설문 문제 <span class="font_red">*</span></th>
								<td colspan="15">
								    <select id="sv_no" name="sv_no" ></select>
								</td>
							</tr>
							<tr>
								<th scope="row">강의계획서  <span class="font_red">*</span></th>
								<td colspan="7">
								    <input  type="file" id="upfile"  name="upfile"  onchange="javascript:preview(event)" onclick="javascript:fn_console();"/>
								</td>
								<td colspan=8>
								      <div id="previewdiv" >미리보기</div>
								</td>
							</tr>
					
						</tbody>
					</table>
	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn" onclick="javascript:fn_console(event)"><span>저장</span></a> 
						<a href="" class="btnType blue" id="btnDelete" name="btn" onclick="javascript:fn_console(event)"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	
	
	</form>
	</c:when>
</c:choose>

	
</body>
</html>