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
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
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
		System.out.println(email+ "  "+ password);
		PreparedQuery pq = datastore.prepare(q);
		
		System.out.println("Pq Count " + pq.countEntities());
		
		Key kemail = KeyFactory.createKey("LoggedIn", email);
		q = new Query("LoggedIn",kemail);
		PreparedQuery pq1 = datastore.prepare(q);
		if(pq1.countEntities() != 0 )
		{
			System.out.println("Pq11 inside the login redirectnt innnnn" + pq1.countEntities());
			
			resp.sendRedirect("login.jsp?q=SignedIn");
			System.out.println("still in login servert..");
		}
		else
		{
			if(pq.countEntities() == 0)
			{
				//resp.getWriter().write("Wrong Credentials");
				resp.sendRedirect("login.jsp?q=WrongCredentials");
			}
			else
			{
				//resp.getWriter().write("Successfully Logged In !!!");
				
				Entity user = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
				String IsAdmin = (String)user.getProperty("admin");
				
				
				Entity user1 = new Entity("LoggedIn",email);
				datastore.put(user1);
				
				Cookie ck=new Cookie("email",email);//creating cookie object  
				resp.addCookie(ck);
				
				if(IsAdmin.equals("1"))
					resp.sendRedirect("admin_main.jsp?opt=0");
				else		
					resp.sendRedirect("/home.jsp");
			} 

		}
				
		
		
		//Query query = new Query("userData");
		//List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
		//System.out.println("user is "+users.get(0));
			  
	}
	
}
