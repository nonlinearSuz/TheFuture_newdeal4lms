<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<!-- 조건에 맞는 리스트, 총건수 -->					   
<!-- 						        model.addAttribute("zzz", noticeSearchList);
     model.addAttribute("totalCnt", totalCnt);
      -->
      			   
						   
							<c:if test="${totalCnt eq 0 }"> <!-- JSTL문법 조회된 수가 0이니?? -->
								<tr>
									<td colspan="5">예약이 존재하지 않습니다.</td> <!-- colspan 5.출력해야하는 td가 5개.. -->
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0 }">
								<%-- <c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" /> --%>
								<c:forEach items="${myRsvList}" var="list"> <!-- 한건씩 꺼내서 list라는 변수에 담아라 -->
									<tr>
										<td>${list.book_no}</td>
										<td>${list.rm_name}</td>
										<td>
											<c:choose> 
											<c:when test="${list.book_cd eq '진행예정'}">
												<span style="color:blue">${list.book_cd}</span>
											</c:when> 
											<c:when test="${list.book_cd eq '진행중' }">
												<span style="color:red">${list.book_cd}</span>
											</c:when> 
											<c:otherwise>
												${list.book_cd}
											</c:otherwise> 
										</c:choose> 										
											
									
											
										</td> 
										<%-- <td>${list.book_title}</td> --%>
										<td>
										<a href="javascript: fn_rsvinfo('${list.book_no}')" ><span>${list.book_title}</span></a>
											
										</td>
										<%-- <td>${list.book_start}  ~ ${list.book_end}</td> --%>
										<td>${list.book_date}&nbsp;&nbsp;&nbsp;  ${list.startTime}시  ~ ${list.endTime}시</td>
										
										<td>
										
											<c:if test="${list.book_cd eq '진행예정' or list.book_cd eq '진행중' }">
											<c:choose>
												<c:when test="${list.loginID eq sessionScope.loginId}">
										<a href="javascript: fn_delete('${list.book_no}', '${list.cnt}')" class="btnType blue" id="btnDelete" name="btn"><span>취소</span></a>
											
												</c:when>
												<c:otherwise>
												<a href="javascript: fn_withdraw('${list.book_no}')" class="btnType blue" id="btnDelete" name="btn"><span>탈퇴</span></a>
											
												</c:otherwise>
											</c:choose>
											</c:if>
											
										</td>
										<%-- <td><a href="javascript:fn_submitlist('${list.task_no}', '${list.lec_no}')"><strong>자세히보기</strong></a></td> --%>
																	
								
									</tr>
							<%-- 		<c:set var="nRow" value="${nRow + 1}" /> --%>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="myBook_totalCnt" name="myBook_totalCnt" value ="${totalCnt}"/>
