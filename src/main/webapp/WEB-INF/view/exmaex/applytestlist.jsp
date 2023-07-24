<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
					<div class="divEmpty">
						<div class="hiddenData">
							 <span id="totalcnt">${totalcnt}</span>
						
						</div>
						<table class="col">
				
							
							<tbody id="testExamForm">
								<input type="hidden" value="${testList[0].test_no}" name="test_no">
								<input type="hidden" value="${testList[0].lec_no}" name="lec_no">
								<input type="hidden" value="${testList[0].lec_no}" name="lec_no">
								<input type="hidden" value="${applytestcnt}" name="applytestcnt" id="applytestcnt">
								<input type="hidden" value="${qlist}" name="qlist" id="qlist">
															
									<tr>
										<th scope="row">시험명</th>
				 						<td colspan="3">${applytestList[0].test_name}</td> 
									</tr>
									<tr>
										<th scope="row">강의명</th>
										<td>${applytestList[0].lec_name}</td>
										<th scope="row">강사명</th>
										<td>${applytestList[0].name}</td>
									
									</tr>
									<tr>
										<th colspan="4">시험문제영역</th>
									</tr>
				
									
									<c:forEach items="${applytestList}" var="testList" varStatus="num">
									
										<tr>
											<td colspan="4" id="que_content">
											<span>${num.count}. </span>
											<span style = "font-weight : bold">${testList.que_content}</span>
											</td>
										</tr>
										
										<tr style="line-height: 25px;">
											<td colspan="4">
													<input type="radio" id="test${testList.que_no}1" name="test${testList.que_no}" value="1">
														${testList.opt_1}<br>
													<input type="radio" id="test${testList.que_no}2" name="test${testList.que_no}" value="2">
														${testList.opt_2}<br>
													<input type="radio" id="test${testList.que_no}3" name="test${testList.que_no}" value="3">
														${testList.opt_3}<br>
													<input type="radio" id="test${testList.que_no}4" name="test${testList.que_no}" value="4">
														${testList.opt_4}<br>
										   	
											</td>   
										</tr>
																			
									</c:forEach>
							</tbody>
						</table>
					</div>
					
					
					
				
							