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

<div id = "waitforother"><h3>Waiting for Opponents Response...</h3></div>
<script>

function disableBackButton()
{
window.history.forward()
}  
disableBackButton();  
window.onload=disableBackButton();  

document.getElementById("waitforother").style.visibility="hidden";
	var response =-1;
	var timetaken = 30;
	function handler()
	{
		window.location.assign("/response?qid="+"<%out.print(request.getParameter("qid"));%>"+"&userAns="+response+"&time="+timetaken);
	}
	setInterval(handler,10000);
	
	function chkResponse(resp, initialMin, initialSec) {
		var min=0,timeTaken;
		var d = new Date();
		var currMin,currSec;
		currMin = d.getMinutes();
		currSec = d.getSeconds();
		min = initialMin - currMin;
		if(min == 0)
		{
			timeTaken = currSec - initialSec;
		}
		else
		{
			timeTaken = (60-initialSec)+currSec;
		}
		response = resp;
		timetaken = timeTaken;
		document.getElementById("waitforother").style.visibility="visible";
		document.getElementById("question").style.visibility="hidden";
		console.log("time required is "+timeTaken);
	
	}
</script>
</head>
<body>
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
	%>
	
	<h3><%
	out.println(email);
	out.println(ResponseServlet.getScore(email));
	%></h3>
	<h3 align="right">Opponent <%
	String opponent = ResponseServlet.getOpponent(email); 
	out.println(opponent);
	out.println(ResponseServlet.getScore(opponent));
	%></h3>

	<label name="question" class="form-control"
		><%out.println(ques);%></label>
	<div class="radio" onclick="chkResponse(1,<%out.print(initialMin+","+initialSec); %>)">
		<label> <input type="radio"
			name="option1"><%out.println(opt1);%>
		</label>
	</div>
	<div class="radio" onclick="chkResponse(2,<%out.print(initialMin+","+initialSec); %>)">
		<label> <input type="radio"
			name="option2">
			<%out.println(opt2);%>
		</label>
	</div>
	<div class="radio" onclick="chkResponse(3,<%out.print(initialMin+","+initialSec); %>)">
		<label> <input type="radio"
			name="option3">
			<%out.println(opt3);%>
		</label>
	</div>
	<div class="radio" onclick="chkResponse(4,<%out.print(initialMin+","+initialSec); %>)">
		<label> <input type="radio"
			name="option4">
			<%out.println(opt4);%>
		</label>
	</div>
</div>
<H3 id = "timer" ></H3>
</body>
</html>