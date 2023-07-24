<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약 관리</title>

<!--주석 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<style>
	table{
	border-collapse: collapse;
		width:100%;
	}
	
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
	
	 #date_select{
	     border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            margin-right:4px;
                 border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;    
            margin-left:3px;
		 border: 1px solid skyblue;
            background-color: rgba(0,0,0,0);
            color: skyblue;
            padding: 5px;
	}
	#same_time_check:hover, #date_select:hover{
		       color:white;
            background-color: skyblue;
	}
	
	#color_select{
		 border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            margin-right:-4px;
                 border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;    
            margin-left:10px;
		 border: 1px solid plum;
            background-color: rgba(0,0,0,0);
           color: plum;
            padding: 5px;
	}
#color_select:hover{
		       color:white;
            background-color: plum;
	}
	
	//////////////////////////////////////////////////////////
	div{margin:0;}

.tab_wrap{
  overflow:hidden;
  width:1000px;
  margin:0 auto;
  border-bottom:1px solid #cdcdcd;
}
.tab_wrap input{
  display:none;
}
.tab_wrap label{
  display:block; float:left; width:33%; height:35px;
  text-align:center;  line-height:35px;
  border-right:1px dotted #cdcdcd;
  cursor:pointer;
}
.tab_wrap label.on{
  color:#fff;
 /* background-color: #2E9ACC;*/
   background-color:#e55646; 
}
.tab_content{
  display:none;
  width:1000px;
  height:300px;
  margin:0 auto;
  padding:5px 10px;
  box-sizing:border-box;
  background-color:#efefef;
}
.tab_content1{
  display:block;
}
	
	
</style>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>


//********************제출일마감일 datepicker**************************//

/** OnLoad event */ //html만 뿌려놓은상태
$(function() {
	// 버튼 이벤트 등록 
	fRegisterButtonClickEvent(); 
	
	
	fn_bookingList(); // 스터디룸~예약목록 자동생성
	fn_setSelectBox(); // 스터디룸 selectbox
	
	
	
	sameButtonClickEvent(); //중복체크버튼
	colorSelectEvent(); //색상선택버튼
	dateSelectEvent(); //날짜조회버튼
		
	fn_makeTable(); //처음 table그리는함수
	
		 $("#dateSelect").datepicker({
				
			 showOn: "both"
	    	   , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		    	    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		    	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트      
		    	    	, dateFormat : 'yy-mm-dd'
	});
	
	
	$('#dateSelect').datepicker('setDate', 'today');
	
	
	$("#booking_date").datepicker({ 	
				 showOn: "both"
		    	   , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			    	    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			    	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트      
			    	    ,minDate: 0
			    	    , dateFormat : 'yy-mm-dd'
	});
	
	
	$('#booking_date').datepicker('setDate', 'today');
	
	//달력 날짜 변경시 테이블함수 실행
	$("#dateSelect").change(function(){ 
	
	fn_makeTable($("#dateSelect").val());
	
	   })
	
	
});





function colorSelectEvent(){
	$("#color_select").click(function(e){
		console.log("옆에 팔레트를 눌러 색상을 선택하세요.");
		
		
	})
}


