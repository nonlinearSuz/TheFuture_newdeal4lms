<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcount eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>			
							
							<c:if test="${totalcount > 0 }">
								<c:forEach items="${itemsearchlist}" var="list">
									<tr>
										<td>${list.item_nm}</td>
										<td>${list.item_vol}</td>
										<td>${list.item_etc}</td>	
									</tr>
									
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcount" name="totalcount" value ="${totalcount}"/>