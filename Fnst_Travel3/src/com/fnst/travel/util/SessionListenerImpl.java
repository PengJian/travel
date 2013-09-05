package com.fnst.travel.util;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


import com.fnst.travel.model.Employee;


public class SessionListenerImpl implements HttpSessionListener{
	public void sessionCreated(HttpSessionEvent arg0) {
	}

	public void sessionDestroyed(HttpSessionEvent arg0) {
		Employee user = (Employee)arg0.getSession().getAttribute("user");
		if(null != user){
		   arg0.getSession().getServletContext().removeAttribute(user.getUsername());
		}
	}

}