function sameButtonClickEvent(){ //중복체크 버튼
	$("#same_time_check").click(function(e){
	
		//유효성검사
		//1.시작시간 value값, 종료시간value값이 존재할것
		//2.시작시간은 종료시간보다 value값이 작아야한다.
	
		console.log($("#booking_stime option:selected").val());
		console.log($("#booking_etime option:selected").val());		
		console.log(nowpoint);
		
		var startTime = $("#booking_stime option:selected").val();
		var endTime = $("#booking_etime option:selected").val();
		
		
		var startpoint = $("#booking_date").val()+" "+ startTime+ ":00:00";
		console.log(startpoint);
		var date_np = new Date(nowpoint);
		var date_sp = new Date(startpoint);
		var dateval = (date_np.getTime() - date_sp.getTime()); //예약시간 11시 현재시간 12시
		console.log(date_np>date_sp);
		 if(date_np>date_sp){
			console.log("이미 시작시간이 지났습니다.");
			if(confirm("이미 시작시간이 지났습니다. 사용하시겠습니까?")){
				$("#booking_stime").focus();	//예를 누른경우.										
			} else{
				swal("다른시간을 선택해주세요.");  //아니오 누른경우
				$("#sameTimecheck").val("0");
			}
		}
		
		
		if(startTime == "" || startTime == null || endTime == "" || endTime == null){
			
			swal("시간을 입력해주세요.").then(function(){
				$("#booking_stime").focus();
				$("#sameTimecheck").val("0");

			});
			
		}
	
		if (parseInt(startTime)>=parseInt(endTime)){
			
			swal("시작시간은 종료시간보다 빨라야합니다.").then(function(){
				$("#booking_stime").focus();
				$("#sameTimecheck").val("0");

			});
		}
		
		var param = {
				room_no : $("#roomlist").val(),
				booking_date : $("#booking_date").val(),
				booking_stime : $("#booking_stime").val(),
				booking_etime : $("#booking_etime").val(),
				book_no : $("#book_no").val()
		}
		
	
			
		
		$.ajax({
			url : '/rsvrem/sameTimeChecking.do',
			type : 'post',
			data : param, //data로 뭐가 넘어가는건지??
			dataType : 'text',
			async : true,
			success : function(param) {
				console.log(param);
				if($("#registerId").val()==""){
					console.log("입력 아이디 없음");
					swal("아이디를 입력해주세요.").then(function(){
						$("#registerId").focus();
					});
					$("#ckIdcheckreg").val("0");
				}
				 else if (param>=1){
					console.log("예약 있음");
					swal("중복된 예약이 존재합니다.").then(function(){
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
					console.log("스터디룸 선택X");
					swal("스터디룸을 선택해주세요 .");
					$("#sameTimecheck").val("0");		
						
				}
					else if(param == -3){
						console.log("이미 종료시간이 지났습니다.");
						swal("이미 종료시간이 지났습니다.");
						$("#sameTimecheck").val("0");		
							
				}
					else if(param == -4){
						console.log("이미 참여중인 예약이있습니다..");
						swal("이미 참여중인 예약이 있습니다.");
							$("#sameTimecheck").val("0");
						
				}
					else if(param == -5){
						console.log("이미 당신은 동일한시간에 예약이 존재합니다.");
						swal("이미 다른호실에 예약이 되어있습니다.");
						$("#sameTimecheck").val("0");		
							
				}
			}
		});//ajax끝		
	
	})
} //중복체크 함수 끝

/** 버튼 이벤트 등록 */

   //현재페이지를 reloading href="" 전체페이지리로딩
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) { //a태그 애들중, name인 btn을 클릭을하면
		e.preventDefault(); //전체페이지 reloading을 막기위해서.. a태그 href / from submit 버튼
//event 클릭했을당시 js정보 e
		var btnId = $(this).attr('id');
//클릭하고 들어온 = this   btnSearch // btnSearch3 의 id값을꺼내와라
		switch (btnId) {
			case 'btnSave' :
				$("#action").val("I");
				fn_save();				
				break;				
 	 		case 'btnBook' :
				fn_makeBook();				
				break; 
 	 		case 'btnUpdate' :
 	 			$("#action").val("U");
 	 			fn_save();				
				break;
 	 		case 'btnGathering' :
				fn_Gathering();				
				break; 	
 	 		case 'btnGatheringOut' :
				fn_GatheringOut();				
				break;  	 		
 	 		case 'btnSaveTask' :
				fn_saveTaskSend();
				break;
			case 'btnDelete' :
				$("#action").val("D");
				fn_save();
				break;
		/* 	case 'btnDeleteFile':
				$("#action").val("D");
				fn_savefile();
				break;
			case 'btnDeleteTask':
				$("#action").val("D");
				fn_saveTaskSend();
				break;
			case 'btnSaveFile' :
				fn_savefile();
				break;
			case 'btnDeleteDtlCod' :
				fDeleteDtlCod();
				break;
			case 'btnSearch':
				fn_assignmentList();
				break;
			case 'btnSearch2':
				fn_assignmentStuList();						
				break; */
			case 'btnClose' :
				
			case 'btnCloseFile' :
				gfCloseModal();
				break;
		}
	});
}






//자바스크립트 today설정
//혹은 datepicker로 onchange시 그 date 가 fn_bookingList(date)로 들어가게
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

//dateString : 자동으로 오늘날짜가 들어오던지
//fn_bookingList(date) : datepicker change 하고 조회 버튼을 생성


function dateSelectEvent(){
	$("#date_select").click(function(e){
		console.log($("#dateSelect").val());
		//fn_init_bookingList($("#dateSelect").val());
		fn_makeTable($("#dateSelect").val());		
	})
} 



function myBookingList(){ //현재 에러가남
	
	var param = {
			today: dateString
	}
	
	 var listcallback = function(returndata){
		console.log(returndata);
		$("#myBooking_tbody").empty().append(returndata); 
	}
	 callAjax("/rsvrem/myBookList.do", "post", "text", false, param, listcallback);
}	


function fn_makeTable(date){
	
	//alert ("table그리기 테이블 다시받고 fn_bookingList부른다.");
	var date = date
	
	var param = {
			
	}
	var listcallback = function(returndata){
		console.log(returndata);
		console.log(JSON.stringify(returndata));
		console.log(JSON.stringify(returndata.roomlists));
		/*
		roomlists":[{"sturm_no":1,"rm_name":"스터디룸1호","rm_max":6},
		            {"sturm_no":2,"rm_name":"스터디룸2호","rm_max":8},
		            {"sturm_no":3,"rm_name":"스터디룸3호","rm_max":10},
		            {"sturm_no":4,"rm_name":"스터디룸4호","rm_max":12}]
		
		*/
		values = returndata.roomlists;
		var tablehtml = "";
		for(var i =0; i<values.length; i++){
			console.log(values[i]);
			
			var sno = values[i].sturm_no;
			
			var for_td_id = sno * 100;

			

			tablehtml += "<tr>";
			tablehtml += "<td>" + values[i].rm_name + "</td>";

			for(var a=9; a<18; a++){
			tablehtml += "<td id=" + (for_td_id + a) +">" + "</td>";
			}

			tablehtml += "</tr>";

		
		}
		$("#studyrooom_tbody").empty().append(tablehtml);
	}
	
	 callAjax("/rsvrem/roomlist.do", "post", "json", false, param, listcallback);
	
	 fn_bookingList(date);
}




