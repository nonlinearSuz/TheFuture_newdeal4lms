<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>			
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${roomsearchlist}" var="list">
									<tr>
										<td><a href="javascript:fn_itemlistsearch(1, '${list.room_no}')">${list.rm_name}</a></td>
										<td>${list.rm_max}</td>
										<td>${list.rm_size}</td>
										<td>
											<c:choose>
												<c:when test="${not empty list.upd_user }">${list.upd_user}</c:when>
												<c:otherwise>${list.enr_user}</c:otherwise>
											
											</c:choose>
										</td>
										
										<td>
											<c:choose>
												<c:when test="${not empty list.upd_date }">${list.upd_date}</c:when>
												<c:otherwise>${list.enr_date}</c:otherwise>
											
											</c:choose>
										</td>
											<c:choose>
                              					<c:when test="${list.rm_yn eq 'Y'}">
                                  					<td><font color="blue">사용</font></td>
                             					</c:when>
                             					 <c:otherwise>
                                  					<td><font color="red">미사용</font></td>
                              					</c:otherwise>
                              				</c:choose>
										<td>
											<a class="btnType3 color2" href="javascript:fn_selectone('${list.room_no}')"><span>수정</span></a>
										 <%--   <a class="btnType3 color2" href="javascript:fn_usability('${list.room_no}')"><span>예약</span></a> --%>
										 </td>
										
										
										
									</tr>
								</c:forEach>
							</c:if>
				
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
							<input type="hidden" id="LL_room_no"  name="LL_room_no" value ="${room_no}" />