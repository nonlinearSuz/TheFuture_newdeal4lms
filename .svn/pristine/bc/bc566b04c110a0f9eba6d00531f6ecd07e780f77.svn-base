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
								<c:forEach items="${approvalsearchlist}" var="list">
									<tr>
										<td>${list.lec_period}</td>
										<td>${list.lec_name}</td>
										<td>${list.stud_name}</td>
										<td>${list.stud_id}</td>
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
										<td>																				
											<c:choose>
												<c:when test="${list.acc_yn_code == 'P' || list.acc_yn_code == 'Y' || list.acc_yn_code == 'N'}">
												    <a class="btnType3 color2" href="javascript:fn_approve('${list.stud_id}','${list.lec_no}','Y')"><span>승인</span></a>
													<a class="btnType3 color1" href="javascript:fn_approve('${list.stud_id}','${list.lec_no}','N')"><span>반려</span></a> 	
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
										