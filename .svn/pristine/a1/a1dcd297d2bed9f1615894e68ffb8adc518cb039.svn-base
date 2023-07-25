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
	<c:forEach items="${gradesearchlist}" var="list" varStatus="status">
		<tr>
			<td>${list.lec_name}</td>
			<td><a href="javascript:fn_selectone('', '${list.lec_no}')">${list.test_name}</td>
			<td>${list.test_start}</td>
			<td>${list.test_end}</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>