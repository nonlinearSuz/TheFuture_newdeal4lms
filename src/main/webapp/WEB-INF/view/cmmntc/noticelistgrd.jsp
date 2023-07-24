<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
	<!-- 2023-07-11 commit 주석 -->
	<c:if test="${totalcnt eq 0 }">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalcnt > 0 }">
		<c:forEach items="${noticesearchlist }" var="list">
			<tr>
				<td>${list.nt_no }</td>
				<td><a href="javascript:selectone(' ${list.nt_no }')">${list.nt_title }</a></td>
				<td id="name">${list.enr_user }</td>
				<td>${list.enr_date}</td>
				<td>${list.nt_cnt}</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt }"/>
