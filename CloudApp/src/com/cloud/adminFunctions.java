package com.cloud;

import java.util.List; 
import java.util.ArrayList;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;



public class adminFunctions 
{
	public ArrayList<String> getAllTopics()
	{
		ArrayList<String> allTopics = new ArrayList<String>();
		Query q = new Query("topics");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		// Use PreparedQuery interface to retrieve results
		PreparedQuery pq = datastore.prepare(q);

		for (Entity result : pq.asIterable()) {
			allTopics.add((String) result.getProperty("topicName"));
		}
		return allTopics;
	}
	public void addTopic(Entity topic)
	{
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		ArrayList<String> allTopics = getAllTopics();
		String topicName = (String)topic.getProperty("topicName");
		int flag=0;
		for(int i=0;i<allTopics.size();i++)
		{
			if(allTopics.get(i).toLowerCase().equals(topicName.toLowerCase()))
			{
				flag = 1;
			}
		}
		if(flag==0)
		{
			datastore.put(topic);
		}
		else
		{
			System.out.println("Same topic added again...");
		}
		
	}
	public void addQuestion(Entity ques)
	{
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(ques);
	}
	public void addAnotherAdmin(Entity user)
	{
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String email = (String) user.getProperty("email");
		Filter EmailEntered = new FilterPredicate("email" , FilterOperator.EQUAL, email);
		Query q = new Query("UserData").setFilter(EmailEntered);
		PreparedQuery pq = datastore.prepare(q);
		
		if(pq.countEntities() != 0)
		{
			Entity user1 = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
			String admin = (String)user1.getProperty("admin");
			
			if(admin.equalsIgnoreCase("0"))
			{
				System.out.println("Not Admin !! Make Admin");
				user1.setProperty("admin", "1");
				
				datastore.put(user1);
			}
			else
			{
				System.out.println("Already a admin !!");
			}
				
		}
		else
		{
			datastore.put(user);
			System.out.println("Admin did not exist but added now!!");
		}
		
	}
	public boolean IsUserAdmin(String email)
	{
		boolean retVal = false;
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter EmailEntered = new FilterPredicate("email" , FilterOperator.EQUAL, email);
		Query q = new Query("UserData").setFilter(EmailEntered);
		PreparedQuery pq = datastore.prepare(q);
		
		
		if(pq.countEntities() != 0)
		{
			Entity user = pq.asList(FetchOptions.Builder.withDefaults()).get(0);
			String admin = (String)user.getProperty("admin");
			
			if(admin.equalsIgnoreCase("0"))
				System.out.println("Not Admin !!");
			else
				retVal = true;
				
		}
		else
		{
			System.out.println("User does not exist!!");
		}
		return retVal;
	}
}
