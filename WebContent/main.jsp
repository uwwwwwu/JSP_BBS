<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"  content="width=device-width", initial-scale="1">
<link rel="shortcut icon" href="./img/logo.ico">
	<script type="text/javascript" src=" http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="./js/jquery.FadeWideBgImg.js"></script>
	<script type="text/javascript">	
		(function($){		
		jQuery(document).ready(function(){
			$('.slideshow').FadeWideBgImg({interval:2000});		
		});	
		}(window.jQuery,window));	
	</script>
<link rel ="stylesheet" href="css/bootstrap.css">
<title>jsp 웹 사이트</title>
</head>
<body>
	<%
		String USERID = null;
		if(session.getAttribute("USERID") != null){
			USERID = (String)session.getAttribute("USERID");
		}
	%>
	<nav class ="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navber-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Diet</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			
			<%
				if(USERID == null){
			%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
									aria-haspopup="ture" aria-expanded="false">접속하기 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href ="join.jsp">회원가입</a></li>
							</ul>
						</li>
					</ul>
			
			<%
				} else {
			%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
									aria-haspopup="ture" aria-expanded="false">회원관리 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="logoutAction.jsp"><%= USERID %>님 로그아웃</a></li>
							</ul>
						</li>
					</ul>
			
			<%
				}
			%>	
		</div>
	</nav>
	<div style="width:100%;position:absolute;z-index:1">
    <ul class="slideshow">		    	    
    	<li><img src="./img/main1.png" /></li>
    	<li><img src="./img/main2.png" /></li>
    	<li><img src="./img/main3.png" /></li>
	</ul>
</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
	
	
</body>
</html>