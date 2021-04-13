<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDYYA_board</title>
<script type="text/javascript">
function writeBoard(member_no, board_type){
	if (member_no == null || member_no == "") {
		alert("로그인 후 이용가능합니다.");
	}else {
		location.href='writeBoard?board_type='+board_type;
	}
}	
</script>
<script type="text/javascript">
	function linkPage(pageNo, board_type){
		location.href = "board?key=${boardList.get(0).board_type}&pageNo="+pageNo;
	}	
</script>
</head>
<body>
<%@include file="navbar.jsp" %>
<div class="container-lg">
	<div>
		<div id="intro">
			<c:if test="${boardList.get(0).board_type eq 'free' }">
				자유게시판	
			</c:if>
			<c:if test="${boardList.get(0).board_type eq 'qna' }">
				Q & A
			</c:if>
		</div>
		<button onclick="writeBoard('${sessionScope.member_no }', '${boardList.get(0).board_type}')" id="writebtn">글쓰기</button>
		
	</div>
	<table class="table table-hover table-sm">
		<thead>
			<tr>
				<th  style="width: 12.5% ; text-align: center;">좋아요</th>
				<th  style="width: 40%; text-align: center;">제목</th>
				<th style="width: 15%; text-align: center;">닉네임</th>
				<th style="width: 12.5%;text-align: center;">조회수</th>
				<th style="width: 20%; text-align: center;">날짜</th>
			</tr>
		</thead>
		<tbody style="text-align: center;">
			<c:forEach items="${boardList }" var="row">
			<tr>
				<td>${row.board_likes }</td>
				<td style="text-align: left;">
					<a href="./detail?no=${row.board_no }" style="text-decoration: none;color: black;">
						${row.board_title } <span>(${row.comments })</span>
					</a>
				</td>
				<td>${row.member_nick }</td>
				<td>${row.board_views }</td>
				<td>${row.board_date }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div id="pagingbtn">
	<ui:pagination paginationInfo = "${paginationInfo}"
			type="text"
			jsFunction="linkPage"/>
	</div>
</div>

</body>
</html>