<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>


<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Chain Maker :: Login</title> <!-- title을 정해줘야 한다 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/admin/login.css" />



<!-- 우편번호 조회 -->

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
	<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script type="text/javascript">



/* OnLoad Event */
$(document).ready(function() {
	$("#confirm").hide();
	$("#loginRegister").hide();
	$("#loginEmail").hide();
	$("#loginPwd").hide();

	var cookie_user_id = getCookie('EMP_ID');
	if (cookie_user_id != "") {
		$("#EMP_ID").val(cookie_user_id);
		$("#cb_saveId").attr("checked", true);
	}
	$("#EMP_ID").focus();
	
	init();
	
});


function fcancleModal(){
	gfCloseModal();
	}


/* 회원가입 모달창 실행*/
function fRegister() {
	
	init();
	var div_cd;
	$("#action").val("I");
	
	// 모달 팝업
	gfModalPop("#layer1");
	studentRegister();
}


/* 회원가입 모달 창 초기화 */
 function init() {
	check = new Vue({
		el: '#layer1',
		data : {
			langitems: [],
			langitems1: [],
			langitems2: [],
			langitems3: [],	
			langitemss: [],
			langitemarea1: [],
			langitemarea2: [],
			langitemarea3: [],
			listlistCod: '',
			weblistCod:'',
			dblistCod:'',
			wslistCod:'',
			sklcdlistCod:'',
			areacdlistCod:'',
			skillgrpcd:'',
			skilldtlcd:''
			
		}
	})
 }
 
 
 /* 비밀번호 초기화 모달 창 초기화*/
 function fn_init() {
	check = new Vue({
		el: '#layer2',
		data : {
			langitems: []
		}
	})
 }

 
 /*체크리스트 콜백함수*/
 function checklistResult(data){ 	
	
	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
 	$.ajax({
		url : '/checklist.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : true,
		success : function(data) {
			check.check = [];
			check.langitems = data.listlistCod;
			check.langitems1 = data.weblistCod;
			check.langitems2 = data.dblistCod;
			check.langitems3 = data.wslistCod;
			check.langitemss = data.sklcdlistCod;
			check.langitemarea1 = data.areacdlistCod;
			check.langitemarea2 = data.areacdlistCod;
			check.langitemarea3 = data.areacdlistCod;
			}
		});
		}

$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
})

var chk_arr = [];
$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
	chk_arr.push(chk);
})


/*학생 회원가입 폼 초기화*/
function studentRegister(){
	
	$("#chkS").val("S");
	$("#user_type").val("S");
	$("#user_type_li").hide(); 		
	$("#registerId").val(""); 
	$("#registerPwd").val("");
	$("#registerPwdOk").val("");
	$("#registerName").val(""); 
	$("#registerName_th").show();
	$("#gender").val(""); 
 	$("#rggender_th").show(); 
	$("#rggender_td").show(); 
	$("#birthday1").show(); 
	$("#registerEmail").val(""); 
 	$("#detailaddr").val(""); 
	$("#loginaddr").val(""); 
	$("#loginaddr1").val(""); 
	$("#user_hp").val(""); 
	$("#lec_yn").val("Y"); 
	$("#user_active").val("Y"); 
	$("#ckIdcheckreg").val("0"); 
	$("#attachFile").hide(); 
}
	
	
	

/*강사 회원가입 폼 초기화*/
function teacherRegister(){

	$("#div_cd").val("Teacher");
	$("#user_type").val("T");
	$("#user_type_li").hide();
	$("#registerId").val("");
	$("#registerPwd").val("");
	$("#registerPwdOk").val("");
	$("#gender").val(""); 
 	$("#rggender_th").show(); 
	$("#rggender_td").show();
	$("#registerName").val("");
	$("#registerName_th").show();
	$("#registerEmail").val("");
	$("#birthday1").show();
	$("#registerEmail").val(""); 
	$("#detailaddr").val("");
	$("#loginaddr").val(""); 
	$("#loginaddr1").val("");
	$("#user_hp").val(""); 
	$("#lec_yn").val("N"); 
	$("#user_active").val("Y"); 
	$("#ckIdcheckreg").val("0");
	$("#attachFile").show();
}



