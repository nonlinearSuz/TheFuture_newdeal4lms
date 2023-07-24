<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의시간표</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
//********************시간표 datepicker**************************//

$(function(){
	 $("#dateSelect").datepicker({
	
				 showOn: "both"
		    	   , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			    	    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			    	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트      
			    	    	, dateFormat : 'yy-mm-dd'
	 });

     
     $('#dateSelect').datepicker('setDate', 'today');
     
     $("#dateSelect").change(function(){


     	fn_makeTable($("#dateSelect").val());

     	   });
})

/** OnLoad event !*/ //html만 뿌려놓은상태
$(function() {

	
	
	fn_makeTable(); //처음 table그리는함수
	
	
	
});
function fn_makeTable(date){
	  var tablehtml = "";
	  var lecval = lecval;
	 var date = date;
    
    for(var a=9; a<18; a++){
        tablehtml += "<tr>";
    tablehtml +=  "<td style='font-weight:bold'>"+a+"시"+"</td>";
    for(var i =1; i<=5; i++){
        var for_td_id= i*100;
    tablehtml += "<td id=" + (for_td_id + a) +">" + "</td>";
    }
    tablehtml += "</tr>";
    } 
  

    
    $("#my_tbl").empty().append(tablehtml);
    
   // fn_timetblList(lecval);
     fn_timetblList(date);
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

var yoilarr = ["월", "화", "수", "목", "금"];


function fn_timetblList(date){
	
	//date = date || dateString; (default가 오늘인경우)

	date = date || 	$("#dateSelect").val();

	//lecval = lecval || $("#leclist").val();
	
	
	//alert('실행 되었습니다.fn_timetblList목록');
	console.log("fn_timetblList의 date= "+date);
	 var param = {
				date : date
				//date : '2023-06-26'				
			 }
	 var listcallback = function(returndata){
			//console.log('list함수 실행하고 컨트롤러에서 컬백받는 value :'+ returnvalue);
			console.log( JSON.stringify(returndata));
			console.log("===========" +  JSON.stringify(returndata.timeTblLists)); //undefined
			
			values = returndata.timeTblLists;
			console.log(values);
			//console.log(typeof(values); //object
			//$("#studyrooom_tbody").empty();
			 $.each(values, function( index, value ) {
              console.log( index + " : " + value.book_no ); //Book.java 의 변수명을 써주면 된다.
           });
			 
			
			//var arr= []; //배열은 한개만들고.. for문안에서 객체배열의 객체숫자만큼 arr이 형성되고, 거기서 td tr하는순간끝나기때문에
						//하나만 선언하면 된다.
			
			var yoilarr = ["월", "화", "수", "목", "금"];			
						var arr=[];
						var arr1=[];
						
			for(var i = 0; i<values.length; i++){  //배열 리스트 시작.
				//테이블 그리기 따로 리스트작성해서 스터디룸갯수만큼 써주기..
					arr1 = [];
					
					console.log("-=-=-=-=-=" +values[i]);  //object
					console.log("-0-0-0-0-0-" + values[i].yoil); //[월,수]
					//**** values[i].yoil 값이 null이 아니라면~~
				if(values[i].yoil != null){
						
					var valarr = values[i].yoil.split(",");
					for(var e = 0; e<valarr.length; e++){ //요일ㄹ배열시작
						console.log("xxxxxxxxxxx"+valarr[e]); //울
						console.log(yoilarr.indexOf(valarr[e])+1); // 1 , 3,        2 ,4
						var hundred = yoilarr.indexOf(valarr[e])+1;
						console.log ("???" + hundred);
						
						console.log("**********^^*****" + values[i].startTime); //9
						console.log("**********^^*****" + values[i].endTime); //12
						// [9, 10, 11, 12]
						// [109, 110,111,112]
						/* 
						
						for(var z = values[i].startTime; z<values[i].endTime; j++){
							arr[z-values[i].startTime] = z + (hundred*100);
						} */
						
						for(var c = values[i].startTime; c<values[i].endTime; c++){
							arr1[c-values[i].startTime] = c+ (hundred*100);
						}
						for(var d =0; d<arr1.length; d++){
							console.log(arr1[d])
						}
						
						console.log("===================배열끝================")
						
						//TODO: 시작시간 제외한 tdId는 숨기기			
						
						var text =values[i].lec_name + "<br>"+ "<br>"+ values[i].lec_prof+"\n"+ values[i].startTime +"시 ~ " + values[i].endTime+"시" ;
						var replace_result2 = text.replace(/\n/g, '<br/>');
						var replace_result = text.replace(/-./g, "<br>-. ");

						
						for(var l = 1; l<arr1.length; l++){
						//$('#id').attr('style', "display:none;");  //숨기기						
						$('#'+(arr1[l])).attr('style', "display:none;");}  //숨기기						
							//$('#'+(arr1[l])).attr('style', "display:none;");						}
					
					
						$( "#"+arr1[0] ).attr( 'rowspan', values[i].endTime-values[i].startTime ); 
						$("#"+arr1[0]).text(values[i].lec_name + " " + values[i].name+ " "+ "("+values[i].startTime +"시 ~ " 
								+ values[i].endTime+"시)" + " "+ values[i].rm_name );
						
						//$("#"+arr1[0]).text(text);
						


						$( "#"+arr1[0] ).attr( 'style', 'color:black;vertical-align:middle;word_wrap:break-word;  word-break: break-all;font-weight:bold;background-color:'+'#b4e4d4' ); 
						if(values[i].acc_yn == 'P'){
							console.log("승인대기 강의입니다.");
							$( "#"+arr1[0] ).attr( 'style', 'color:black;vertical-align:middle;font-weight:bold;background-color:'+'#fbc756' ); 
							$("#"+arr1[0]).text("[승인대기] "+values[i].lec_name + " " + values[i].name+ " "+ "("+values[i].startTime +"시 ~ " +
									values[i].endTime+"시)" +" " + values[i].rm_name );
							
						}
						
						  
						
					} //valarr 끝
										
					
			} //values[i].yoil 의 값이 null이 아니라면 끝
				
				
											
				
			}//배열 리스트 끝.
			
			

		 
	 } //콜백함수끝
	 
	 callAjax("/supmtb/mytablelist.do", "post", "json", false, param, listcallback);
		//목록 text타입리턴타입 //나머지는 json리턴타입

}


</script>
<style>
table.type11 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: center;
  line-height: 1.5;
  margin: 20px 10px;
}
table.type11 th {
  width: 155px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #fff;
  background: #ff8585;
}
table.type11 td {
  width: 155px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #eee;
  text-align : center;

}
</style>
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">시간표
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침★</a>
						</p>
				
						<p class="conTitle">
							
	
							
							<span>나의 시간표</span> <span class="fr">
			<!-- 			<strong>날짜선택 :</strong> 		<input type="text" class="inputTxt p10"
							style="width:100px;"	name="dateSelect2" id="dateSelect2" /> -->
							</span>
						</p>
							<span style="margin-left:780px"> <strong>날짜선택 :</strong></span>
					<input type="text" class="inputTxt p10"
							style="width:100px;"	name="dateSelect" id="dateSelect" />
						
						<div class="lectureTblList">
						<table class="type11">
								<caption>강의실 </caption>
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">							
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col"></th>
										<th scope="col">월</th>
										<th scope="col">화</th>
										<th scope="col">수</th>
										<th scope="col">목</th>
										<th scope="col">금</th>						
									</tr>
								</thead>
								<tbody id="my_tbl">								
									
									
								
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