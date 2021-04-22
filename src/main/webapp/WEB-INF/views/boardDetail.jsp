<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDYYA_boardDetail</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
   var html = "<textarea id='commentsTextarea"+comments_no+"' class='boxC'>"+comments_content+"</textarea><button style='height: 60px;' id='commentsWritebtn' onclick='editCommentsA("+comments_no+","+board_no+")'>수정</button>";
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
		var html = "<textarea id='cocommentsTextarea"+comments_no+"' class='boxC'></textarea><button style='height: 60px;' id='commentsWritebtn' onclick='cocommentsA("+comments_no+","+board_no+")'>답글</button>";
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
	height:60px; 
	margin-right:0;
	float:left; 
	border:1px solid #f94e3f;
	resize: none;
}
</style>
<!-- 신고하기, 좋아요 -->
<script type="text/javascript">
function blame(){
	if (confirm("신고하시겠습니까?")) {
		alert("신고완료 되었습니다.");
		location.href="./blame?board_no=${detail.board_no}";
	}
}
function good(member_no, board_no, board_type){
	   $.ajax({
		      url : "./good",
		      type : "POST",
		      dataType : "json",
		      data : {"member_no" : member_no, 
		    	  "board_no" : board_no, 
		    	  "board_type" : board_type }, 
		      success : function(data, txtStatus) {
		 			if(data.goodcheck == 1) {
			            $("#goodimg").attr("src", "./images/good_full.png");
		 			} else {
			            $("#goodimg").attr("src", "./images/good_empty.png");
		 			}
		 			
		            $("#goodCount").text(data.goodcount);
		      },             
		      error:function(request,status,error){
		         alert("잠시 후 다시시도해주세요");
		      }
		   });
}
</script>
</head>
<body>
<%@include file="navbar.jsp" %><br>
<div class="container-lg">
	<div class="row">
		<div class="col-md-1"></div>
				<div class="col-md-10">
						<table style="width: 100%;">
						<tr style="width: 100%;"> 
							<td style="width: 75%; font-size: 20pt;">${detail.board_title } <br></td>
								<td style="margin-top: 10px; width: 25%; margin-right: 5px;">
									<c:if test="${sessionScope.member_nick ne null }">
										<c:if test="${detail.member_nick eq sessionScope.member_nick }">
											<button class="btn" onclick="del(${detail.board_no})" style="float: right;">
						  					<img src="./img/close.png" style="width: 20px; height: 20px; margin-bottom: 3px; padding:0">삭제</button> <!-- 본문수정  본문삭제 -->
											<button class="btn" onclick="location.href='./boardDetail?key=${detail.board_type }&board_no=${detail.board_no }&act=write&secret=${detail.secret }'" style="margin-right: 10px; float: right; color:#292F6D;">
						  					<img src="./img/edit.png" style="width: 20px; height: 20px; margin-bottom: 3px; padding:0;">수정</button>
										</c:if>
									</c:if>
								</td>
						</tr>
						<tr> 
							<td style="vertical-align: bottom; text-align: left;">
							${detail.member_nick }&ensp;&ensp;&ensp;
							<span style="color: #a3a1a1;">${detail.board_date }</span>
							</td>
							<td style="text-align: right;">
							<img src="./img/views.png" style="width: 20px; height: 20px;">${detail.board_views }
							</td>
						</tr>
						</table>
							<hr style="height:1px;border:none;background-color:#a3a1a1;margin: 0; margin-bottom: 1px; margin-top: 2px;"> 
						<table style="background: #FAFAFA; margin:0; width:100%;">
							<tr  style="height: 500px; vertical-align:top;">
								<td style="text-align: left; padding: 10px;">${detail.board_content }</td>
							</tr>
							
							<tr style="height: 100px; vertical-align: middle;">
								<td><div style="margin: 0 auto; width: 150px;">
										<c:if test="${sessionScope.member_nick ne null }">
											<button class="btn" onclick="blame()" id="blamebtn"><img src="./images/siren.png">신고</button>
											<button class="btn" onclick="good('${sessionScope.member_no}','${detail.board_no }','${detail.board_type }')" id="goodbtn"> <!-- 좋아요 -->
												<c:if test="${goodcheck eq 0 }">
													<img id="goodimg" src="./images/good_empty.png">													
												</c:if>
												<c:if test="${goodcheck eq 1 }">
													<img id="goodimg" src="./images/good_full.png">													
												</c:if>
												 <div id="goodCount">${detail.board_likes}</div>
											</button>
										</c:if>
									</div>
								</td>
							</tr>
						</table>
					<hr style="height:1px;border:none;background-color:#a3a1a1;margin: 0;"> 
					<c:if test="${detail.board_file ne null}">
						<table style="border:1px solid #B2ADA0; margin:0; width:100%; height: 40px;">
							<tr><td style="padding-left: 10px;">
									<form action="file/download" method="POST">
										첨부파일: ${detail.board_file_origin } <button type="submit" id="downbtn">다운로드</button>
										<input type="hidden" name="fileName" value="${detail.board_file }">
										<input type="hidden" name="fileNameOrigin" value="${detail.board_file_origin }">
									</form>
							</td></tr>
						</table>
					</c:if>
					<hr style="height:1px;border:none;background-color:#a3a1a1;margin: 0; margin-bottom: 10px"> 
					<table style="margin:0; width:100%; text-align: left;">
						<tr>
							<td style="font-size: 15px; color:#6AAFE6;"><img src="./img/comments.png" style="width: 30px; height: 25px;"><b>댓글</b></td>
						</tr>
						<tr>
							<td>
							<div id="commentsdiv">
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
							</div>
							</td>
						</tr>
				</table>
			</div>
					
		<div class="col-md-1"></div>
	</div>
</div>
<br>
</body>
</html>