/* 비밀번호 초기화 모달창 실행 */
function findIdPwd() {
	
	fn_init();
	gfModalPop("#layer2");
	$("#resetpwd").hide();
	$("#pcheckid").show();
}



/* 회원가입 validation */
function RegisterVal(){
	  
 	var div_cd = $('#div_cd').val(); 
	var user_type = $('#user_type').val();
	var rgid = $('#registerId').val();
	var rgpwd = $('#registerPwd').val();
	var rgpwdok = $('#registerPwdOk').val();
	var rgname = $('#registerName').val();
	var rgemail = $('#registerEmail').val();
	var dtadr = $('#detailaddr').val();
	var lgadr = $('#loginaddr').val();
	var lgadr1 = $('#loginaddr1').val();
	var user_hp = $('#user_hp').val();
	var file_no = $('#file_no').val();
	
	if(user_type == ""){
		swal("타입을 입력해주세요.").then(function() {
			$("#user_type").focus();
		  });
		return false;
	}

	
	if(rgid.length < 1){
		swal("아이디를 입력하세요.").then(function() {
			$('#registerId').focus();
		  });
		return false;
	}
	
	if(rgpwd.length < 1){
		swal("비밀번호를 입력하세요.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgpwdok.length < 1){
		swal("비밀번호 확인을 입력하세요.").then(function() {
			$('#registerPwdOk').focus();
		  });
		return false;
	}
	
	if(rgpwd != rgpwdok){
		swal("비밀번호가 맞지 않습니다.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgname.length < 1){
		swal("이름을 입력하세요.").then(function() {
			$('#registerName').focus();
		  });
		return false;
	}
	
	
	
	if(rgemail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#registerEmail').focus();
		  });
		return false;
	}
	
	if(dtadr.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#detailaddr').focus();
		  });
		return false;
	}
	
	if(lgadr.length < 1){
		swal("주소를 입력하세요.").then(function() {
			$('#loginaddr').focus();
		  });
		return false;
	}
	
	if(user_hp.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#user_hp').focus();
		  });
		return false;
	}
	
	return true;
	}
	



/*loginID 중복체크*/
function loginIdCheck(){
	
	var data = {"loginID" : $("#registerId").val()};
	
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : true,
		success : function(data) {
			if($("#registerId").val()==""){
				console.log("입력 아이디 없음");
				swal("아이디를 입력해주세요.").then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
			}
			 else if (data==1){
				console.log("아이디 있음");
				swal("중복된 아이디가 존재합니다.").then(function(){
					$("#registerId").focus();
				});
				console.log(data);
				$("#ckIdcheckreg").val("0");
			} else if(!idRules.test($("#registerId").val())){
				swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.').then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
				return false;
			} else if(data == 0){
				console.log("아이디 없음");
				swal("사용할 수 있는 아이디 입니다.");
				$("#ckIdcheckreg").val("1");
			}
		}
	});
}


/*회원가입 버튼 아이디 중복 체크*/
function loginIdCheckComplete(){
	
	var data = {"loginID" : $("#registerId").val()}
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if (data == 1){
				$("#ckIdcheckreg").val("0");
				console.log("아이디 있음");
				return false;
			} else if(!idRules.test($("#registerId").val())){
				$("#ckIdcheckreg").val("0");
				return false;
			}
		}
	});
}





/*-------  이메일 입력방식 선택  ------*/
/*이메일 중복 체크*/
function emailCheck(){
	var data = {"user_email" : $("#registerEmail").val()};

	$.ajax({
		url : '/check_email.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if(data == 1){
				$("#ckEmailcheckreg").val("0");
				console.log("이메일 있음");
				console.log(data);
				return false;
			} else {
				$("#ckEmailcheckreg").val("1");
				console.log(data);
				console.log("이메일 없음");
			}
			
		}
	});
}




