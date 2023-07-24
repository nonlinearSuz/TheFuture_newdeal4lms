<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				

							<c:if test="${totalque eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
						<c:if test="${totalque > 0 }">
							<c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
								<c:forEach items="${examdetaillist}" var="list">
									<tr>
												<td>${list.que_no}</td>
												<td>${list.que_content}</td>
												<td>${list.opt_1}</td>
												<td>${list.opt_2}</td>
												<td>${list.opt_3}</td>
												<td>${list.opt_4}</td>
											   <td><a class="btnType3 color1" href="javascript:openModalTestDetail('${list.test_no}','${list.que_no}');"><span>수정</span></a></td>
										</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							 		<input type="hidden" id="totalque" name="totalque" value ="${totalque}"/>
		