function fn_bookingList(date){
	
	date = date || dateString; //default : dateString: 현재날짜
	
	
	//alert('실행 되었습니다.fn_bookingList예약목록');

	 var param = {
		date : date
	
	 }
	 
	 var listcallback = function(returndata){
			
			console.log( JSON.stringify(returndata));
			console.log("===========" +  JSON.stringify(returndata.booklists)); //undefined
			
			values = returndata.booklists;
			console.log(values);
			//console.log(typeof(values); //object
			//$("#studyrooom_tbody").empty();
			 $.each(values, function( index, value ) {
                 console.log( index + " : " + value.book_no ); //Book.java 의 변수명을 써주면 된다.
              });
			
			
			//var arr= []; //배열은 한개만들고.. for문안에서 객체배열의 객체숫자만큼 arr이 형성되고, 거기서 td tr하는순간끝나기때문에
			//하나만 선언하면 된다.
			var arr=[];
			for(var i = 0; i<values.length; i++){  //배열 리스트 시작.
				//테이블 그리기 따로 리스트작성해서 스터디룸갯수만큼 써주기..
		
				////////////////////////////////////////////////////////////////////////////////
				 arr= []; 
				console.log(values[i]);
				//각각 data 뿌려주면 된다.
				//ㄱ. td id찾기
				//ㄴ. colspan = (endTime - startTime)
				//ㄷ. 나머지 td감추기 -배열에다가 arr[12,13,14] ==> arr[112,113,114] 수정
				
				console.log(values[i].startTime);
				for(var j = values[i].startTime; j<values[i].endTime; j++){
					arr[j-values[i].startTime] = j + (values[i].sturm_no*100);
				}
				//배열을 출력하는 메소드
				for(var k= 0; k<arr.length; k++){
					console.log(arr[k]); // [110, 111] , [112,113,114] 인 배열이 형성되었다.
				}
				
				
				//
				//TODO: 시작시간 제외한 tdId는 숨기기			
				for(var l = 1; l<arr.length; l++){
				//$('#id').attr('style', "display:none;");  //숨기기						
				$('#'+(arr[l])).attr('style', "display:none;");  //숨기기						
				
				}
			 	//TODO : 시작시간 ID에 attr? 추가하기/
				
				
				 //$('#115').attr('style', "display:none;");  //숨기기
				$("#"+arr[0]).text(values[i].name + " " + values[i].startTime +"시 ~ " + values[i].endTime+"시" );
				
				  $( "#"+arr[0] ).attr( 'style', 'background-color:'+"'"+values[i].bgcolor+"'" ); //색상표 부여하기 ===db에 table받아와서. 팔레트 입력창
				  $( "#"+arr[0] ).attr( 'colspan', values[i].endTime-values[i].startTime ); 
				  $( "#"+arr[0] ).attr( 'style', 'color:black;background-color:'+values[i].bgcolor ); 
				  
				  
			
				console.log("bgcolor출력 = " + values[i].bgcolor);
				///////////////////////////////////////////////////////////화면출력
				
				///////////////////////////////////////////////////////상세보기팝업				
	
				 //$("#"+arr[0]).click(values[i],reserve_func); //이거 주석처리하고
				 $("#"+arr[0]).click(values[i],reserve_func_new); 
		
					
				
				
				
			}//배열 리스트 끝.
			
			
			//$("#studyrooom_tbody").empty().append(returndata); 
			//popupinitfile(returndata.booklists);
			// 모달 팝업
			//gfModalPop("#layer2");
		 
	 } //콜백함수끝
	 
	 callAjax("/rsvrem/daylist.do", "post", "json", false, param, listcallback);
		//목록 text타입리턴타입 //나머지는 json리턴타입
}
	
	function fn_bookingselect(){
			alert("상세조회 예약화면");
		}
	function reserve_func_new(event){
		//alert("reserve_func");
		console.log("reservefunc의 book_no===="+ event.data.book_no);
		var book_no = event.data.book_no
	
		var param = {
		book_no : book_no
		}		
		
		var selectcallback = function(reval) {
			console.log(JSON.stringify(reval));
			console.log(reval.oneBook);
			gfModalPop("#layer1");
			popupinit(reval.oneBook); 
			
		};	
		
		callAjax("/rsvrem/selectOne.do", "post", "json", false, param , selectcallback) ;
		
				
				
				
	}
	
	
	function popupinit(object){
		//alert("모달창 값집어넣기");
		$("#sameTimecheck").val("0"); 
		console.log("popupinit의 값들" + object.book_no);
		console.log("zzzzzzzzzzzzzz"+object.loginID);
	
		 var uid = '<%=(String)session.getAttribute("loginId")%>';
		 //console.log("uid = "+ uid);
		 var html = "";
		 if(object.concatloginID !=null){
			 var str = object.concatloginID;
			//console.log("zzzzzzzzzzzzzz"+object.concatloginID);
			// console.log("ㅎㅎㅎㅎ" + str.includes(uid));
		 
			 //uid가 concatID에 포함되는지 확인하기. 				
			if(uid == object.loginID){
				html +=" (이 예약의 방장입니다.)";
			}else if(str.includes(uid)){
				html +=" (이미 참여중인 예약입니다.)";
				 $("#btnGathering").hide();
				 $("#btnGatheringOut").show();
				
			}else {
				html += " ";
				 $("#btnGathering").show();
				 $("#btnGatheringOut").hide();
			}
		 }
		 
		$("#book_no").val(object.book_no);
		$("#booking_title").val(object.book_title);
		$("#roomlist").val(object.sturm_no);
		$("#user_name").val(object.name);
		$("#booking_cnt").val(object.book_per_cnt);
		$("#booking_now").val(object.cnt+"/"+object.book_per_cnt + "  "+ html);
		$("#cnt_now").val(object.cnt); //히든값설정 -삭제시확인
		$("#booking_cont").val(object.book_cont);
		$("#booking_stime").val(object.startTime);
		$("#booking_etime").val(object.endTime);
		$("#booking_color").val(object.bgcolor);
		$("#booking_date").val(object.book_date);
		var user_admin = '<%=(String)session.getAttribute("userType")%>';
		
		//예약작성자 ==세션 로그인 사람이 같은경우
		 if(uid == object.loginID){
			 $("#btnUpdate").show(); //수정창으로 이동
			 $("#btnSave").hide();
			 $("#btnGathering").hide();
			 $("#btnGatheringOut").hide();
			 $("#btnDelete").show(); // 삭제 action이 발생	 
			 //$("#btnUpdate").click(event.data.book_no,fn_update); //이렇게하면 여러개 전달됨
			$("input[name='booking_title']").attr("readonly", false); 
			$("#roomlist").attr("disabled", false); 
			$("#booking_stime").attr("disabled", false);
			$("#booking_etime").attr("disabled", false);
			$("#booking_cnt").attr("disabled", false);
				
			$("input[name='user_name']").attr("readonly", false); 
			$("#booking_cont").attr("readonly", false); 
			$("input[name='booking_color']").attr("readonly", false); 
			//$("#action").val("U");
			 
			 
			 
			 
			 
		 } else{
		

		
		$("input[name='booking_title']").attr("readonly", true); 
		$("#roomlist").attr("disabled", true); 
		$("#booking_stime").attr("disabled", true);
		$("#booking_etime").attr("disabled", true);
		$("#booking_cnt").attr("disabled", true);
		
		$("input[name='user_name']").attr("readonly", true); 
		$("#booking_cont").attr("readonly", true); 

		$("input[name='booking_color']").attr("readonly", true); 
		
		//본인이 작성하지않은 경우 수정,삭제버튼 숨기기
		 $("#btnDelete").hide();
		 $("#btnUpdate").hide();
		 $("#btnSave").hide();
		

		 
		 }
		 
		 //관리자로 접속한 경우 삭제버튼 보이기., 참여하기버튼 안보이기
		 if(user_admin == 'M'){
			 $("#btnDelete").show();
			 $("#btnGathering").hide();
		 }
		
	}
	
	
