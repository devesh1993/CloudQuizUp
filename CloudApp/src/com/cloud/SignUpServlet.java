package com.cloud;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

import java.util.*;

@SuppressWarnings("serial")
public class SignUpServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		resp.setContentType("text/plain");
		
		// System.out.println("here ");
		Entity user = new Entity("UserData");

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		user.setProperty("name", name);
		user.setProperty("email", email);
		user.setProperty("password", password);
		
		
		Filter EmailEntered = new FilterPredicate("email",FilterOperator.EQUAL,email);
		Query q = new Query("UserData").setFilter(EmailEntered);
		PreparedQuery pq = datastore.prepare(q);
		
		System.out.println("Current Count = " + pq.countEntities());
		if(pq.countEntities() != 0)
		{
			resp.getWriter().println("User Already Exists !!!");
			resp.sendRedirect("index.html");
		}
		else if(name==null || email==null || password==null)
		{
			resp.getWriter().write("Fill all the entries !!!");
			resp.sendRedirect("index.html");
		}
		else
		{
			
			datastore.put(user);
			
			resp.sendRedirect("login.html");
		}
		
		resp.getWriter().println(name + "  " + email + "  " + password);
		
	}

}
