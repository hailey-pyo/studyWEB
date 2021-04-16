<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/style.css">
<script type="text/javascript">
function del(board_no){
	if (confirm("삭제하시겠습니까?")) {
		location.href='boardDetail?key=${detail.board_type}&board_no='+board_no+'&act=del';
	}
}

function writeComments(url, member_no, board_no){
    var commentsTextarea = document.getElementById('commentsTextarea').value;
 	$.ajax({
        type : "POST",
        url : url,
        dataType : "text",
        data : {
      	   "comments_content" : commentsTextarea,
      	   "member_no" : member_no,
      	   "board_no" : board_no
         },
        success : function(data, txtStatus) {
            $('#commentsdiv').html(data);
        },
        error : function() {        	
           alert("잠시 후 다시시도 해주세요.");
        }
     });   
}

function editComments(comments_no, comments_content, board_no){
   var html = "<textarea id='commentsTextarea"+comments_no+"' class='boxC'>"+comments_content+"</textarea><button style='height: 40px;' id='commentsWritebtn' onclick='editCommentsA("+comments_no+","+board_no+")'>수정</button>";
   $("#commentsdiv"+comments_no).text("");
   $("#commentsdiv"+comments_no).append(html); 
}

function editCommentsA(comments_no, board_no){
    var commentsTextarea = document.getElementById('commentsTextarea'+comments_no).value;
    $.ajax({
        type : "POST",
        url : "./editCommentsA",
        dataType : "text",
        data : {
      	   "comments_content" : commentsTextarea,
      	   "comments_no" : comments_no,
      	   "board_no" : board_no
         },
        success : function(data, txtStatus) {
            $('#commentsdiv').html(data);
        },
        error : function() {        	
           alert("잠시 후 다시시도 해주세요.");
        }
     });    
}

function delComments(comments_no, board_no){
	if (confirm("삭제하시겠습니까?")) {
		location.href="delComments?comments_no="+comments_no+"&board_no="+board_no;
	}
}
function cocoments(comments_no, board_no){
	var html = "<textarea id='cocommentsTextarea"+comments_no+"' class='boxC'></textarea><button style='height: 40px;' id='commentsWritebtn' onclick='cocommentsA("+comments_no+","+board_no+")'>답글</button>";
	$("#cocobtn"+comments_no).remove();
	$("#cocommentsdiv"+comments_no).append(html); 
}

function cocommentsA(comments_no, board_no){
    var cocommentsTextarea = document.getElementById('cocommentsTextarea'+comments_no).value;
     $.ajax({
        type : "POST",
        url : "./cocommentsA",
        dataType : "text",
        data : {
      	   "comments_content" : cocommentsTextarea,
      	   "comments_no" : comments_no,
      	   "board_no" : board_no
         },
        success : function(data, txtStatus) {
            $('#commentsdiv').html(data);
        },
        error : function() {        	
           alert("잠시 후 다시시도 해주세요.");
        }
     });     
}
</script>
<style type="text/css">
.boxC{
	width:90%; 
	height:40px; 
	margin-right:0;
	float:left; 
	border:1px solid #f94e3f;
	resize: none;
}
</style>
</head>
<body>
<c:forEach items="${comments }" var="c">
		<c:if test="${c.comments_comments_no eq 0 }">
		<div style="width: 100%; background: #dddfe6; height: 30px; padding: 5px; padding-left: 10px; border-radius: 10px;">
			<b>${c.member_nick } 님&ensp;</b>
			<div style="color: #FAFAFA; float: right; margin-right: 5px;">${c.comments_date } <button id="cocobtn${c.comments_no }" class="cocobtn" onclick="cocoments(${c.comments_no}, ${c.board_no})">답글</button></div> 
				<!-- 댓글수정  댓글삭제 -->
				<c:if test="${c.member_nick eq sessionScope.member_nick }">
					<button class="btn" onclick="editComments('${c.comments_no}', '${c.comments_content }', '${c.board_no }')" style="color:#292F6D; font-size: 9pt; margin:0; margin-bottom: 2px;">
					<img src="./img/edit.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">수정</button>	
					<button class="btn" onclick="delComments(${c.comments_no},${c.board_no})" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
					<img src="./img/close.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px;">삭제</button>
				</c:if>
		 </div>
		<div id="commentsdiv${c.comments_no}" style="height: 60px; padding: 5px; padding-left: 10px;">
			${c.comments_content }
			<div id="cocommentsdiv${c.comments_no }"></div>
		</div>
		<br>
		</c:if>
		<c:forEach items="${comments }" var="co">
				<c:if test="${co.comments_comments_no eq c.comments_no }">
				<div style="width: 100%;">
					<div style="width: 8%; float: left; height:110px; text-align:right;">┗</div>
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
				<div id="commentsdiv${co.comments_no}" style="height: 110px; padding: 0; padding-left: 100px;">
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
</body>
</html>