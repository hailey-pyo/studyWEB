<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
#navbarlist, #navbarDarkDropdownMenuLink{
	 color: white;
}
	
</style>
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
					<li><a class="dropdown-item" href="#">자유게시판</a></li>
					<li><a class="dropdown-item" href="#">Q & A</a></li>
				</ul></li>
			<c:choose>
				<c:when test="${sessionScope.member_no ne null }">
					<li class="nav-item"><a class="nav-link" href="#" id="navbarlist"><img src="/images/user.png"></a></li>
				</c:when>
				<c:otherwise>
					<li class="nav-item"><a class="nav-link" href="./login" id="navbarlist">로그인</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>