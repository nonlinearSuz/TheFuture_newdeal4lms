<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${empty gradesearchlist}">
	<tr>
	 	<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:forEach items="${gradesearchlist}" var="list">
	<tr>
		<td>${list.loginID}</td>
		<td>${list.name}</td>
		<td>${list.tot_score}</td>
		<td>${list.reg_status}</td>
		<td>${list.drop_yn}</td>
	</tr>
</c:forEach>
<input type="hidden" id="totalleccnt" name="totalleccnt"
	value="${totalleccnt}" />

