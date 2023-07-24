<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>			
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${myLecturesearchlist}" var="list">
									<tr>
										<td>${list.lec_period}</td>
										<td>${list.lec_name}</td>
										<td>${list.prof_name}</td>
										<td>${list.tot_score}</td>
										<td>${list.drop_yn}</td>							 
										<c:choose>
				                              <c:when test="${list.acc_yn_code eq 'Y'}">
				                                  <td><font color="blue">승인</font></td>
				                              </c:when>
				                              <c:when test="${list.acc_yn_code eq 'N'}">
				                                  <td><font color="red">반려</font></td>
				                              </c:when>
				                              <c:when test="${list.acc_yn_code eq 'P'}">
				                                  <td><font color="black">승인 대기</font></td>
				                              </c:when>
				                              <c:otherwise>
				                                  <td>수강 취소</td>
				                              </c:otherwise>
			                             </c:choose>
										
										<!-- 승인 여부가 승인 대기(P)일 때만 수강 취소 버튼이 생성됨 -->
										<td>
										<c:choose>
											<c:when test="${list.acc_yn_code == 'P'}">
											    <a class="btnType3 color1" href="javascript:fn_cancel('${list.loginID}','${list.lec_no}','C')"><span>취소</span></a>	
											</c:when>
											<c:when test="${list.acc_yn_code == 'C'}">
											    <a class="btnType3 color2" href="javascript:fn_apply('${list.loginID}','${list.lec_no}','P')"><span>재신청</span></a>	
											</c:when>
											<c:otherwise>				
												<span> </span>
											</c:otherwise>
										</c:choose>
										</td>
									</tr>	
								</c:forEach>
							</c:if>

							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
										