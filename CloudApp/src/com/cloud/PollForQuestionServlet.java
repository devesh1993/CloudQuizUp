package com.cloud;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.*;
//import com.google.appengine.labs.repackaged.org.json.JSONObject;
import com.google.appengine.labs.repackaged.org.json.JSONObject;


@SuppressWarnings("serial")
public class PollForQuestionServlet extends HttpServlet
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
	@SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException 
	{
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String email = getCookie(req.getCookies(),"email");
		System.out.println("email is "+email);
		
		
		System.out.println("inside poolforquestion");
		
		//polling for the other user...
		while(true)
		{
			String topic = req.getParameter("topic");
			System.out.println("topic : " + topic);
			Key k = KeyFactory.createKey("AvailableTopic",topic );
			Query q = new Query(k);
			PreparedQuery pq = datastore.prepare(q);
			List<Entity> questions = pq.asList(FetchOptions.Builder.withDefaults());
			
			System.out.println(pq.countEntities(FetchOptions.Builder.withDefaults())+"**");
			
			if(pq.countEntities(FetchOptions.Builder.withDefaults()) ==0)
			{
				System.out.println("***************************");
				resp.sendRedirect("quizup.jsp?qid=1");
				break;
			}
			try 
			{
				Thread.sleep(1000);
			} 
			catch (InterruptedException e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
}
