<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		if(USERID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
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
		if(!USERID.equals(bbs.getUSERID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
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
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
									aria-haspopup="ture" aria-expanded="false">회원관리 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="logoutAction.jsp"><%= USERID %>님 로그아웃</a></li>
							</ul>
						</li>
					</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?NO=<%=NO%>">
				<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align:center;">글 수정 </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name ="TITLE" maxlength="50" value="<%=bbs.getTITLE()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control"  placeholder="글 내용" name ="CONTENT" maxlength="50" style="height: 350px;"><%=bbs.getCONTENT()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
			
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
	
	
</body>
</html>