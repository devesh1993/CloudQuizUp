<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.cloud.*" %>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<style>
.abc img {
  float: left;
  width: 100px;
  height: 100px;
  background: #555;
  margin-left:500px;
}

.abc h1 {
  left: 10px;
  margin-right:475px;
}
.abcd{
margin-left:320px;
}
.abcde{
margin-left:600px;
}
</style>
</head>
<body>
<form action = "/selectTopic">
<div class="abc">
	 <img src="logo.jpg" style="width:50px;height:50px;"/> 
	<h1 align="center" style="color:red">Welcome to QuizUp</h1>
</div>
<nav class="navbar navbar-inverse" role="navigation">
		<ul class="nav nav-pills" role="tablist" >
			<!--  <td><a href="./admin_module/admin_main.jsp?opt=0">Admin</a></td>-->
			<!-- <li><a href="login.html">Login</a></li>
			<li role="presentation" class="active"><a href="signup">SignUp</a></li>-->
		</ul>
		</nav>
		
		<h3 align="right">
		<%
		String email = new String();
		Cookie cookie = null;
		Cookie[] cookies = null;
		cookies = request.getCookies();
		if (cookies != null) 
		{
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if (cookie.getName().equals("email")) {
					email = cookie.getValue();
				}
			}
		}
	out.println(email + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		%>
		</h3>
	<h3 align="center" style="color:red">Select Topic</h3>
<select class="form-control" name="topic" style="margin-left:550px;width:20%;">
		  <option>Select Topic</option>
		  <%
		  	adminFunctions funcs = new adminFunctions();
		  	ArrayList<String> allTopics = new ArrayList<String>();
		  	allTopics = funcs.getAllTopics();
			for (int i=0;i<allTopics.size();i++) {
				String command = "<option value=\"" + allTopics.get(i) + "\">" + allTopics.get(i) + "</option>";
				out.println(command);
			}
		  %>
		</select><br>
		<button type="submit" class="btn btn-primary" style="width:5%;margin-left:650px;">OK</button>
</form>
</body>