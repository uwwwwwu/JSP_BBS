<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
		int NO = 0;
		if(request.getParameter("NO") != null){
			NO = Integer.parseInt(request.getParameter("NO"));
		}
		if(NO == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(NO);
	%>
	<nav class ="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collaps  ed" data-toggle="collapse" data-target="#bs-example-navber-collapse-1" aria-expanded="false">
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
	<%
		BbsDAO bbsDAO = new BbsDAO();
		bbsDAO.getCOUNT(NO);
	%>
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align:center;">게시판</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글제목</td>
							<td colspan="2"><%= bbs.getTITLE().replaceAll(" ", "&nbsp;").replaceAll("<","&lt").replaceAll(">","&gt").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbs.getUSERID() %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getCONTENT().replaceAll(" ", "&nbsp;").replaceAll("<","&lt").replaceAll(">","&gt").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(USERID != null && USERID.equals(bbs.getUSERID())){
				%>
					<a href="update.jsp?NO=<%=NO %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?NO=<%=NO %>" class="btn btn-primary">삭제</a>
				<%
					}
				%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
	
	
</body>
</html>