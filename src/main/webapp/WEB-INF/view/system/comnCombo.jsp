<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	
	/** OnLoad event */ 
	$(function() {
	
		// combo box 종류  lecbyuser : 강의목록     조회 대상 테이블  tb_lecture   
		selectComCombo("lecbyuser","","lecbyusercombo","sel","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , ""  
		
		// 사용자 목록   User_type : M
		// combo box 종류  usr : 제품 전체   조회 대상 테이블  tb_userinfo   
		selectComCombo("usr","M","usercombo","all","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "" 
		
		// 사용자 목록   전체
		// combo box 종류  usr : 사용자 전체   조회 대상 테이블  tb_userinfo   
		selectComCombo("usr","","userallcombo","all","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "" 

		// 공통코드 콤보    조회 대상 테이블  tb_detail_code    그룹코드 "areacd" 에 해당하는 상세코드, 상세코드명으로 select box 생성
		comcombo("areacd", "comcodecombo", "all","");
		
		// 시험 목록   전체
		// combo box 종류  usr : 시험 전체   조회 대상 테이블  tb_tests   
		selectComCombo("test","","testallcombo","all","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "" 
		
		// 설문 목록   전체
		// combo box 종류  survey : 설문 전체   조회 대상 테이블  tb_survey   
		selectComCombo("survey","","surveyallcombo","all","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "" 
			
		
		
	});
	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
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
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold">공통콤보
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공통콤보</span> <span class="fr"> 
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="15%">
								</colgroup>								
								<tbody >
								    <tr>
								     <th>현재로그인 강의목록</th>
								     <td>
								              <select id="lecbyusercombo" name="lecbyusercombo">
								              </select>
                                     </td>
								     <th>사용자 M</th>
								     <td>
								              <select id="usercombo" name="usercombo">
								              </select>
                                     </td>
								     <th>사용자 전체</th>
								     <td>
								              <select id="userallcombo" name="userallcombo">
								              </select>
                                     </td>
								     <th>공통코드</th>
								     <td>
								              <select id="comcodecombo" name="comcodecombo">
								              </select>
                                     </td>
                                   </tr>  
                                   <tr>
								     <th>시험 전체</th>
								     <td>
								              <select id="testallcombo" name="testallcombo">
								              </select>
                                     </td>
								     <th>설문 전체</th>
								     <td>
								              <select id="surveyallcombo" name="surveyallcombo">
								              </select>
                                     </td>
								     <th></th>
								     <td>
                                     </td>
								     <th></th>
								     <td>
                                     </td>                                     
                                   </tr>  
                                   
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

</form>
</body>
</html>