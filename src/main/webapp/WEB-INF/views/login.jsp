<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<!-- 주아체 적용 -->	
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

<meta charset="UTF-8">
<title>STUDYYA_login</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
<div class="container-lg" id="loginPage">
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4" style="background: lime;">
			<div id="logo" style="text-align: center; margin-top: 90px;"><h3>STUDYYA</h3></div><br>
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=07a4866764e4fbb516a852ed2f5f70f9&redirect_uri=http://localhost:8080/web/login/kakaologin&response_type=code"><img src="./images/kakao_btn3.png"></a>
			<button>네이버로 로그인</button>
		</div>
		<div class="col-md-4"></div>
	</div>
</div>







<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>