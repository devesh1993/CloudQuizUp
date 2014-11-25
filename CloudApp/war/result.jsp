<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query.*"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.cloud.*"%>

<head>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
</head>
<body>
<br>
<p align="right">
<a href="home.jsp"><button class="btn btn-primary">Play Again</button></a>
<a href="logout.jsp"><button class="btn btn-primary">Log
			Out</button></a>
			</p>
<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
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
%>
<h3><%out.println(email); %></h3>
<%
Key k = KeyFactory.createKey("OnlineUser", email);
Query q = new Query(k);
PreparedQuery pq = datastore.prepare(q);

Entity entity = pq.asList(FetchOptions.Builder.withDefaults()).get(0);

int rightAns = 0;
int myscore = Integer.parseInt(entity.getProperty("score").toString());
String opponent = ResponseServlet.getOpponent(email);

k = KeyFactory.createKey("OnlineUser", opponent);
q = new Query(k);
pq = datastore.prepare(q);

entity = pq.asList(FetchOptions.Builder.withDefaults()).get(0);

int opponentScore = Integer.parseInt(entity.getProperty("score").toString());

System.out.println("my score "+myscore+" opp score "+opponentScore);
if(myscore > opponentScore)
{
%>
	<H1>YOU WIN!!</H1>
<%	
}
else if(myscore == opponentScore)
{
%>
	<H1>IT IS TIE!!</H1>
<% 	
}
else
{
	
%>
	<H1>SORRY BUDDY, YOU LOSE!! BETTER LUCK NEXT TIME!!</H1>

<%	
}
%>


<h3 align = "center">
<p align = "center" style="color:blue"><h2>Final score : <%out.print(myscore); %><h2></p>
<%
for(int i=1;i<=5;i++)
{
	out.print("<p style = \"color:");
	if(entity.getProperty("answer"+i).toString().equals("right"))
	{
		out.print("green\">");
		out.print("Question "+i+" : "+"Response is "+entity.getProperty("answer"+i));
		out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Time taken(in Seconds) : "+entity.getProperty("time"+i));
	}
	else
	{
		out.print("red\">");
		out.print("Question "+i+" : "+"Response is "+entity.getProperty("answer"+i));
	}
	out.print("</p><br>");
}
%>
</h3>
</body>