package com.fnst.travel.action.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.fnst.travel.util.SystemContext;

public class PagerFilter implements Filter
{

	public void init(FilterConfig filterconfig) throws ServletException
	{

	}

	public void doFilter(ServletRequest servletrequest,
			ServletResponse servletresponse, FilterChain filterchain)
			throws IOException, ServletException
	{
        HttpServletRequest request = (HttpServletRequest)servletrequest;
       /* HttpServletResponse response = (HttpServletResponse)servletresponse;
        Member currUser = (Member)request.getAttribute("currentUser");
        String uriPath = request.getRequestURI();
        
        if(null == currUser){
        	
        }
        if(uriPath.endsWith(".jsp")) {
        	int index = uriPath.lastIndexOf("/");
        	String page = uriPath.substring(index + 1);
        	if(uriPath.indexOf("admin") != -1){
        		response.sendRedirect("index.jsp");
        	}
        }*/
        
        int offset = getOffset(request);
        int pageSize = getPageSize(request) ;
        
        
        
        SystemContext.setOffset(offset);
        SystemContext.setPageSize(pageSize);
        
        
        try
		{
			filterchain.doFilter(servletrequest, servletresponse);
		} finally
		{
			// TODO: handle exception
			SystemContext.removeOffset();
			SystemContext.removePageSize();
		}
	}

	public void destroy()
	{
		
	}
   protected int getOffset(HttpServletRequest request)
   {
	   String offsetStr = request.getParameter("pager.offset");
	   if(null == offsetStr)
		   return 0;
	   return Integer.parseInt(offsetStr);
   }
   
   protected int getPageSize(HttpServletRequest request)
   {
	   request.setAttribute("pageSize", 30);
	   return 30;
   }
}
