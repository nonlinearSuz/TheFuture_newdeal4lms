<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

	<c:if test="${totalCnt eq 0 }">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCnt > 0 }">
		<c:forEach items="${noticesearchlist}" var="list">
			<tr>
				<td>${list.nt_no}</td>
				<td><a href="javascript:fn_selectone('${list.nt_no}')">${list.nt_title}</a></td>
				<td>${list.enr_user}</td>
				<td>
				<c:choose>
				<c:when test="${not empty list.upd_date}">${list.upd_date}</c:when>
				<c:otherwise>${list.enr_date}</c:otherwise>
				</c:choose>
				</td>
				<td>${list.nt_cnt}</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>