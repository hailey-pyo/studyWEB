<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDYYA_boardWrite</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %><br>
<div class="container-lg">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
				<form action="./writeA" method="post" enctype="multipart/form-data">
					<c:choose>
						<c:when test="${map.board_no ne 0 }">
							<c:if test="${map.key eq 'qna'}">
								<div style="color:#f94e3f;float: right;">비밀글 
								<c:if test="${map.secret eq 'Y'}">
									<input type="checkbox" checked="checked" name="secret">
								</c:if>
								<c:if test="${map.secret eq 'N'}">
									<input type="checkbox" name="secret">
								</c:if>
								</div>
							</c:if>
							<input type="text" id="titleInput" name="board_title" value="${map.board_title }"><br>					
							<div id="attachfile">첨부 파일을 선택하세요 <input type="file" name="file" id="file"></div>							
							<textarea name="board_content" class="summernote">${map.board_content }</textarea>
							<input type="hidden" value="${map.board_no }" name="board_no">
							<button type="reset" onclick="location.href='./boardDetail?board_no=${map.board_no }'" id="cancelbtn">취소</button>
						</c:when>
					
						<c:otherwise>		
							<c:if test="${map.key eq 'qna'}">
								<div style="color:#f94e3f;float: right;">비밀글 <input type="checkbox" name="secret"></div>
							</c:if>				
							<input type="text" id="titleInput" name="board_title" placeholder="제목을 입력하세요"><br>
							<div id="attachfile">첨부 파일을 선택하세요 <input type="file" name="file" id="file"></div>							
							<textarea name="board_content" class="summernote"></textarea>
							<input type="hidden" value="${map.key }" name="key">
							<button type="reset" onclick="location.href='./board?key=${map.key}'" id="cancelbtn">취소</button>
						</c:otherwise>
					</c:choose>
					<button type="submit" id="writebtn">글쓰기</button>
				</form>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
				
				
<script type="text/javascript">
	var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	    ['insert',['picture','link','video']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];
	
	var setting = {
	    height : 500,
	    minHeight : null,
	    maxHeight : null,
	    focus : true,
	    lang : 'ko-KR',
	    toolbar : toolbar,
	 };
 
	$(document).ready(function() {
		$('.summernote').summernote(setting);
	});
</script>
</body>
</html>