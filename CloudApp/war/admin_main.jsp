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

<!DOCTYPE html>


<%@page import="java.util.ArrayList"%>

<html>
<head>
<title>Admin</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
</head>
<body>

	<%
		String email = new String();
		Cookie cookie = null;
		Cookie[] cookies = null;
		cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if (cookie.getName().equals("email")) {
					email = cookie.getValue();
				}
			}
		}
		adminFunctions funcs = new adminFunctions();
		boolean IsAdmin = funcs.IsUserAdmin(email);
		if (IsAdmin) {
			int opt = Integer.parseInt(request.getParameter("opt"));

			if (opt == 0) {
				String new_topic = request.getParameter("newTopic");
				String name = request.getParameter("name");
				String emailNew = request.getParameter("email");
				String password = request.getParameter("password");
				System.out.println("Here");
				if (new_topic == null) {
					if (name != null && email != null && password != null) {
						System.out.println(name + " " + emailNew + " "
								+ password);
						Entity user = new Entity("UserData");
						user.setProperty("name", name);
						user.setProperty("email", emailNew);
						user.setProperty("password", password);
						user.setProperty("admin", "1");

						funcs.addAnotherAdmin(user);
					}
	%>
	<h1>Welcome Administrator!!!</h1>
	<a href="admin_main.jsp?opt=1"><button class="btn btn-primary">Add
			question</button></a>
	<a href="admin_main.jsp?opt=2"><button class="btn btn-primary">Add
			Topic</button></a>
	<a href="admin_main.jsp?opt=3"><button class="btn btn-primary">Add
			Admin</button></a>
	<a href="logout.jsp"><button class="btn btn-primary">Log
			Out</button></a>
	<%
		} else {
					Entity topic = new Entity("topics");
					topic.setProperty("topicName", new_topic);
					funcs.addTopic(topic);
	%>
	<h3>Topic added successfully...!!!</h3>
	<h1>Welcome Administrator!!!</h1>
	<a href="admin_main.jsp?opt=1"><button class="btn btn-primary">Add
			question</button></a>
	<a href="admin_main.jsp?opt=2"><button class="btn btn-primary">Add
			Topic</button></a>
	<a href="admin_main.jsp?opt=3"><button class="btn btn-primary">Add
			Admin</button></a>
	<a href="logout.jsp"><button class="btn btn-primary">Log
			Out</button></a>
	<%
		}
			} else if (opt == 1) {
				String chk = request.getParameter("question");
				if (chk == null) {
					out.println("<h1>" + "Want to add new question???\n"
							+ "</h1>");
	%>

	<form class="navbar-form navbar-right" method="post"
		action="admin_main.jsp">
		<select class="form-control" name="topic">
			<option>Select Topic</option>
			<%
				ArrayList<String> allTopics = new ArrayList<String>();
							allTopics = funcs.getAllTopics();
							for (int i = 0; i < allTopics.size(); i++) {
								String command = "<option value=\""
										+ allTopics.get(i) + "\">"
										+ allTopics.get(i) + "</option>";
								out.println(command);
							}
			%>
		</select><br /> <br /> <br />
		<textarea name="question" class="form-control"
			placeholder="Insert Question" cols="60" rows="3"></textarea>
		<br /> <br /> <input type="text" name="option1" class="form-control"
			placeholder="Option 1"><br /> <input type="text"
			name="option2" class="form-control" placeholder="Option 2"><br />
		<input type="text" name="option3" class="form-control"
			placeholder="Option 3"><br /> <input type="hidden"
			name="opt" class="form-control" value="1"><br /> <input
			type="text" name="option4" class="form-control"
			placeholder="Option 4"><br /> <br /> <select
			class="form-control" name="answer">
			<option>Answer</option>
			<option value="1">Option 1</option>
			<option value="2">Option 2</option>
			<option value="3">Option 3</option>
			<option value="4">Option 4</option>
		</select><br /> <br />
		<div class="input-group-btn">
			<button type="submit" value="Search" class="btn btn-primary">Add
				question</button>
		</div>
	</form>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="admin_main.jsp?opt=0"><button class="btn btn-primary">Admin
			Page</button></a>
	<%
		} else {
					String ques = request.getParameter("question");
					String opt1 = request.getParameter("option1");
					String opt2 = request.getParameter("option2");
					String opt3 = request.getParameter("option3");
					String opt4 = request.getParameter("option4");
					String ans = request.getParameter("answer");
					String topic = request.getParameter("topic");
					Entity question = new Entity("question");
					question.setProperty("ques", ques);
					question.setProperty("option1", opt1);
					question.setProperty("option2", opt2);
					question.setProperty("option3", opt3);
					question.setProperty("option4", opt4);
					question.setProperty("topic", topic);
					question.setProperty("answer", ans);
					funcs.addQuestion(question);
					response.sendRedirect("admin_main.jsp?opt=0");
				}
			} else if (opt == 2) {
	%>
	<form class="navbar-form navbar-right" method="post"
		action="admin_main.jsp">
		Please Enter new topic <br /> <input type="text" name="newTopic"
			class="form-control" placeholder="New Topic"><br /> <input
			type="hidden" name="opt" class="form-control" value="0"><br />
		<div class="input-group-btn">
			<button type="submit" value="Search" class="btn btn-primary">Add
				Topic</button>
		</div>
	</form>
	<%
		} else {
	%>
	<form class="navbar-form navbar-right" method="post"
		action="admin_main.jsp">
		Add another Admin <br /> <input type="hidden" name="opt"
			class="form-control" value="0">
		<div class="form-group">
			<label for="inputName" class="col-sm-2 control-label">Name</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="inputEmail3"
					placeholder="Name" name="name" required="required">
			</div>
		</div>
		<div class="form-group">
			<label for="inputEmail" class="col-sm-2 control-label">Email</label>
			<div class="col-sm-5">
				<input type="email" class="form-control" id="inputEmail"
					placeholder="Email" name="email" required="required">
			</div>
		</div>
		<div class="form-group">
			<label for="inputPassword" class="col-sm-2 control-label">Password</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="inputPassword"
					name="password" placeholder="Password" required="required">
			</div>
		</div>
		<div class="input-group-btn">
			<button type="submit" value="addAdmin" class="btn btn-primary">Add
				Admin</button>
		</div>
	</form>

	<%
		}
		} else {
			response.sendRedirect("login.jsp");
		}
	%>

</body>
</html>
