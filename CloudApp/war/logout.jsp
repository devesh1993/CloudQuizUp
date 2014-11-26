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

<%
Cookie cookie = null;
Cookie[] cookies = null;
cookies = request.getCookies();
String email = "";
if (cookies != null) 
{
	for (int i = 0; i < cookies.length; i++) {
		cookie = cookies[i];
		if (cookie.getName().equals("email")) {
			email = cookie.getValue();
		}
		cookie.setMaxAge(0);
	}
}

DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Key k = KeyFactory.createKey("LoggedIn", email);
Query q = new Query("LoggedIn",k);

PreparedQuery pq = datastore.prepare(q);
if(pq.countEntities() != 0)
{
	Entity e = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
	datastore.delete(e.getKey());
}
response.sendRedirect("index.html");
%>
