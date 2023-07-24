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
				<td><a href="javascript:fn_selectone('${list.qna_no }',' ${list.category_no}' ,'${list.rpy_no }')">${list.qna_no }</a></td>
				<td>${list.category_name}</td>
				<td><a href="javascript:fn_selectone('${list.qna_no }',' ${list.category_no}' ,'${list.rpy_no }')">${list.qna_title }</a></td>
				<td>${list.enr_date }</td>
				<td>${list.enr_user}</td>
				<td>${list.qna_cnt}</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt }"/>