/* 회원가입  완료*/
function CompleteRegister() {
	
 	var frm = document.getElementById("RegisterForm");
 	frm.enctype = 'multipart/form-data';
 	var fileData = new FormData(frm);
	
 	
	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
 	var password = $("#registerPwd").val();
 	
 	/*이메일 정규식 */
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $("#registerEmail").val();
	
	/*전화번호 정규식*/
	var user_phRules = /^\d{3}-\d{3,4}-\d{4}$/;
	var user_hp = $("#user_hp").val();
	

	/* validation 체크 */
	if(!RegisterVal()){
		return;
	}
		
	loginIdCheckComplete();
	emailCheck();
	
			 
	if (RegisterForm.ckIdcheckreg.value == "0"){
		swal("아이디 중복확인을 진행해주세요.").then(function() {
			$("#registerId").focus();
		  });
	} else if(!passwordRules.test($("#registerPwd").val())){
		swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
			$("#registerPwd").focus();
		  });
		return false;
	} else if(!emailRules.test($("#registerEmail").val())){
		swal("이메일 형식을 확인해주세요.").then(function() {
			$("#registerEmail").focus();
		  });
	} else if(RegisterForm.ckEmailcheckreg.value =="0"){
		swal("중복된 이메일이 존재합니다. 다시 입력해주세요.").then(function() {
			$("#registerEmail").focus();
		  });
	} else if(!user_phRules.test($("#user_hp").val())){
		swal("전화번호를 확인해주세요.").then(function() {
			$("#user_hp").focus();
		  });
	}
	else{
		var resultCallback1 = function(data) {
			console.log( JSON.stringify(data) );
			fSaveRegister(data);
		}
	callAjaxFileUploadSetFormData("/register.do", "post", "json", false, fileData, resultCallback1);
	}

}



/* 회원 가입 저장 콜백함수 */
function fSaveRegister(data) {

	if (data.result == "SUCCESS") {
		alert(data.resultMsg);
		gfCloseModal();
		
	} else {
		alert(data.resultMsg);
		return false;
	}
}



// 우편번호 api
function execDaumPostcode(q) {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('detailaddr').value = data.zonecode;
			document.getElementById("loginaddr").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("loginaddr1").focus();
		}
	}).open({
		q : q
	});
}



/* 로그인 validation */
function fValidateLogin() {

	var chk = checkNotEmpty([ [ "EMP_ID", "아이디를 입력해 주세요." ],
			[ "EMP_PWD", "비밀번호를 입력해 주세요." ] ]);

	if (!chk) {
		return;
	}

	return true;
}



/* 로그인 */
function fLoginProc() {
	if ($("#cb_saveId").is(":checked")) { // 저장 체크시
		saveCookie('EMP_ID', $("#EMP_ID").val(), 7);
	} else { // 체크 해제시는 공백
		saveCookie('EMP_ID', "", 7);
	}

	// vaildation 체크
	if (!fValidateLogin()) {
		return;
	}

	var resultCallback = function(data) {
		fLoginProcResult(data);
	};

	callAjax("/loginProc.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}



/* 로그인 결과 */
function fLoginProcResult(data) {

	var lhost = data.serverName;

	if (data.result == "SUCCESS") {
		/* setSave("EMP_ID",$("EMP_ID").val(),7); */
		location.href = "${CTX_PATH}/dashboard/dashboard.do";
	} else {

		$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
				.dialog({
					modal : true,
					resizable : false,
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
							$("#EMP_ID").val("");
							$("#EMP_PWD").val("");
							$("#EMP_ID").focus();
						}
					} ]
				});
		$(".ui-dialog-titlebar").hide();
	}
}



/* 비밀번호 초기화에서 아이디 체크하는 창(가입된 아이디가 알람창으로)*/
function RegisterIdCheck(){
	var loginid = $("#emailIdText").val();

	
	var data = {
			"loginID" :loginid
	};
	console.log(data);
	
	$.ajax({
		url : "/registerIdCheck.do",
		type : "post",
		dataType : "json",
		async : false,
		data : data,
		success : function(data){
			if(loginid.length < 1){
				swal("아이디를 입력해주세요.");
				$("#loginEmail").hide();
			}
		
			else if (data.result == "SUCCESS"){
				
				swal("아이디가 존재합니다.");
				$("#loginEmail").show();
				$("#pcheckid").hide();
				$("#resetpwd").show();
				
			}else{
				swal("아이디가 존재하지 않습니다.");
				$("#loginEmail").hide();
			}
			
		}
		
	});
}



