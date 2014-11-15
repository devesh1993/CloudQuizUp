<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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


<!DOCTYPE html>


<%@page import="java.util.ArrayList"%>

<html>
  <head>
    <title>User</title>
  </head>
  <body>
  Hey i am here
<%
	String name=request.getParameter("name");
	System.out.println(name);
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Entity user = new Entity("userData");
	user.setProperty("name", name);
	datastore.put(user);
	Query query = new Query("userData");
	List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
	System.out.println("user is "+users.get(0));
%>
</body>
</html> 