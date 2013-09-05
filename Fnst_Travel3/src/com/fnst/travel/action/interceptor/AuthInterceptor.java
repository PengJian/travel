package com.fnst.travel.action.interceptor;

import java.io.PrintWriter;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.Employee;
import com.fnst.travel.model.User;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

@SuppressWarnings("serial")
public class AuthInterceptor extends AbstractInterceptor
{

	@Override
	public String intercept(ActionInvocation invocation) throws Exception
	{
		String actionName = invocation.getInvocationContext().getName();
		//System.err.println(actionName);
		if("login".equals(actionName)
				|| "getCurrentTime".equals(actionName)
				|| "updatePwd".equals(actionName)
				|| "findRouteDetail".equals(actionName)){
			  return invocation.invoke();
		}
		
		Employee user = (Employee)invocation.getInvocationContext().getSession().get("user");
		User manager=(User)invocation.getInvocationContext().getSession().get("manager");
		
		String reqPath = ServletActionContext.getRequest().getContextPath();
		String reqUrl = ServletActionContext.getRequest().getRequestURI();
		if(reqUrl.indexOf("front")!=-1){
			if(null==user){
				//ServletActionContext.getResponse().sendRedirect(reqPath +"/login.jsp");
				return "to_login";
			}else {
				return invocation.invoke();	
				}	 
		}
		if(reqUrl.indexOf("back")!=-1){
				if(null==manager){
					PrintWriter out = ServletActionContext.getResponse().getWriter();
					out.write("<script>window.parent.location.href='"+reqPath +"/back/login.jsp"+"';</script>");
                    return null;
					//ServletActionContext.getResponse().sendRedirect(reqPath +"/back/login.jsp");
				}else {
					return invocation.invoke();	
					}	 
		}
	    return invocation.invoke();
	    
	}

}
