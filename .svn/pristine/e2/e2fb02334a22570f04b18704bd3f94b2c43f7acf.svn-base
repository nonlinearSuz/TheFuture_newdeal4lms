<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
      <dl>
         <dt>
            <strong>Q&A</strong>
         </dt>
         <dd class="content">
            	 <div class="sidescroll" style="height: 400px; overflow: auto !important">
				<table class="row">
					<caption>caption</caption>
					<colgroup>
                                 <col width="20%">
                                 <col width="40%">
                                 <col width="40%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">글제목</th>
							<td colspan="2"><input type="text" class="inputTxt p100"  id="title"  value="${qnasearch.qna_title }"/></td>
						</tr>
						<tr>
							<th scope="row">카테고리</th>
							<td  colspan="2">
								<select id="category_namepopup2" name="category_namepopup2" >
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td colspan="2"  id="qna_writer" >${qnasearch.enr_user }</td>
						</tr>
						<tr>	
							<th scope="row">작성일</th>
							<td colspan="2" id="qna_date" >${qnasearch.enr_date }</td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="2">
							   <textarea style="border:#e5e5e5;" class="inputTxt p100 qna_contentsTo" id="qna_contentsTo" name="qna_contentsTo">${qnasearch.qna_contents }</textarea>
							</td>
						</tr>
						<c:if test="${qnasearch.enr_user eq sessionScope.loginId}">
						<tr>
						<td colspan="3" align="right">
							<a href="javascript:fn_saves(${qnasearch.qna_no });" class="btnType4 color2" id="btnUpdate" name="btn"><span>수정</span></a>
							<a href="javascript:fn_saved(${qnasearch.qna_no });" class="btnType4 grey" id="btnDelete" name="btn"><span>삭제</span></a> 
						</td>
						</tr>
						</c:if>		
						<tr>
							<th colspan="3">댓글</th>
						</tr>
						 <tr>
		                     <th scope="row">댓글 작성자</th>
		                     <th scope="row">댓글 내용</th>
		                     <th scope="row">댓글 작성일</th>

                 		 </tr>
                 		 	<c:if test="${empty qnaRvList}">
						        <tr>
						            <td colspan="3" align="center">댓글이 없습니다.</td>
						        </tr>
						    </c:if>
						    
						   <c:if test="${not empty qnaRvList}">
						        <c:forEach items="${qnaRvList}" var="reply">
						          <c:if test="${reply.enr_user eq sessionScope.loginId}">
						            <tr>
							                <td colspan="1">${reply.enr_user}</td>
							                <td colspan="1">
							                    <input style="height:28px; width:100%;" type="text" name="rpy_contents${reply.rpy_no}" id="rpy_contents${reply.rpy_no}" value="${reply.rpy_contents}">
							                </td>
							                <td><span style="line-height:2.2">${reply.enr_date}</span>
								                <span>
								                        <a class="btnType4 grey" href="javascript:fn_replyed(${reply.rpy_no});" id="btnReplyDelete" name="btn"><span>삭제</span></a>
								                        <a style="margin-right: 3px" class="btnType4 color2" href="javascript:fn_replyes(${reply.rpy_no});" id="btnReplyUpdate" name="btn"><span>수정</span></a>
								                </span>
							                
							                </td>

						          </tr>
						        </c:if>
						        <c:if test="${reply.enr_user  ne sessionScope.loginId}">
						            <tr>
						                <td>${reply.enr_user}</td>
						                <td>
						                <input style="border:0; width:100%;" type="text" name="rpy_contents${reply.rpy_no}" id="rpy_contents${reply.rpy_no}" value="${reply.rpy_contents}"  readonly>
						               
						                </td>
						                <td>${reply.enr_date}</td>
				
						            	</tr>
						             </c:if>
						        </c:forEach>
						    </c:if>
						
					</tbody>
				</table>
				</div>

						<div style="margin-top:30px; text-align:center;">
				            <input type="text"  id="rpy_content" style="height: 28px; width: 460px;">
				            <a href="javascript:fn_reply();" class="btnType blue" id="btnReply" name="btn" ><span>댓글 작성</span></a>
					</div>
         </dd>
      </dl>
      <a href="" class="closePop" id="closeReplyPop"><span class="hidden">닫기</span></a>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt }"/>
	<input type="hidden" id="qna_no"  name="qna_no"  />
	<input type="hidden" id="reaction"  name="reaction"  />
	<input type="hidden" id="rpy_no"  name="rpy_no" />
	<input type="hidden" id="pageno"  name="pageno"  />