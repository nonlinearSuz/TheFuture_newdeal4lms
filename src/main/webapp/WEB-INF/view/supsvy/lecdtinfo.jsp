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
								<c:forEach items="${lectureDetailedInfo}" var="list">
									<table class="col">
									        <caption style="">
									          caption
									        </caption>
									        <colgroup class="col" width="30%"></colgroup>
									        <colgroup class="col" width="20%"></colgroup>
									        <colgroup class="col" width="20%"></colgroup>
									        <colgroup class="col" width="10%"></colgroup>
									       
									          <thead>
									            <tr>
									              <th scope="col">강의명</th>
									              <th scope="col">강사</th>
									              <th scope="col">강의 기간</th>
									              <th scope="col">강의실</th>
									            </tr>
									          </thead>
									          <tbody>
									            <td id="lec_name"><%-- ${list.lec_name} --%></td>
									            <td id="name"><%-- ${list.name} --%></td>
									            <td id=""><span id="lec_start"></span><span id="lec_end"></span><%-- ${list.lec_start}~${list.lec_end} --%></td>
									            <td id="rm_name">${list.rm_name}</td>
									          </tbody>
									        </table>
									        
									        <table class="col">
									          <thead>
									          	<tr>
									            	<th style="text-align:left; padding-left:20px" scope="">강의 내용</th>
									            </tr>
									          </thead>
									          <tbody>
									          		<td id="lec_contents">${list.lec_contents}</td>
									          </tbody>
									        </table>
									        
									        <table class="col">
									          <thead>
									            <tr>
									              <th style="text-align:left; padding-left:20px">강의목표</th>
									            </tr>
									          </thead>
									          <tbody>
									            <tr>
									              <td id="lec_goal">${list.lec_goal}</td>
									            </tr>
									          </tbody>
									        </table>
									        <table class="col">
									          <thead>
									            <tr>
									              <th style="text-align:left; padding-left:20px">설문 응시 가능 여부</th>
									            </tr>
									          </thead>
									          <tbody>
									            <tr style="display:flex;">
									              <td id="rs_yn" style="dipslay:inlnie-block; width:100%; text-align:left; padding-left:20px ">설문응시가 가능합니다.<a style="float:right;"href="" class="btnType blue"  id="" name="btn"><span>설문 응시</span></a></td>
									            </tr>
									          </tbody>
									        </table>		
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/> 