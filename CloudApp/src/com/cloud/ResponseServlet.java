package com.cloud;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.*;


public class ResponseServlet extends HttpServlet
{
	
	private String getCookie(Cookie cookies[], String cvalue)
	{
		for(int i = 0 ; i < cookies.length; i++)
		{
			if(cookies[i].getName().equals(cvalue))
			{
				return cookies[i].getValue();
			}
		}
		return null;
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException 
	{
		
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		//checking for the answer
		String email = getCookie(req.getCookies(),"email");
		int qid = Integer.parseInt(req.getParameter("qid"));
		
		String userAns = req.getParameter("userAns");
		Filter filter1 = new FilterPredicate("player1",FilterOperator.EQUAL,email);
		Filter filter2 = new FilterPredicate("player2",FilterOperator.EQUAL,email);
		System.out.println("email is "+email+" qid is "+qid);
		
		Query q = new Query("Match").setFilter(CompositeFilterOperator.or(filter1,filter2));
		
		PreparedQuery pq = datastore.prepare(q);
		Entity pair = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
		
		String answer = (String) ((EmbeddedEntity)pair.getProperty("question"+qid)).getProperty("answer");
	
		if(answer.equals(userAns))
		{
			Key k = KeyFactory.createKey("OnlineUser", email);
			q = new Query(k);//.setFilter(new FilterPredicate("email",FilterOperator.EQUAL,email));
			pq = datastore.prepare(q);
			Entity user = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
			
			user.setProperty("answer"+qid, "right");
			datastore.put(user);
			//pq.asList(FetchOptions.Builder.withDefaults()).get(0).setProperty("time"+qid, req.getParameter("time"));
		}
		else
		{
			Key k = KeyFactory.createKey("OnlineUser", email);
			q = new Query(k);
			pq = datastore.prepare(q);
			Entity user = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
			
			user.setProperty("answer"+qid, "wrong");
			datastore.put(user);		
		}
		
		if(qid==5)
		{
			resp.sendRedirect("result.jsp");
		}
		else
			resp.sendRedirect("quizup.jsp?qid="+ (qid+1));

	
				
	}
}
