<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0}">
									<c:forEach items="${testsearchlist}" var="list">
									    <tr>
									        <td>${list.lec_name}</td>
									        <td>${list.test_name}</td>
									        <td>${list.test_start}</td>
									        <td>${list.test_end}</td>
											<c:choose>
												  <c:when test="${empty list.res_ans}">
														    <td>
														     	 <a class="btnType3 color2" href="javascript:fn_applyTest('${list.test_no}','${list.lec_no}');"><span>응시</span></a>
														    </td>
														    <td></td>
												  </c:when>
												  <c:otherwise>
												    <td>
												      <a class="btnType3 color1" href="#">응시완료</a>
												    </td>
												    <td>
												    	  <a class="btnType3 color1" href="javascript:fn_resultTest('${list.lec_no}');"><span>결과</span></a>
												    </td>
												 </c:otherwise>
										</c:choose>
									 </tr>
							</c:forEach>


								</c:if>

							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
							
							