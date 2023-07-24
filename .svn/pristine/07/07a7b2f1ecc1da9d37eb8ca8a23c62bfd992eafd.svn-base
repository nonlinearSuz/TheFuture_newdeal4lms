<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- option 태그만있음 select id=leclist -->
<!-- 주석 -->
			<option value="">--목록--</option> <!-- 전체 검색이 안되게 하려면 value="" 자체를 지우면된다? -->
			<c:forEach items="${selectBoxList}" var="resultVO" varStatus="status">				
			<option value="${resultVO.sturm_no}" >${resultVO.rm_name}</option>
			<!-- <input type="hidden" id="maxCnt${resultVO.sturm_no}" name="maxCnt${resultVO.sturm_no}" value ="${resultVO.rm_max}"/>
			 -->
			</c:forEach>									
				