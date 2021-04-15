<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<c:forEach items="${comments }" var="c">
	<div style="width: 100%; background: #dddfe6; height: 30px; padding: 5px; padding-left: 10px; border-radius: 10px;">
		<form style="float:left;" action="./otherprofile" method="post" name="detail_form${c.comments_no }" id="detail_form${c.comments_no }"> <a href="#" onclick="commentprofilemove( '${c.comments_no }' )">
		<b>${c.member_nick } 님&ensp;</b>
		</a><input type="hidden" name="member_no" value="${c.member_no }"></form>
		<div id="boarddate${c.comments_no }" style="color: #FAFAFA; float: right; margin-right: 5px;">${c.comments_date }</div> 
			<c:if test="${sessionScope.member_nick  ne null }">
			<c:choose> 
			<c:when test="${c.member_nick eq sessionScope.member_nick }">
			<button class="btn" id="delbtn" onclick="editComments('./editCommentsF', ${c.comments_no })" style="color:#292F6D; font-size: 9pt; margin:0; margin-bottom: 2px;">
			<img src="./img/edit.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">수정</button>	<!-- 댓글수정  댓글삭제 -->
			<button class="btn" id="delbtn" onclick="delc(${c.comments_no},${detail.board_no })" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
			<img src="./img/close.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px;">삭제</button>
			</c:when>
			<c:otherwise>
			<button class="btn" id="delbtn" onclick="blame2(${c.board_no },${c.comments_no});" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
			<img src="./img/siren.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">댓글신고</button>
			</c:otherwise>
			</c:choose>
			</c:if>
	 </div>
	<div style="height: 40px; padding: 5px; padding-left: 10px;">${c.comments_content }</div><br>
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
</body>
</html>