package com.fnst.travel.util;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;


public class InitApplicationServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
   
    public void init() {
    	//System.err.println("init ...");
        ServletContext application = this.getServletContext();
        initApplication(application);
    }

    private void initApplication(ServletContext application) {
        
        InitRouteUtil.loadRoute(application);
    }
}
