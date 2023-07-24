<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${stulecturesearchlist}" var="list">
									<tr>
										<td><a href="javascript:fn_selectOneDtInfo('${list.lec_no}')">${list.lec_name}</a></td>
										<td>${list.lec_prof}</td>
										<td>${list.lec_start }</td>
										<td>${list.lec_end}</td>
										<td>${list.lec_signcnt}</td>
										<td>${list.max_no}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
							<!-- 주석 -->