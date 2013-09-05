package com.fnst.travel.web.action;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.Employee;
import com.opensymphony.xwork2.ActionSupport;


 /**
 *  Class Name: BaseAction.java
 *  Function: 
 *           所有Action的基类
 *  @author JianLeiXing  DateTime 2012-8-9 下午03:10:26    
 *  @version 1.0 
 */
public class BaseAction extends ActionSupport{
	
	private static final long serialVersionUID = 1L;

	protected int getTravelNum()
	{
		return (Integer)ServletActionContext.getRequest().getSession().getAttribute("num");
	}
	
	protected void setTravelNum(int num)
	{
		ServletActionContext.getRequest().getSession().setAttribute("num",num);
	}
	
	protected Employee getCurrentUser()
	{
		return (Employee)ServletActionContext.getRequest().getSession().getAttribute("user"); 
	}
	protected int getApplyStatus()
	{
		return (Integer)ServletActionContext.getRequest().getSession().getAttribute("applyStatus");
	}
	
	protected HttpSession getSession()
	{
		return ServletActionContext.getRequest().getSession();
	}
	
	protected HttpServletRequest getRequest()
	{
		return ServletActionContext.getRequest();
	}
	
	protected ServletContext getServletContext()
	{
		return ServletActionContext.getServletContext();
	}
}