<%-- 	function reserve_func(event){ //모달창 생성하면 되겠다 ^_^
		alert("reserve_func");
		$("#sameTimecheck").val("0"); //중복체크 초기화시키기.
		//console.log(values[i]);
		
		console.log("reservefunc의 book_no===="+ event.data.book_no);
		console.log(event.data);
		console.log(event);
		//popupinitfile();
		var html = "";
		if(event.data.smhostyn =='N'){
			html += "(이미 참여중인 예약입니다.)";
			 $("#btnGathering").hide();
			 $("#btnGatheringOut").show();
		} else if(event.data.smhostyn =='Y'){
			html += "(이 예약의 방장입니다.)";
		} else {
			html += "";
			 $("#btnGathering").show();
			 $("#btnGatheringOut").hide();
		}
		console.log("html=="+ html);
			
		$("#book_no").val(event.data.book_no);
		$("#booking_title").val(event.data.book_title);
		$("#roomlist").val(event.data.sturm_no);
		$("#user_name").val(event.data.name);
		$("#booking_cnt").val(event.data.book_per_cnt);
		$("#booking_now").val(event.data.cnt+"/"+event.data.book_per_cnt + "  "+ html);
		$("#cnt_now").val(event.data.cnt); //히든값설정 -삭제시확인
		$("#booking_cont").val(event.data.book_cont);
		$("#booking_stime").val(event.data.startTime);
		$("#booking_etime").val(event.data.endTime);
		$("#booking_color").val(event.data.bgcolor);
		$("#booking_date").val(event.data.book_date);
		 
		var user_admin = '<%=(String)session.getAttribute("userType")%>';
		//console.log("usertype이 admin??: "+ user_admin);
		
		
		 var uid = '<%=(String)session.getAttribute("loginId")%>';
		 console.log("uid = "+ uid);
		 if(uid == event.data.loginID){
			 $("#btnUpdate").show(); //수정창으로 이동
			 $("#btnSave").hide();
			 $("#btnGathering").hide();
			 $("#btnGatheringOut").hide();
			 $("#btnDelete").show(); // 삭제 action이 발생	 
			 //$("#btnUpdate").click(event.data.book_no,fn_update); //이렇게하면 여러개 전달됨
			$("input[name='booking_title']").attr("readonly", false); 
			$("#roomlist").attr("disabled", false); 
			$("#booking_stime").attr("disabled", false);
			$("#booking_etime").attr("disabled", false);
			$("#booking_cnt").attr("disabled", false);
				
			$("input[name='user_name']").attr("readonly", false); 
			$("#booking_cont").attr("readonly", false); 
			$("input[name='booking_color']").attr("readonly", false); 
			//$("#action").val("U");
			 
			 
			 
			 
			 
		 } else{
		

		
		$("input[name='booking_title']").attr("readonly", true); 
		$("#roomlist").attr("disabled", true); 
		$("#booking_stime").attr("disabled", true);
		$("#booking_etime").attr("disabled", true);
		$("#booking_cnt").attr("disabled", true);
		
		$("input[name='user_name']").attr("readonly", true); 
		$("#booking_cont").attr("readonly", true); 

		$("input[name='booking_color']").attr("readonly", true); 
		
		//본인이 작성하지않은 경우 수정,삭제버튼 숨기기
		 $("#btnDelete").hide();
		 $("#btnUpdate").hide();
		 $("#btnSave").hide();
		 //참여버튼 보이ㅣㄱ
		
		 
			if(event.data.smhostyn =='N'){
				 $("#btnGathering").hide();
				 $("#btnGatheringOut").show();
			} else{
				 $("#btnGathering").show();
				 $("#btnGatheringOut").hide();
			}
		 
		 
		 
		 
		 
		 }
		 //관리자로 접속한 경우 삭제버튼 보이기.
		 if(user_admin == 'M'){
			 $("#btnDelete").show();
		 }
		 
		// 파라미터 값 book_no로 조회해야함
		gfModalPop("#layer1");
	} --%>
	
	
	//스터디룸 선택 selectbox
	function fn_setSelectBox(){
	
		//alert('실행 되었습니다.fn_setSelectBox ::스터디룸 설정하기');		
		var param = {}
		//넘길값도 없다?? 이미세션에 id가있음;
		var selectcallback = function(returnvalue){
			//selectboxlist.jsp
			console.log('select함수 실행하고 컨트롤러에서 컬백받는 value :'+ returnvalue);			
			

			//tbody 영역 
			$("#roomlist").empty().append(returnvalue);	
	
		}
		
		
		callAjax("/rsvrem/selectList.do", "post", "text", false, param, selectcallback);
		

	}	

	
	
