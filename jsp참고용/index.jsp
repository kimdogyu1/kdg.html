<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<title>Dok y contents</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width" />
<link href="https://fonts.googleapis.com/css?family=Anton|Lobster"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
  function backgroundset(self) {
    var target = document.querySelector('.img-button');
    if (target.dataset.mode === 'On') {
      target.style.backgroundImage = 'url(images/Moon.jpg)';
      target.dataset.mode = 'Off';

    }
    else {
      target.style.backgroundImage = 'url(images/sun.jpg)';
      target.dataset.mode = 'On';
    }
  }

  function Switch(self){
    var target = document.querySelector('body');
    if (target.dataset.mode === 'On'){
      target.style.background = "linear-gradient(180deg, black, orange)";
      target.dataset.mode = 'Off';

      // backgroundset(1);
      // self.value = 'Off';
    }
    else {
      target.style.backgroundImage = 'none';
      target.style.backgroundColor = 'black';
      target.dataset.mode = 'On';

      // self.value = 'On';
    }
  }
  </script>
<style>
body {
	margin: auto;
	background: linear-gradient(180deg, black, orange);
	background-size: cover;
	font-family: 'Anton', sans-serif;
}

h1 {
	font-size: 50px;
	font-style: italic;
	text-align: center;
	text-decoration: none;
	margin: 0;
	padding: 20px;
	text-shadow: 3px 2px gray;
}

h2 {
	color: white;
	font-style: italic;
	font-size: 40px;
	text-decoration: none;
	margin: 0;
	padding: 10px;
	text-shadow: 3px 2px orange;
	padding-bottom: 20px;
}

ul {
	font-style: italic;
	font-family: 'Anton', sans-serif;
	width: 300px;
	margin: 10px;
	padding: 5px;
	color: white;
}

.box1 {
	border-bottom: 1px solid #80808075;
	padding: 3px;
	text-decoration: none;
}

.img-button {
	background: url("images/Moon.jpg") no-repeat;
	background-color: black;
	border: 2px solid black;
	border-radius: 50%;
	width: 32px;
	height: 32px;
	cursor: pointer;
}

.img-button:active {
	transform: translateY(4px);
}

.fontsize30px {
	font-size: 30px;
	text-decoration: none;
	color: Orange;
}

@media screen and (max-width: 447px) {
	body {
		margin: auto;
		background-image: none;
		background-color: black;
	}
	.img-button {
		background: none;
		cursor: none;
	}
}
</style>
</head>
<body>
	<h1>
		<a href="index.html" class="box1" style="color: orange;"> Dok Y
			Contents</a>
	</h1>
	<p style="margin-top: 50px;">
	<h2 style="padding-left: 40px;">
		Contents <input
			style="color: orange; width: 36px; padding-right: 3px; padding-left: 3px; margin-left: 20px;"
			type="button" value="" class="img-button"
			onclick="
      Switch(this);backgroundset(this);
      ">
	</h2>

	<ul style="padding-left: 40px;">
		<li><a href="login.jsp" class="fontsize30px">Website</a></li>
		<p style="padding-top: 100px" ; style="margin-top:100px;">
		<li><a href="#" class="fontsize30px">Video</a></li>
		<p style="padding-top: 100px" ; style="margin-top:100px;">
		<li><a href="https://github.com/kimdogyu1/kdg.html"
			target="_black" class="fontsize30px">Github Page</a></li>
		<p style="padding-top: 50px" ; style="margin-top:50px;">
	</ul>
	<% 
	String userID = null;
	if (session.getAttribute("userID")!= null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber")!= null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	
	<style>
	td {
	border : 1px solid black;
	width:80px;
	}
	</style>
	
<footer>
	<h2 style = "text-align: center;">Q & A</h2>
		<table class="index_table" style="border: 1px solid black; 
		width: 500px; margin: 50px auto; border-spacing: 5px 5px;">
	<tr>
		<td>글 번호</td>
		<td>글 제목</td>
		<td>작성자</td>
	</tr>

	
	<% 
	BbsDAO bbsDAO = new BbsDAO();
	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
	for(int i = 0; i < list.size(); i++) {
		%>
	<tr>
		<td><%= list.get(i).getBbsID() %></td>
		<td><a href ="writeresult.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle()%></a></td>
		<td><%= list.get(i).getUserID() %></td>
	</tr>

	<%
		}
		%>
	</table>
	<%
	if(pageNumber !=1) {
		%>
		<a href="bbs.jsp?pageNumber=<%=pageNumber -1%>"> 이전  </a>;
	<%} if(bbsDAO.nextPage(pageNumber+1)) {	
	%>
	<a href="bbs.jsp?pageNumber=<%=pageNumber +1%>"> 다음  </a>;
	<%
	}
	%>
	
	</footer>
</body>
</html>
