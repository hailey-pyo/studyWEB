<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDYYA_boardDetail</title>
<script type="text/javascript">
function del(board_no){
	if (confirm("삭제하시겠습니까?")) {
		location.href='boardDetail?key=${detail.board_type}&board_no='+board_no+'&act=del';
	}
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
											<button class="btn" onclick="location.href='./freewrite?board_no=${detail.board_no }'" id="delbtn" style="margin-right: 10px; float: right; color:#292F6D;">
						  					<img src="./img/edit.png" style="width: 20px; height: 20px; margin-bottom: 3px; padding:0;">수정</button>
										</c:if>
									</c:if>
								</td>
						</tr>
						<tr> 
							<td style="vertical-align: bottom; text-align: left;">
							<form action="./otherprofile" method="post" name="detail_form" id="detail_form">
							<img id="memPic" src="./memimg/${detail.member_pic }">&ensp;  
							<a href="#" onclick="profilemove()">
							${detail.member_nick }
							</a>&ensp;&ensp;&ensp;
							<span style="color: #a3a1a1;">${detail.board_date }</span>
							<input type="hidden" name="mem_no" value="${detail.mem_no }"></form>  
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
								<td><c:if test="${sessionScope.mem_nick ne null }">
											<button class="btn" onclick="blame(${detail.board_no});" style="background: #6AAFE6; color: white; padding-left:10px; padding-right: 10px;"><img src="./img/siren.png" style="width: 20px; height: 20px;">신고</button>
											<button class="btn" onclick="good()" style="display: inline; background: #6AAFE6; color: white; padding-left:10px; padding-right: 10px;"> <!-- 좋아요 -->
											<div style="display: inline; margin:0;  background: blue;">	
												<c:if test="${goodresult eq 0 }">
												<img id="goodimg" src="./img/good_empty.png" style="width: 20px; float: left; height: 20px;">													
												</c:if>
												<c:if test="${goodresult eq 1 }">
												<img id="goodimg" src="./img/good_full.png" style="width: 20px; float: left; height: 20px;">													
												</c:if>
												 <div id="goodCount" style="float: left; margin-left: 2px; font-size: 12pt;">${detail.board_good}</div></div></button>
									</c:if>
								</td>
							</tr>
						</table>
					<hr style="height:1px;border:none;background-color:#a3a1a1;margin: 0; margin-bottom: 10px"> 
					
					<table style="margin:0; width:100%; text-align: left;">
						<tr>
							<td style="font-size: 15px; color:#6AAFE6;"><img src="./img/comments.png" style="width: 30px; height: 25px;"><b>댓글</b></td>
						</tr>
						<tr>
							<td>
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
									<div id="commentsdiv${c.comments_no }" style="height: 40px; padding: 5px; padding-left: 10px;">${c.comments_content }</div><br>
								</c:forEach>
							</td>
						</tr>
						<tr style="width:100%;">
							<td>
								<form action="./freecomment" method="post">
										<c:choose>
											<c:when test="${sessionScope.member_nick ne null}">
											<textarea id="text" name="content"  style="width:90%; height: 100px; margin-right: 0;float: left; border: 1px solid #f94e3f;"></textarea>
											</c:when>
											<c:otherwise>
											<textarea id="text" name="content" disabled
												placeholder="로그인이 필요한 서비스입니다." style="width:90%; height: 100px; margin-right: 0;float: left; border: 1px solid #f94e3f;"></textarea>
											</c:otherwise>
										</c:choose>
									<c:choose>
										<c:when test="${sessionScope.mem_nick ne null}">
											<button style="width: 10%; height: 100px; margin-left:0; float: left; background: #f94e3f; color: white; border: none;"><b>댓글 쓰기</b></button>
										</c:when>
										<c:otherwise>
											<button disabled style="width:10%; height: 100px; margin-left:0; float: left; background: #f94e3f; color: white;border: none;">댓글 쓰기</button>
										</c:otherwise>
									</c:choose>		
								<input type="hidden" name="board_no"
									value="${detail.board_no }">
							</form>
						</td>
					</tr>
				</table>
			</div>
					
		<div class="col-md-1"></div>
	</div>
</div>
</body>
</html>