//색상 팔레트 설정하기
 
     window.onload = function(){

    var colorInput = document.querySelector('#color');
    colorInput.addEventListener('input', func_color);
    
    function func_color(){    	
    	
            var color = colorInput.value;
            var spanTag = document.createElement('span');
            spanTag.style = "color: "+color;
            $("#booking_color").val(color);
            window.getSelection().getRangeAt(0).surroundContents(spanTag);
        
        
    }
     }
	

	//새로 예약하기 
	function fn_makeBook(){
		gfModalPop("#layer1");
		$("#sameTimecheck").val("0"); //중복체크 초기화시키기
		 var uid = '<%=(String)session.getAttribute("loginId")%>';
		 $("#book_no").val("");
		$("#booking_title").val("");
		$("#roomlist").val("");
		$("#user_name").val(uid);
		$("#booking_cnt").val("");
		$("#cnt_now").val("");
		$("#booking_now").val("");
		$("#booking_cont").val("");
		$("#booking_stime").val("");
		$("#booking_etime").val("");
		$("#booking_color").val("");
		$("#booking_date").val($('#dateSelect').val());//!!!!!!!!!
		$("input[name='booking_title']").attr("readonly", false); 
		$("#user_name").attr("readonly", true);
		$("#roomlist").attr("disabled", false); 
		$("#booking_stime").attr("disabled", false);
		$("#booking_etime").attr("disabled", false);
		
		$("#booking_cnt").attr("disabled", false);
		$("#booking_cont").attr("readonly", false); 
		$("input[name='booking_color']").attr("readonly", false); 
		
		
		$("#btnDelete").hide();
		$("#btnSave").show();
		$("#action").val("I");
		$("#btnUpdate").hide();
		$("#btnGathering").hide();
		$("#btnGatheringOut").hide();
	}

	function fn_save(){
		//controller에서 중복체크값이 $("#sameTimecheck").val("1"); 인경우 callback
		 if(!fn_Validate()){
			 return;
		 }
		if($("#action").val() == "D"){
			if(confirm("참석자가 없어야 취소가능합니다. 삭제하시겠습니까?")){
				if(parseInt($("#cnt_now").val())>1){
					swal("이미 참여자가 있어 삭제할수없습니다.");
					return;
				}
				
				else{				
					if(confirm("정말 삭제하시겠습니까?")){
					$("#sameTimecheck").val("1")}
					else{
						return;
						}
				}
			}
		}
		if(parseInt($("#sameTimecheck").val()) == 0){
			swal("중복체크를 해주세요");
			return;
		}
		//추가
		//관리자의 경우 id값의 disabled true-> false로 바꿔주기
		$("#roomlist").attr("disabled", false); 
		$("#booking_stime").attr("disabled", false);
		$("#booking_etime").attr("disabled", false);
		$("#booking_cnt").attr("disabled", false);
		
		 
		 var param = {
				// action : $("#action").val("I"),
				 //신규버튼이면 notice_no는 빈값이다.
				 notice_no : $("#notice_no").val(),
				 notice_title : $("#notice_title").val(),
				 notice_cont : $("#notice_cont").val()
		 }
		 
		 var savecallback = function(reval){
			 //목록빼ㅑ고는 다 json형태이다.
			 console.log(JSON.stringify(reval));
			// {"returnVal" : 1}
			 if(reval.returnVal > 0){
				
				 //저장 후 목록재조회
				 	
				 if($("#action").val() == "U"){
					 swal("수정되었습니다.");
					 fn_makeTable($("#booking_date").val());
					 gfCloseModal();
				 }else if($("#action").val() == "D"){
					 swal("삭제되었습니다.");
					// fn_bookingList();
					fn_makeTable();
					 gfCloseModal();					 
				 }
				 
				 else{
					 swal("저장되었습니다.");
					 fn_makeTable($("#booking_date").val());
					 gfCloseModal();}
				 //창닫기
			 }  else if(reval.returnVal == -2) {
				 swal("스터디룸 허용수를 확인해주세요.");
			 } else if(reval.returnVal == -3) {
				 swal("이미 참석자가있어 삭제할수없습니다.");
			 } else if(reval.returnVal == -4) {
				 swal("중복체크를 확인해주세요.");
			 }
			
			 
			 	else {
				 alert("오류가 발생되었습니다.");
			 }
			
			 
		 }
		// callAjax("/mngNot/noticeSave.do", "post", "json", false, param, savecallback);
		 callAjax("/rsvrem/bookSave.do", "post", "json", false, $("#myForm").serialize(), savecallback);
		 //json 형태의 param
		 // form 태그안에 모두들을 json형태로 던진다. form태그의 아이디  param ={} 형태로 넘어가게된다....
	}
	function fn_Validate() {

		var chk = checkNotEmpty(
				[
						[ "booking_title", "제목을 입력해 주세요." ]
					,	[ "roomlist", "스터디룸을 선택해주세요" ]
					,	[ "", "스터디룸을 주세요" ]						
						,	["booking_stime", "시작시간을 선택해주세요"]
						,	["booking_etime", "종료시간을 선택해주세요"]
					,	["booking_cnt", "참석인원을 입력해 주세요"]
					,	["booking_cont", "스터디내용을 입력해주세요"]
				
			

				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	

	/////////////////////////////////////////////////////////////////////
	function fn_Gathering(){
		//alert("참여하기버튼 눌렀다.");
		//alert($("#book_no").val());
		//alert($("#roomlist").val());
		//alert("현재참여자수..=" +$("#cnt_now").val()+"/"+$("#booking_cnt").val() );
		
		if(parseInt($("#cnt_now").val())>=parseInt($("#booking_cnt").val())){
			swal("예약인원이 꽉찼습니다.");
			return;
		}
		//1.중복체크.
		//(종료시간이 지나지않을것). 다른룸에 예약이없을것
		var startTime = $("#booking_stime option:selected").val();
		var endTime = $("#booking_etime option:selected").val();
		
		
		var startpoint = $("#booking_date").val()+" "+ startTime+ ":00:00";
		console.log(startpoint);
		var date_np = new Date(nowpoint);
		var date_sp = new Date(startpoint);
		var dateval = (date_np.getTime() - date_sp.getTime()); //예약시간 11시 현재시간 12시
		console.log(date_np>date_sp);
		 if(date_np>date_sp){
			console.log("이미 시작시간이 지났습니다.");
			if(confirm("이미 시작시간이 지났습니다. 참석하시겠습니까?")){
				$("#booking_stime").focus();	//예를 누른경우.										
			} else{
				swal("다른예약을 선택해주세요.");  //아니오 누른경우
				$("#sameTimecheck").val("0");
			}
		}
		
		var param = {
				room_no : $("#roomlist").val(),
				booking_date : $("#booking_date").val(),
				booking_stime : $("#booking_stime").val(),
				booking_etime : $("#booking_etime").val(),
				book_no : $("#book_no").val(),
				booking_cnt: $("#booking_cnt").val(),
				cnt_now : $("#cnt_now").val()
		}
		$.ajax({
			url : '/rsvrem/sameTimeCheckingGathering.do',
			type : 'post',
			data : param, //data로 뭐가 넘어가는건지??
			dataType : 'text',
			async : true,
			success : function(param) {
				if (param>=1){
					console.log("예약 있음");
					swal("중복된 예약이 존재합니다.").then(function(){
						$("#registerId").focus();
					});
					console.log(param);
					$("#sameTimecheck").val("0");
				
				} else if(param == 0){
					console.log("예약 없음");
					//swal("참석가능한 시간입니다.");
					$("#sameTimecheck").val("1");
					//참석(table insert함수 호출)
					fn_attendMeeting($("#book_no").val(),$("#roomlist").val());
				}
					else if(param == -1){
					console.log("아이디 없음");
					swal("시간을 다시 선택해주세요 .");
					$("#sameTimecheck").val("0");
				}
					else if(param == -2){
					console.log("스터디룸 선택X");
					swal("스터디룸을 선택해주세요 .");
					$("#sameTimecheck").val("0");		
						
				}
					else if(param == -3){
						console.log("이미 종료시간이 지났습니다.");
						swal("이미 종료시간이 지났습니다.");
						$("#sameTimecheck").val("0");		
							
				}
					else if(param == -4){
						console.log("이미 종료시간이 지났습니다.");
						swal("예약인원이 꽉찼습니다.");
						$("#sameTimecheck").val("0");		
							
				}
					
			}
		});
		
	}
 function fn_attendMeeting(book_no, room_no){
	 console.log(book_no+" "+room_no);
	 var param ={
			 book_no : book_no
			 ,room_no : room_no			 
	 }
	 var attendcallback = function(reval) {
			console.log(JSON.stringify(reval));
			console.log(reval.returnvalue);
			
			if(reval.returnVal == -2){
				swal("이미 참여한 예약입니다.");
				
			}else{
				swal("참석에 성공하였습니다.");
				fn_makeTable();
				gfCloseModal();
	
			
			}
			
		};	
		
		callAjax("/rsvrem/attendMeeting.do", "post", "json", false, param , attendcallback) ;
 }
 
 function fn_GatheringOut(){
	 if(confirm("정말 탈퇴하시겠습니까?")){
		 
	 }else{
		 return;
	 }
	 var param={
			 book_no : $("#book_no").val()
	 }
	 var outcallback = function(reval) {
			console.log(JSON.stringify(reval));
			console.log(reval.oneBook);
			
			if(reval.returnVal <0){
				swal("오류가 발생했습니다.");
				
			}else{
				swal("탈퇴에 성공하였습니다.");
				//fn_makeTable();
				gfCloseModal();
	
			
			}
			
		};	
		
		callAjax("/rsvrem/outMeeting.do", "post", "json", false, param , outcallback) ;
	 
 }
    
</script>
</head>




<body>
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
								class="btn_nav bold">예약</span> <span class="btn_nav bold">예약관리
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침★</a>
						</p>
				
						<p class="conTitle">
							
							
	
							
							<span>예약 목록</span> <span class="fr"> 
							</span>
								<div class="dateselect">
								
					<span style="margin-left:680px"> <strong>날짜선택 :</strong></span>
					<input type="text" class="inputTxt p10"
							style="width:100px;"	name="dateSelect" id="dateSelect" />
							
							<input type="button" id="date_select" value="조회"/>	
							 <a href="" class="btnType blue" id="btnBook" name="btn"><span>예약하기</span></a>
				</div>
				
				<br>
								<div class="reserveList">
		
						
			
							<table class="col">
								<caption>예약목록</caption>
								<colgroup>
									<col width="15%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
									<col width="9.5%">
										
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">스터디룸명</th>
										<th scope="col">9시</th>
										<th scope="col">10시</th>
										<th scope="col">11시</th>
										<th scope="col">12시</th>
										<th scope="col">13시</th>
										<th scope="col">14시</th>
										<th scope="col">15시</th>
										<th scope="col">16시</th>
										<th scope="col">17시</th>
													
									</tr>
								</thead>
								<tbody id="studyrooom_tbody">
								
							<!-- 	<tr>
									<td>스터디룸1</td>
									<td id="109"></td>
									<td id="110"></td>
									<td id="111"></td>
									<td id="112"></td>
									<td id="113"></td>
									<td id="114"></td>
									<td id="115"></td>
									<td id="116"></td>
									<td id="117"></td>								
								</tr>
								<tr>
									<td>스터디룸2</td>
									<td id="209"></td>
									<td id="210"></td>
									<td id="211"></td>
									<td id="212"></td>
									<td id="213"></td>
									<td id="214"></td>
									<td id="215"></td>
									<td id="216"></td>
									<td id="217"></td>								
								</tr>
								<tr>
									<td>스터디룸3</td>
									<td id="309"></td>
									<td id="310"></td>
									<td id="311"></td>
									<td id="312"></td>
									<td id="313"></td>
									<td id="314"></td>
									<td id="315"></td>
									<td id="316"></td>
									<td id="317"></td>							
								</tr>
								<tr>
									<td>스터디룸4</td>
									<td id="409"></td>
									<td id="410"></td>
									<td id="411"></td>
									<td id="412"></td>
									<td id="413"></td>
									<td id="414"></td>
									<td id="415"></td>
									<td id="416"></td>
									<td id="417"></td>							
								</tr> -->
								
								</tbody>
							</table>
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
							
							<div class="lectureList">
			<h1 style="font-size:15px">스터디룸 정보</h1><br>
		
			
			<!-- //////////////////////////////////////////////////////////////// -->
	<div class="tab_wrap">
  <label for="tab1" class="on">시설안내</label>
  <label for="tab2">공간소개</label>
  <label for="tab3">유의사항</label>
  
  <input type="radio" name="tab" id="tab1">
  <input type="radio" name="tab" id="tab2">
  <input type="radio" name="tab" id="tab3">  
</div><!--tab_wrap-->

<div class="tab_content tab_content1">
  <p><br>
1 화이트보드 <br><br>

2 PC와 모니터<br><br>

3 냉난방 시설<br><br>

4 무선wifi<br><br>

5 컬러/흑백 프린터<br><br>

6 고급 원두를 사용한 커피 무료<br>
  
  </p>
</div><!--tab_content1-->
<div class="tab_content tab_content2">
  <p>
  <strong>영업시간</strong> : 9시~18시
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 휴무일    : 없음
 <br><br><br>
  <table class="col">
  					<thead>
						<tr>
							<th scope="col">스터디룸명</th>
							<th scope="col">1호실</th>
							<th scope="col">2호실</th>
							<th scope="col">3호실</th>
							<th scope="col">4호실</th>
							<th scope="col">5호실</th>
						</tr>
					</thead>
			  <tbody>
			  	<tr>
			  		<td>최대 허용수</td>
			  		<td>6</td>
			  		<td>8</td>
			  		<td>10</td>
			  		<td>12</td>
			  		<td>6</td>
			  		
			  	</tr>
			  </tbody>

  </table>
  <p>
</div><!--tab_content2-->
<div class="tab_content tab_content3">
  <p>1 당일 예약도 가능합니다.</p><br>
  <p>2 원활한 운영이 되기 위해 퇴실시간 기준 5분전 퇴실을  권유드리고 있습니다. 양해 부탁드립니다.</p><br>
  <p>3 허용인원 수를 넘기지 마십시오.</p><br>
</div><!--tab_content3-->

<script>
$('label').click(function(){
	  $('label').removeClass('on');
	  $(this).addClass('on');
	  var idx=$(this).index()+1;

	  $('.tab_content').css('display','none');
	  $('.tab_content'+idx).css('display','block');
	  
	});
	</script>
				</div>
				
			
				<br><br>
			
								
								
								
								
								
					</div> <!--// content -->
					
<form id="myForm" action=""  method="">		
<input type="hidden" name="sameTimecheck" id="sameTimecheck" value="0"/>	
<input type="hidden" id="action" name="action" />
<input type="hidden" id="book_no" name="book_no" />
<input type="hidden" id="cnt_now" name="cnt_now" />

<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 620px;height:550px">
		<dl>
			<dt>
				<strong>스터디룸 예약</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="booking_title" id="booking_title" /></td>
									
						</tr>
						<tr>
							<th scope="row">스터디룸명 <span class="font_red">*</span></th>
							<td id="room_select"colspan="3">
							<select id="roomlist" name="roomlist" style="width: 150px;" >
							<!--  <select id="leclist" name="leclist" style="width: 150px;" onchange="fn_setSelectBox(this)" >-->
						    		<option value="" >전체</option>	
						    		<!-- option value="lec_no"> lec_name </option> -->					    									
							</select> 
							<!-- <p id="max_cnt"> 최대인원 수 :</p> -->
							
							</td>					
						</tr>
						<tr>
							<th scope="row">예약자 </th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="user_name" id="user_name" /></td>	
						
													
						</tr>
						<tr>
							<th scope="row">예약시간 <span class="font_red">*</span></th>
							<td colspan="3">
							<input type="text" 
								name="booking_date" id="booking_date" class="inputTxt p100" style="width: 160px;font-size:1em" />
								<select id="booking_stime" name="booking_stime" style="width: 100px"  >
									<option value="" selected>-시작시간-</option>
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
									<select id="booking_etime" name="booking_etime" style="width: 100px" >
									<option value="" selected>-종료시간 -</option>
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
								<input type="button" id="same_time_check" value="중복체크"/>
							</td>					
						</tr>
						<tr>
							<th scope="row">색상선택 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" style="width: 130px;font-size:1em;height: 25px"
								name="booking_color" id="booking_color" />
								
								<span class="box">
								 <span class="editor-btn icon" title="Color Picker">
								  <input title="Color Picker" type="color" id="color">
								 </span>
								</span>
								<input type="button" id="color_select" value="색상선택"/>	
							</td>					
						</tr>
						<tr>
							<th scope="row">참석인원 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text"    class="inputTxt p100"
								name="booking_cnt" id="booking_cnt" 
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								placeholder = "숫자를 입력하세요."/></td>		
										
						</tr>
						<tr>
							<th scope="row">현재현황 </th>
							<td colspan="3"><input type="text"    class="inputTxt p100"
								name="booking_now" id="booking_now"	 disabled			
								/></td>		
										
						</tr>
						
						<tr>
							<th scope="row">스터디내용 <span class="font_red">*</span></th>
							<td colspan="3"><textarea name="booking_cont"  class="inputTxt p100"
								 id="booking_cont" ></textarea></td>					
						</tr>
				
				
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
<!-- 본인이 작성한 경우 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnGathering" name="btn"><span>참여하기</span></a> 
					<a href="" class="btnType blue" id="btnGatheringOut" name="btn"><span>탈퇴하기</span></a> 
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
<div id="layer2" class="layerPop layerType2" style="width: 600px;height:500px">
		<dl>
			<dt>
				<strong>색상 선택</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
			
				
		<!-- 	<input id="color-picker"/> -->
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	
	
	</div>
	
	
</form>	
					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
</body>
</html>