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
		datastore.put(topic);
	}
	public void addQuestion(Entity ques)
	{
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(ques);
	}
}
