<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"  content="width=device-width", initial-scale="1">
<link rel="shortcut icon" href="./img/logo.ico">
<link rel ="stylesheet" href="css/bootstrap.css">
<title>jsp 웹 사이트</title>
</head>
<body>
	<%
		String USERID = null;
		if(session.getAttribute("USERID") != null){
			USERID = (String)session.getAttribute("USERID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<li><a href="main.jsp">메인</a>
				<li class="active"><a href="main.jsp">게시판</a>
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
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i < list.size(); i++){
						
				%>
				<tr>
					<td><%= list.get(i).getNO()%></td>
					<td><a href="view.jsp?NO=<%= list.get(i).getNO()%>"><%= list.get(i).getTITLE()%></a></td>
					<td><%= list.get(i).getUSERID()%></td>
					<td><%= list.get(i).getCOUNT()%></td>
				</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
	
	
</body>
</html>