<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/style.css">
<script type="text/javascript">
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
     });   //ddd
}

function editComments(comments_no, comments_content, board_no){
   var html = "<textarea id='commentsTextarea"+comments_no+"' class='boxC'>"+comments_content+"</textarea><button style='height: 40px;' id='commentsWritebtn' onclick='editCommentsA("+comments_no+","+board_no+")'>수정</button>";
   $("#commentsdiv"+comments_no).empty();
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
</script>
</head>
<body>
	<c:forEach items="${comments }" var="c">
		<div style="width: 100%; background: #dddfe6; height: 30px; padding: 5px; padding-left: 10px; border-radius: 10px;">
			<b>${c.member_nick } 님&ensp;</b>
			<div style="color: #FAFAFA; float: right; margin-right: 5px;">${c.comments_date }</div> 
				<!-- 댓글수정  댓글삭제 -->
				<c:if test="${c.member_nick eq sessionScope.member_nick }">
					<button class="btn" id="delbtn" onclick="editComments(${c.comments_no}, '${c.comments_content }', '${c.board_no }')" style="color:#292F6D; font-size: 9pt; margin:0; margin-bottom: 2px;">
					<img src="./img/edit.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px; ">수정</button>	
					<button class="btn" id="delbtn" onclick="delComments()" style="font-size: 9pt; margin:0; margin-bottom: 2px;">
					<img src="./img/close.png" style="width: 15px; height: 15px; padding:0; margin-bottom: 2px;">삭제</button>
				</c:if>
		 </div>
		<div id="commentsdiv${c.comments_no}" style="height: 40px; padding: 5px; padding-left: 10px;">
			${c.comments_content }
		</div><br>
</c:forEach>

<c:choose>
	<c:when test="${sessionScope.member_nick ne null}">
		<textarea id="commentsTextarea"></textarea>
		<button id="commentsWritebtn" onclick="writeComments('./writeComments','${sessionScope.member_no}', '${comments.get(0).board_no}')">댓글<br>쓰기</button>
	</c:when>
	<c:otherwise>
		<textarea disabled id="commentsTextarea" placeholder="로그인이 필요한 서비스입니다."></textarea>
		<button disabled id="commentsWritebtn">댓글<br>쓰기</button>
	</c:otherwise>
</c:choose>
</body>
</html>