/* 비밀번호 찾기 버튼 클릭 이벤트 */
function fSelectPwd() {

 	$("#registerEmailId").hide();
 	$("#confirm").hide();
 	$("#loginRegister").show();
 	$("#loginEmail").hide();
 	$("#loginPwd").hide();
 	$("#emailIdText").val('');
 	gfModalPop("#layer2");
}



/** 비밀번호 초기화 함수 */
function fResetPwd(){
	/* 초기화 전 확인 메세지 */
	var result = confirm('비밀번호를 초기화 하시겠습니까?');
	var loginid = $("#emailIdText").val();

	/* 초기화 */	
	if (result){
		var param = {
				"loginID" :loginid			
				}
		var resetcallback = function(reval) {
			alert("비밀번호가 초기화 되었습니다")
		};
		
		$.ajax({
			url : '/ResetPwd.do',
			type : 'post',
			data : param,
			dataType : 'json',
			async : false,
			success : function(flag) {
				alert("비밀번호가 '0000'으로 초기화 되었습니다")
				
				gfCloseModal();
			}
		});
	}else{
		alert("오류가 발생했습니다.")
	}
}



	
</script>
</head>
<body>
	<form id="myForm" action="" method="post" enctype="multipart/form-data">
	<div id="background_board" >
		<div class="login_form shadow" align="center">
		<div class="login-form-right-side">
                <div class="top-logo-wrap">
                <img src="${CTX_PATH}/images/admin/login/logo.png">
                </div>
  <!--               <h3>안되는 것이 실패가 아니라 포기하는 것이 실패다</h3>
                <p>
						성공은 실패의 꼬리를 물고 온다.
						지금 포기한 것이 있는가?<br>그렇다면 다시 시작해 보자.<br>
						안되는 것이 실패가 아니라 포기하는 것이 실패다.<br>
						포기한 순간이 성공하기 5분전이기 쉽다.<br> 실패에서 더 많이 배운다.<br>
						실패를 반복해서 경험하면 실망하기 쉽다. <br>하지만 포기를 생각해선 안된다.
						실패는 언제나 중간역이지 종착역은 아니다. <br>
               </p>
               <p>- 이대희, ‘1%의 가능성을 희망으로 바꾼 사람들’ 에서</p> -->
            </div>
            
            
		<div class= "login-form-left-side">
			<fieldset>
				<legend>로그인</legend>
				<p class="id">
					<label for="user_id">아이디</label> <input type="text" id="EMP_ID"
						name="lgn_Id" placeholder="아이디"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"
						style="ime-mode: inactive;" />
				</p>
				<p class="pw">
					<label for="user_pwd">비밀번호</label> <input type="password"
						id="EMP_PWD" name="pwd" placeholder="비밀번호"
						onfocus="this.placeholder='비밀번호'; return true"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
				</p>
				<p class="member_info" style="font-size: 15px">
					<input type="checkbox" id="cb_saveId" name="" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}">
					<span class="id_save">ID저장</span> <br>
				</p>
				<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>Login</strong></a>
				<div class="btn_more">
					<a href="javascript:fRegister();" id="RegisterBtn" name="modal"><strong>[회원가입]</strong></a> 
					<a href="javascript:findIdPwd();"><strong>[비밀번호 초기화]</strong></a>
				</div>
			</fieldset>
			</div>
			
		</div>
	</div>
</form>












