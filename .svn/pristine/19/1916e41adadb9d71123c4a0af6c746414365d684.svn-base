<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
					<div class="divEmpty">
						<div class="hiddenData">
							<span id="totalcnt"></span>
						</div>
						<table class="col">
									
							<tbody id="testResultque">

										<tr>
											<th scope="row">시험명</th>
				 							<td>${applytestList[0].test_name}</td> 
											<th scope="row">점수</th>
											<td style="font-weight:bold; color:black">${testresultList[0].total_score}점</td>
										</tr>
										<tr>
											<th scope="row">강의명</th>
											<td>${applytestList[0].lec_name}</td>
											<th scope="row">시험제출일</th>
											<td>${testresultList[0].res_regdate}</td>
										</tr>
										<tr>
											<th colspan="4">시험 결과 확인</th>
										</tr>
										

	
		
				
						<c:forEach items="${applytestList}" var="testList" varStatus="num">
									  <tr>
									    <td colspan="4" id="que_content">
									      <span>${num.count}. </span>
									      <span style="font-weight: bold">${testList.que_content}</span>
									    </td>
									  </tr>
									  
									  <tr style="line-height: 25px;">
									    <td colspan="4">
																					      <input type="radio" id="test${testList.que_no}1" name="test${testList.que_no}" value="1"
																					        <c:if test="${testresultList[num.index].res_ans eq '1'}">checked="checked"</c:if>
																					        <c:if test="${testresultList[num.index].res_ans ne '1'}">disabled="disabled"</c:if>
																					      >&nbsp; ${testList.opt_1}<br>
																					      
																					      <input type="radio" id="test${testList.que_no}2" name="test${testList.que_no}" value="2"
																					        <c:if test="${testresultList[num.index].res_ans eq '2'}">checked="checked"</c:if>
																					        <c:if test="${testresultList[num.index].res_ans ne '2'}">disabled="disabled"</c:if>
																					      >&nbsp; ${testList.opt_2}<br>
																					      
																					      <input type="radio" id="test${testList.que_no}3" name="test${testList.que_no}" value="3"
																					        <c:if test="${testresultList[num.index].res_ans eq '3'}">checked="checked"</c:if>
																					        <c:if test="${testresultList[num.index].res_ans ne '3'}">disabled="disabled"</c:if>
																					      >&nbsp; ${testList.opt_3}<br>
																					      
																					      <input type="radio" id="test${testList.que_no}4" name="test${testList.que_no}" value="4"
																					        <c:if test="${testresultList[num.index].res_ans eq '4'}">checked="checked"</c:if>
																					        <c:if test="${testresultList[num.index].res_ans ne '4'}">disabled="disabled"</c:if>
																					      >&nbsp; ${testList.opt_4}<br>
																					      
													
																			      <span>
																			        <c:choose>
																			          <c:when test="${testresultList[num.index].res_ans eq testList.answer}">
																			            <span style="color: #868686;">정답 : ${testList.answer}번</span>
																			          </c:when>
																			          <c:otherwise>
																			            <span style="color: red;">정답 : ${testList.answer}번</span>
																			          </c:otherwise>
																			        </c:choose>
																			      </span>
									    </td>
									  </tr> 
						</c:forEach>



													


												
							</tbody>
						</table>
					</div>
					
					
					
					
	
							