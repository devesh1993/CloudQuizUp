package com.cloud;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.EmbeddedEntity;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.*;
public class SelectTopicServlet extends HttpServlet 
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
		
		String email = getCookie(req.getCookies(),"email");
		String topic = req.getParameter("topic");
		Key k = KeyFactory.createKey("AvailableTopic",req.getParameter("topic"));
		try 
		{
			Entity matchedUser = datastore.get(k);
			//datastore.delete(k);
			String otherEmail = (String) matchedUser.getProperty("email");
			
			Entity pair = new Entity("Match");
			pair.setProperty("player1", otherEmail);
			pair.setProperty("player2", email);
			
			pair.setProperty("topic", req.getParameter("topic"));
			
			Query q = new Query("question").setFilter(new FilterPredicate("topic", FilterOperator.EQUAL, topic));
			
			PreparedQuery pq = datastore.prepare(q);
			

			Entity user1 = new Entity("OnlineUser",otherEmail);
			Entity user2 = new Entity("OnlineUser",email);
			
			user1.setProperty("topic", req.getParameter("topic"));

			user2.setProperty("topic", req.getParameter("topic"));
			
			
			List<Entity> questions = pq.asList(FetchOptions.Builder.withDefaults());
			
			Random rand = new Random();
			System.out.println("question for topic : " + topic +" number of questions : " + questions.size());
			for(int i = 0 ; i < 5;  i ++)
			{
				int index = rand.nextInt(questions.size());
				System.out.println(i);
				
				System.out.println(questions.get(i).getProperty("ques"));
				
				EmbeddedEntity temp = new EmbeddedEntity();
				
				temp.setProperty("question", questions.get(i).getProperty("ques"));
				temp.setProperty("answer", questions.get(i).getProperty("answer"));
				temp.setProperty("option1", questions.get(i).getProperty("option1"));
				temp.setProperty("option2", questions.get(i).getProperty("option2"));
				temp.setProperty("option3", questions.get(i).getProperty("option3"));
				temp.setProperty("option4", questions.get(i).getProperty("option4"));
				//user1.setProperty("answer"+(i+1), "");
				//user2.setProperty("answer"+(i+1), "");
				pair.setProperty("question"+(i+1),temp);
			}
			
			
			
			datastore.put(user1);
			datastore.put(user2);
			datastore.put(pair);
			
			Key key = KeyFactory.createKey("AvailableTopic",req.getParameter("topic") );
			datastore.delete(key);
			resp.sendRedirect("/quizup.jsp?qid=1");
			
						
		} 
		catch (EntityNotFoundException e) 
		{	
			
			
			Entity requestedTopic = new Entity("AvailableTopic",req.getParameter("topic"));
			requestedTopic.setProperty("email", email);
			datastore.put(requestedTopic);
			System.out.println("directing to wait.jsp");
			resp.sendRedirect("/wait.jsp?topic="+req.getParameter("topic"));
			/*
			Query q = new Query(req.getParameter("topic"));
			
			PreparedQuery pq = datastore.prepare(q);
			
			List<Entity> questions = pq.asList(FetchOptions.Builder.withDefaults());
			Random rand = new Random();
			for(int i = 0 ; i < 5;  i ++)
			{
				int index = rand.nextInt(questions.size());
				System.out.println(index);
				System.out.println(questions.get(index).getProperty("question"));
				EmbeddedEntity temp = new EmbeddedEntity();
				temp.setProperty("question", questions.get(index).getProperty("question"));
				temp.setProperty("answer", questions.get(index).getProperty("answer"));
				temp.setProperty("op1", questions.get(index).getProperty("op1"));
				temp.setProperty("op2", questions.get(index).getProperty("op2"));
				temp.setProperty("op3", questions.get(index).getProperty("op3"));
				temp.setProperty("op4", questions.get(index).getProperty("op4"));
				
				requestedTopic.setProperty("question"+(i+1),temp);
			}
			datastore.put(requestedTopic);
			
			res.setStatus(HttpServletResponse.SC_OK);
			res.getWriter().write("wait");
			res.getWriter().close();
			*/
		}
	}
}
