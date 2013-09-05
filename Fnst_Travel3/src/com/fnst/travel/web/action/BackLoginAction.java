package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.ApplyTime;
import com.fnst.travel.model.User;
import com.fnst.travel.service.ApplyTimeManager;
import com.fnst.travel.service.LogManager;
import com.fnst.travel.service.UserManager;

@SuppressWarnings("serial")
public class BackLoginAction extends BaseAction{
private String username;
private String password;
private String str;
private String startTime;
private String endTime;
private LogManager logManager;
private ApplyTimeManager applyTimeManager;
public String getStr() {
	return str;
}
public void setStr(String str) {
	this.str = str;
}
public void setLogManager(LogManager logManager) {
	this.logManager = logManager;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}

private UserManager userManager;
public void setUserManager(UserManager userManager) {
	this.userManager = userManager;
}

public void setApplyTimeManager(ApplyTimeManager applyTimeManager) {
	this.applyTimeManager = applyTimeManager;
}


public String getStartTime() {
	return startTime;
}
public void setStartTime(String startTime) {
	this.startTime = startTime;
}
public String getEndTime() {
	return endTime;
}
public void setEndTime(String endTime) {
	this.endTime = endTime;
}
public String login()
{

	User user = userManager.login(username, password);
	if(null==user)
	{
		this.addActionMessage("用户名或密码不正确");
		return "to_login";
	}
	
	ServletActionContext.getRequest().getSession().setAttribute("manager", user);
    return "to_index";	
}

public String logout() throws IOException
{
	User user = (User)ServletActionContext.getRequest().getSession().getAttribute("manager");
	
	if(null!=user){
		ServletActionContext.getRequest().getSession().removeAttribute("manager");
	}
	PrintWriter out = ServletActionContext.getResponse().getWriter();
	out.write("<script>window.parent.location.href='"+ServletActionContext.getRequest().getContextPath() +"/back/login.jsp"+"';</script>");
	return null;
}

public String searchAllLog(){
	getRequest().setAttribute("pm", logManager.searchAll());
	return "to_logindex";
	}

public String toSetApplyTime()
{
	ApplyTime applyTime = applyTimeManager.getTime();
	if (null==applyTime) {
		startTime = "";
		endTime = "";
	}else {
		SimpleDateFormat sd=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		startTime = sd.format(applyTime.getStartTime());
		endTime = sd.format(applyTime.getEndTime());
	}
	return "to_settime";
}

public String setApplyTime() throws IOException, ParseException
{
	HttpServletResponse response = ServletActionContext.getResponse();
	response.setHeader("CacheControl", "no-cache");
	response.setContentType("text/html;charset=utf-8");
	SimpleDateFormat sd=new SimpleDateFormat("yyyy/MM/dd HH:mm");
	PrintWriter out = response.getWriter();
	
    if(null==startTime || "".equals(startTime)){
    	out.print("开始时间不能为空");    	
    	out.flush();
    	out.close();
    	return null;
    }
    
    if(null==startTime || "".equals(startTime)){
    	out.print("结束时间不能为空");    	
    	out.flush();
    	out.close();
    	return null;
    }
    
	Date startDate = sd.parse(startTime);
	Date endDate = sd.parse(endTime);
	
	if(endDate.before(startDate)){
    	out.print("结束时间早于开始时间");    	
    	out.flush();
    	out.close();
    	return null;
    }
	ApplyTime applyTime = applyTimeManager.getTime();
	if(null==applyTime){
		applyTime = new ApplyTime();
	}
	applyTime.setStartTime(startDate);
	applyTime.setEndTime(endDate);
	applyTimeManager.addOrUpdateApplyTime(applyTime);
	out.print("设定成功");
	
	out.flush();
	out.close();
	return null;
}
public String selectUserLog()
{   getRequest().setAttribute("pm", logManager.select(str));
	return "to_logindex";
	}
}
