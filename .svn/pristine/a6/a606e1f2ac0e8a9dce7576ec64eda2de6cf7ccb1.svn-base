<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						<!-- 주석!! -->   
	<!-- 조건에 맞는 리스트, 총건수 -->					   
<!-- 						        model.addAttribute("zzz", noticeSearchList);
     model.addAttribute("totalCnt", totalCnt);
      -->
      			   
						   
							<c:if test="${totalCnt eq 0 }"> <!-- JSTL문법 조회된 수가 0이니?? -->
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td> <!-- colspan 5.출력해야하는 td가 5개.. -->
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<%-- <c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" /> --%>
								<c:forEach items="${stufileSearchList}" var="list"> <!-- 한건씩 꺼내서 list라는 변수에 담아라 -->
									<tr>
										<td>${list.lec_name}</td>									
										<td><a href="javascript:fn_selectone('${list.study_file_no}')">${list.study_file_no}</a></td>
										<td><a href="javascript:fn_selectonefile('${list.study_file_no}', '${list.lec_no}')">${list.study_file_title}</a></td>
										<td>${list.enr_date}</td>
								
									</tr>
							<%-- 		<c:set var="nRow" value="${nRow + 1}" /> --%>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>