<!-- 회원 가입 모달팝업 -->
	<div id="layer1" class="layerPosition layerPop layerType2" style="width: 600px; height: 650px;">
      <form id="RegisterForm" action="" method="post" enctype="multipart/form-data">
	      <input type="hidden" name="action" id="action" value="">
	      <input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0"/>
	      <input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0"/>	
		<dl>
			<dt>
					<br>
					<br>
					<p style="text-align: center;"><strong style="font-size:20px; font-weight: bold;">회원가입</strong></p>
					<br>
			</dt>
			<dd class="content">
				<div class="btn_areaC">
					<a href="javascript:studentRegister();" class="btnType blue" id="registerUser"><span>학생</span></a>
					<a href="javascript:teacherRegister();" class="btnType " id="registerUser"><span>강사</span></a>
					<br>
					<br>
				</div>
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="130px">
						<col width="*">
						<col width="130px">
						<col width="*">
					</colgroup>
						<tbody>
							<tr class="hidden">
							 	<td><input type="text" name="div_cd" id="div_cd" /></td>
								<td><input type="text" name="lec_yn" id="lec_yn" /></td>
						 		<td><input type="text" name="user_type" id="user_type" /></td> 
								<td><input type="text" name="user_active" id="user_active" /></td>
							</tr>
							<tr>
								<th scope="row">아이디<span class="font_red">*</span></th>
								<td colspan="2">
									<input type="text" class="inputTxt p100" name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 " id="registerId" /></td>
								<td>
									<input type="button" value="중복확인" onclick="loginIdCheck()" style="width: 130px; height: 26px;" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="password" placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100" name="password" id="registerPwd" /></td>
							</tr>
							<tr>
								<th scope="row" style="padding: 0 0">비밀번호 확인<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="password" class="inputTxt p100" name="password1" id="registerPwdOk" /></td>
							</tr>
							
							<tr>
								<th scope="row" id="registerName_th">이름 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="name" id="registerName" /></td>
							
								<th scope="row" id="rggender_th">성별</th>
								<td id="rggender_td">
									<select name="user_gender" id="gender_cd" style="width: 128px; height: 28px;">
											<option value="" selected="selected">선택</option>
											<option value="M">남자</option>
											<option value="F">여자</option>
									</select>
								</td>
							</tr>
							<tr id="birthday1">
								<th scope="row">생년월일 <span class="font_red">*</span></th>
								<td colspan="3" ><input type="date" class="inputTxt p100" name="user_birth" id="birthday" style="font-size: 13px; width: 200px; height: 29px;  text-align: center;" />
							</tr>
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
									<td colspan="3"><input type="text" class="inputTxt p100" name="user_email" id="registerEmail" /> 
								</td>						
							</tr>
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="user_post" id="detailaddr" /></td>

								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" 	style="width: 130px; height: 26px;" /></td>
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="user_addr" id="loginaddr" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="addr_detail" id="loginaddr1" /></td>
							</tr>
							<tr>
								<th scope="row">전화번호<span class="font_red">*</span></th>
								<td colspan="3">
								<input type="text" class="inputTxt p100" name="user_hp" id="user_hp" placeholder="예시) 010-1234-5678"/></td>
							</tr>
					<tr  id="attachFile">
							<th scope="row">파일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="file" name="wfile_nm" id="wfile_nm"  ></input>									
								</td>
						</tr>	
				</table>
				
			
			
			
					
				<div class="btn_areaC mt30">
					<a href="javascript:CompleteRegister();" class="btnType blue"
						id="RegisterCom" name="btn" onclick='CompleteRegister'> <span>회원가입 완료</span></a> <a 
						href="javascript:fcancleModal()" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</form>	
	</div>





<!-- 아이디 비밀번호 찾기 모달 -->
<form id="sendForm" action="" method="post">
	<input type="hidden" name="authNumId" id="authNumId" value="" />
	<input type="hidden" name="authNumPwd" id="authNumPwd" value="" />
	<input type="hidden" name="ckIdcheck" id="ckIdcheck" value=""/>
	<div id="layer2" class="layerPop layerType2" style="width: 390px;">
		<dl>
			<dt>
				<strong>비밀번호 초기화</strong>
			</dt>
			<dd class="content">

				<!-- 비밀번호 초기화 폼 -->

				<table class="row" id="findPwdForm" style='text-align:center;'>
					<tbody>
						<tr>
							<td>
							<input type="text" id="emailIdText" placeholder="가입하신 아이디를 입력하세요" size="30" style="height: 30px;" />
								<a href="javascript:RegisterIdCheck();" class="btnType blue" id="pcheckid"><span>아이디 체크</span></a>	
								<a href="javascript:fResetPwd();" class="btnType blue" id="resetpwd"><span>초기화</span></a>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a> 
	</div>
</form>






</body>
</html>