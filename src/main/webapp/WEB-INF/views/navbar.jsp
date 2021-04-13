<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
#navbarlist, #navbarDarkDropdownMenuLink{
	 color: white;
}
</style>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    
<!-- 주아체 적용 -->	
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link rel="stylesheet" href="./css/style.css">
<nav class="navbar navbar-dark bg-dark navbar-fixed-top">
	<div class="container-lg" id="navbar">
		<a class="navbar-brand" href="" id="logo">STUDYYA</a>
		<ul class="nav nav-pills" >
			<li class="nav-item"><a class="nav-link" href="#" id="navbarlist">스터디모집</a></li>
			<li class="nav-item"><a class="nav-link" href="#" id="navbarlist">채팅</a></li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        	   		게시판
       	   		</a>
				<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
					<li><a class="dropdown-item" href="./board?key=free">자유게시판</a></li>
					<li><a class="dropdown-item" href="./board?key=qna">Q & A</a></li>
				</ul></li>
			<c:choose>
				<c:when test="${sessionScope.member_no ne null }">
					<div class="btn-group">
					  <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
					    <img src="./images/user.png" style="width: 28px; height:28px;">
					  </button>
					  <ul class="dropdown-menu dropdown-menu-end">
					  	<li>Action</li>
					  	<li>Another action</li>
						<li>Something else here</li>
						<li><hr class="dropdown-divider"></li>
					    <li><a class="dropdown-item" href="./logout">로그아웃</a></li>
					  </ul>
					</div>
				</c:when>
				<c:otherwise>
					<li class="nav-item"><a class="nav-link" href="./login" id="navbarlist">로그인</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>