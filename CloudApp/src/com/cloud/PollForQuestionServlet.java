package com.cloud;


import java.io.IOException;

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
		//polling for the other user...
		while(true)
		{
			Query q = new Query(req.getParameter("topic"));
			PreparedQuery pq = datastore.prepare(q);
			if(pq.countEntities(FetchOptions.Builder.withDefaults()) ==0)
			{
				
				q = new Query("Match").setFilter(new FilterPredicate("player1",FilterOperator.EQUAL, email));
				pq = datastore.prepare(q);
				Entity matchedPair = pq.asList(FetchOptions.Builder.withLimit(1)).get(0);
				EmbeddedEntity question = (EmbeddedEntity) matchedPair.getProperty("question"+req.getParameter("qid"));
				String jsonString = (new JSONObject(question.getProperties())).toString();
				resp.getWriter().write(jsonString);
				break;
			}
			try 
			{
				Thread.sleep(1000);
			} catch (InterruptedException e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
}
