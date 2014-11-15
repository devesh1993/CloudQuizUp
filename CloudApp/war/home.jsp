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


<form action = "/selectTopic">

<select class="form-control" name="topic">
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
		</select>

<input type = "submit" value="select topic">
</form>