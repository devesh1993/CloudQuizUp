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
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

Query q = new Query("AvailableTopic");

PreparedQuery pq = datastore.prepare(q);

for (Entity result : pq.asIterable()) 
{
    datastore.delete(result.getKey());      
}   
q = new Query("Match");

pq = datastore.prepare(q);

for (Entity result : pq.asIterable()) 
{
    datastore.delete(result.getKey());      
}

q = new Query("OnlineUser");

pq = datastore.prepare(q);

for (Entity result : pq.asIterable()) 
{
    datastore.delete(result.getKey());      
}


%>