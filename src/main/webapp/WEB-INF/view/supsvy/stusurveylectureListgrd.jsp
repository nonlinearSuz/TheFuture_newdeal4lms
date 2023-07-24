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
								<c:forEach items="${stusvyLecList}" var="list">
									<tr>
										<td><a href="javascript:fn_onelecclick('${list.lec_no}');">${list.lec_name}</a></td>
										<td><a href="">${list.name}</a></td>
										<td>${list.user_hp}</td>
										<td>${list.user_email}</td>
										<td><a href="javascript:fn_takeSurvey('${list.lec_no}')"	class="btnType blue"  id="" name="btn"><span>설문 응시</span></a></td>
									</tr>

								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/> 