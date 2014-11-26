<%@page import="javax.jdo.identity.IntIdentity"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
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

<html>
<head>
<title>Quiz Up</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet">

<marquee dir="ltr"><h2 id = "waitforother"></h2></marquee>
<script>

	function disableBackButton()
	{
		window.history.forward()
	}  
	disableBackButton();  
	window.onload=disableBackButton();  

document.getElementById("waitforother").style.visibility="hidden";
	var response =-1;
	var timetaken = 10;
	var d1 = new Date();
	var iniMin = d1.getMinutes();
	var iniSec = d1.getSeconds();
	function handler()
	{
		window.location.assign("/response?qid="+"<%out.print(request.getParameter("qid"));%>"+"&userAns="+response+"&time="+timetaken);
	}
	setInterval(handler,10000);
	
	function chkResponse(resp, initialMin, initialSec,ans) {
		if(response==-1)
		{
			var min=0,timeTaken;
			var d = new Date();
			var currMin,currSec;
			currMin = d.getMinutes();
			currSec = d.getSeconds();
			min = currMin - iniMin;
			if(min == 0)
			{
				timeTaken = currSec - iniSec;
			}
			else
			{
				timeTaken = (60-iniSec)+currSec;
			}
			response = resp;
			timetaken = timeTaken;
			document.getElementById("waitforother").style.visibility="visible";
			document.getElementById("waitforother").innerHTML="Waiting for Opponents Response...";
			document.getElementById("option"+resp).style.backgroundColor="orange";
			document.getElementById("option"+ans).style.backgroundColor="green";
			console.log("time required is "+timeTaken);			
		}
		else
		{
			document.getElementById("waitforother").innerHTML="Already answered question, Please wait for opponent";
		}
	}
</script>
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
  margin-right:675px;
}
</style>
</head>
<body style="width:100%;height:100%;background-image:url('quizBack.png');background-repeat: no-repeat;background-position: center;">

<div class="abc">
	 <img src="QuizLogo.jpg" style="width:300px;height:100px;"/> 
	<h1 align="center" style="color:red"></h1>
</div>
<br>
<br>
<br>
<br>
<div id = "question">
	<%
		adminFunctions funcs  = new adminFunctions();
		
		Calendar cal = Calendar.getInstance();
		int initialMin,initialSec;
		initialMin = cal.get(Calendar.MINUTE);
		initialSec = cal.get(Calendar.SECOND);
		
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
		System.out.println("done1  " +email );
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		int qid = Integer.parseInt(request.getParameter("qid"));
		
		FilterPredicate filter1 = new FilterPredicate("player1", FilterOperator.EQUAL, email);
		FilterPredicate filter2 = new FilterPredicate("player2", FilterOperator.EQUAL, email);
		
		
		Query q = new Query("Match").setFilter(CompositeFilterOperator.or(filter1,filter2));
		PreparedQuery pq = datastore.prepare(q);
		Entity pair = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
		EmbeddedEntity temp = new EmbeddedEntity();
		temp = (EmbeddedEntity)pair.getProperty("question"+qid);
		System.out.println("done2"+temp);
		String ques = temp.getProperty("question").toString();
		String opt1 = temp.getProperty("option1").toString();
		String opt2 = temp.getProperty("option2").toString();
		String opt3 = temp.getProperty("option3").toString();
		String opt4 = temp.getProperty("option4").toString();
		int ans = Integer.parseInt(temp.getProperty("answer").toString());
	%>
	
	<h3 style="color : green;margin-left:10%;"><b><%
	out.println(email + " :- ");
	out.println(ResponseServlet.getScore(email));
	%></b></h3>
	<h3 align="right" style="color : red;margin-right:10%;"><b>OPPONENT <%
	String opponent = ResponseServlet.getOpponent(email); 
	out.println(opponent+ " :- ");
	out.println(ResponseServlet.getScore(opponent));
	%></b></h3>
	<div align="center">
	<label name="question" style="width : 50%;height:150px;" class="form-control"
		><h2><%out.println(ques);%></h2></label>
	</div><br>
	<div id = "option1" class="form-control" style="margin-left:400px;width : 40%;height:40px;" onclick="chkResponse(1,<%out.print(initialMin+","+initialSec+"," + ans); %>)" style = "background-color: silver;">
		<h4 align = "center" style = "color:black;"><label>  
			<%out.println(opt1);%>
		</label></h4>
	</div><br>
	<div id = "option2" class="form-control" style="margin-left:400px;width : 40%;height:40px;" onclick="chkResponse(2,<%out.print(initialMin+","+initialSec+"," + ans); %>)">
		<h4 align = "center" style = "color:black;"><label>  
			<%out.println(opt2);%>
		</label></h4>
	</div><br>
	<div id = "option3" class="form-control" style="margin-left:400px;width : 40%;height:40px;" onclick="chkResponse(3,<%out.print(initialMin+","+initialSec+"," + ans); %>)">
		<h4 align = "center" style = "color:black;"><label>  
			<%out.println(opt3);%>
		</label></h4>
	</div><br>
	<div id = "option4" class="form-control" style=" margin-left:400px;width : 40%;height:40px;" onclick="chkResponse(4,<%out.print(initialMin+","+initialSec+"," + ans); %>)">
		<h4 align = "center" style = "color:black;"><label>  
			<%out.println(opt4);%>
		</label></h4>
	</div>
</div>
<H3 id = "timer" ></H3>
</body>
</html>