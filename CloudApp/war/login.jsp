<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.cloud.*"%>
<html>
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
</style>
<title>Hello App Engine</title>
</head>

<body>
<div class="abc">
	 <img src="logo.jpg" style="width:50px;height:50px;"/> 
	<h1 align="center" style="color:red">Welcome to QuizUp</h1>
</div>
	<nav class="navbar navbar-inverse" role="navigation">
		<ul class="nav nav-pills" role="tablist">
			<li role="presentation" class="active"><a href="login.jsp">Login</a></li>
			<li><a href="signup">SignUp</a></li>
		</ul>
		</nav>
		<h3 align="center" style="color:red">Login</h3>
		<form class="form-horizontal" role="form" method="post" action="/login">
		<div class="abcd">
		<div class="form-group">
			<label for="inputEmail" class="col-sm-2 control-label">Email</label>
			<div class="col-sm-5">
				<input type="email" class="form-control" id="inputEmail"
					placeholder="Email" name="email">
			</div>
		</div>
		</div>
		<div class="abcd">
		<div class="form-group">
			<label for="inputPassword" class="col-sm-2 control-label">Password</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="inputPassword" name="password"
					placeholder="Password">
			</div>
		</div>
		</div>
		<div class="abcd">
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-primary">Log In</button>
			</div>
		</div>
		</div>
	</form>
	
	<div>
		<h2 id="displayMsg" align = "center">
			
		</h2>
	</div>
	<script type="text/javascript">
		document.getElementById("displayMsg").style.visibility = "hidden";
		<%
			if("SignedIn".equals(request.getParameter("q")))
{
%>
document.getElementById("displayMsg").style.visibility = "visible";
document.getElementById("displayMsg").style.color="red";

				document.getElementById("displayMsg").innerHTML = "Already Logged In...!! Please Log out From Other Place";
				
	<%}else if("WrongCredentials".equals(request.getParameter("q")))
		{
	%>
	document.getElementById("displayMsg").style.visibility = "visible";
	document.getElementById("displayMsg").style.color="red";
	document.getElementById("displayMsg").innerHTML = "Wrong Credentials...!!!";
	<%
		}
	%>
	</script>
</body>
</html>
