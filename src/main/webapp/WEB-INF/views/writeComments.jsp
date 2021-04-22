<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<meta charset="UTF-8">

<c:forEach items="${comments }" var="c">
	<c:if test="${c.comments_comments_no eq 0 }">
	
	<div style="width: 100%; background: #dddfe6; height: 30px; padding: 5px; padding-left: 10px; border-radius: 10px;">
		<b>${c.member_nick } 님&ensp;</b>
			<c:if test="${sessionScope.member_nick ne null}">
				<button id="cocobtn${c.comments_no }" class="cocobtn" onclick="cocoments(${c.comments_no}, ${c.board_no})">답글</button>
			</c:if>
			<div style="color: #FAFAFA; float: right; margin-right: 5px;">${c.comments_date } </div>
			<!-- 댓글수정  댓글삭제 -->
			<c:if test="${c.member_nick eq sessionScope.member_nick }">
				<button class="btn" onclick="editComments('${c.comments_no}', '${c.comments_content }', '${c.board_no }')" style="color:#292F6D; font-size: 9pt; margin:0; margin-bottom: 2px;">
				<img src="./img/edit.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">수정</button>	
				<button class="btn" onclick="delComments(${c.comments_no},${c.board_no})" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
				<img src="./img/close.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px;">삭제</button>
			</c:if>
	</div>
	<div id="commentsdiv${c.comments_no}" style="word-break: break-all; height: 60px; width: 100%; padding: 5px; padding-left: 10px;">
		${c.comments_content }
	</div>
	<div id="cocommentsdiv${c.comments_no }" style="width: 100%; height: 60px;"></div>
	
	<br>
	</c:if>
	<c:forEach items="${comments }" var="co">
			<c:if test="${co.comments_comments_no eq c.comments_no }">
			<div style="width: 100%;">
				<div style="width: 8%; float: left; height:30px;text-align:right;">┗</div>
				<div style="width: 92%; float: left; background: #dddfe6; height: 30px; padding: 5px; padding-left: 10px; border-radius: 10px;">
				<b>${co.member_nick } 님&ensp;</b>
				<div style="color: #FAFAFA; float: right; margin-right: 5px;">${c.comments_date }</div> 
					<!-- 댓글수정  댓글삭제 -->
					<c:if test="${co.member_nick eq sessionScope.member_nick }">
						<button class="btn" onclick="editComments('${co.comments_no}', '${co.comments_content }', '${co.board_no }')" style="color:#292F6D; font-size: 9pt; margin:0; margin-bottom: 2px;">
						<img src="./img/edit.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">수정</button>	
						<button class="btn" onclick="delComments(${co.comments_no},${co.board_no})" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
						<img src="./img/close.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px;">삭제</button>
					</c:if>
			 </div>
			<div id="commentsdiv${co.comments_no}" style="word-break: break-all; height: 150px; padding: 0; padding-left: 110px;">
				${co.comments_content }
			</div>
			</div><br>
			</c:if>
	</c:forEach>
</c:forEach>

<c:choose>
	<c:when test="${sessionScope.member_nick ne null}">
		<textarea id="commentsTextarea"></textarea>
		<button id="commentsWritebtn" onclick="writeComments('./writeComments','${sessionScope.member_no}', '${detail.board_no}')">댓글<br>쓰기</button>
	</c:when>
	<c:otherwise>
		<textarea disabled id="commentsTextarea" placeholder="로그인이 필요한 서비스입니다."></textarea>
		<button disabled id="commentsWritebtn">댓글<br>쓰기</button>
	</c:otherwise>
</c:choose>
