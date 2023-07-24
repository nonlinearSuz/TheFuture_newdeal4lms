<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalexam eq 0 }">
								<tr>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalexam > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
								<c:forEach items="${examsearchlist}" var="list">
									<tr>
										<td>${list.test_no}</td>
										<td><a href="javascript:fn_ListTestDetail(1, '${list.test_no}', '${list.test_name}')">${list.test_name}</a></td>
										<td>
											<a class="btnType3 color1" href="javascript:openModalExam('${list.test_no}');"><span>수정</span></a>
										</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalexam" name="totalexam" value ="${totalexam}"/>