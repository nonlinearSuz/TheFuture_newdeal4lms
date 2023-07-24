 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<tbody id="surveyQ">
		             		<c:if test="${totalcnt eq 0 }"></c:if>
		             		<c:forEach items="${surveyFormList}" var="svy">
		             			<tr id="">
										<th scope="row">Q${svy.sv_qst_no}. ${svy.qst_content}</th>
										<td colspan="6">
											<!-- 문제 보기 영역 for하나더...-->
												<input type="radio" name="answer${svy.que_num}" id="answer" value="1">
													${svy.que_one}
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="2">
													${svy.que_two}
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="3">
													${svy.que_three}
											<c:if test="${svy.que_four ne null}">
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="4">
													${svy.que_four} </c:if>
											<c:if test="${svy.que_five ne null}">	
												<br><input type="radio" name="answer${svy.que_num}" id="answer" value="5">
													${svy.que_five}</c:if>
										</td>  
								</tr>
		             		</c:forEach>
		            		</tbody>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/> 