package com.cloud;
import java.io.IOException;

import javax.servlet.http.*;

import java.util.List; 
import java.util.ArrayList;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.CompositeFilter;
import com.google.appengine.api.datastore.Query.CompositeFilterOperator;
import com.google.appengine.api.datastore.PreparedQuery;


@SuppressWarnings("serial")
public class LogInServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		
		Filter EmailEntered =
				  new FilterPredicate("email",FilterOperator.EQUAL,email);
		Filter PasswordEntered =
				  new FilterPredicate("password",FilterOperator.EQUAL,password);
		Filter Combined = CompositeFilterOperator.and(EmailEntered,PasswordEntered);
		
		Query q = new Query("UserData").setFilter(Combined);
		//List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
		resp.getWriter().println("  "+email+ "  "+ password);
		PreparedQuery pq = datastore.prepare(q);
		
		System.out.println(pq.countEntities());
		
		
		//Query query = new Query("userData");
		//List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
		//System.out.println("user is "+users.get(0));
		if(pq.countEntities() == 0)
		{
			resp.getWriter().write("Wrong Credentials");
			resp.sendRedirect("login.html");
		}
		else
		{
			resp.getWriter().write("Successfully Logged In !!!");
			Cookie ck=new Cookie("email",email);//creating cookie object  
			resp.addCookie(ck);
			resp.sendRedirect("/home.jsp");
		}
		/*
		for (Entity result : pq.asIterable())
		{
		  String nameRetrieved = (String) result.getProperty("name");
		  String emailRetrieved = (String) result.getProperty("email");
		  String passwordRetrieved = (String) result.getProperty("password");
		  
		  //datastore.delete(result.getKey());
		  resp.getWriter().println("Here retrieved name "+nameRetrieved +" "+emailRetrieved+ "  "+ passwordRetrieved);
		}
		*/		
		  
	}
	
}
