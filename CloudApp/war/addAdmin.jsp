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
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.cloud.*"%>


<html>
<head>
<title>Add Admin</title>
</head>

<%
	
	DatastoreService datastore = DatastoreServiceFactory
		.getDatastoreService();
	Entity user = new Entity("UserData");

	String name = "Ajinkya";
	String email = "ajinkya@quizup.com";
	String password = "ad";
	user.setProperty("name", name);
	user.setProperty("email", email);
	user.setProperty("password", password);

	user.setProperty("admin", "1");
	
	Filter EmailEntered = new FilterPredicate("email" , FilterOperator.EQUAL, email);
	Query q = new Query("UserData").setFilter(EmailEntered);
	PreparedQuery pq = datastore.prepare(q);
	
	if(pq.countEntities() != 0)
	{
		System.out.println("Admin already exists !!");
		response.sendRedirect("index.html");
	}
	else
	{
		System.out.println("Admin Added..!!");
		datastore.put(user);
		response.sendRedirect("login.jsp");
	}
%>
</html>