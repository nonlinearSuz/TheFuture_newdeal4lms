<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${studentsearchlist}" var="list">
									<tr>
										<td><a href="javascript:fn_selectone('${list.loginID}')">${list.name}(${list.loginID})</a></td>
										<td>${list.user_hp}</td>
										<td>${list.user_date}</td>
										<c:choose>
											<c:when test="${list.acc_yn == 0}">
										    	<td><font color=red >미수강</font></td>
										  	</c:when>
										  	<c:otherwise>
										   		<td><font color=blue >수강</font></td>
										  </c:otherwise>
										</c:choose>
										<td>
											<a class="btnType3 color1" href="javascript:fn_studentWithdrawal('${list.loginID}');"><span>탈퇴</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>