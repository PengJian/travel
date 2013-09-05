package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.service.ApplyTimeManager;
import com.fnst.travel.service.EmployeeRouteManager;
import com.fnst.travel.service.LogManager;
import com.fnst.travel.util.Route;

@SuppressWarnings("serial")
public class ApplyAction extends BaseAction {
	private int routeId;
	private EmployeeRouteManager employeeRouteManager;
    private LogManager logManager;
    private ApplyTimeManager applyTimeManager;
    public void setApplyTimeManager(ApplyTimeManager applyTimeManager) {
		this.applyTimeManager = applyTimeManager;
	}
    public void setLogManager(LogManager logManager) {
		this.logManager = logManager;
	}
	public void setEmployeeRouteManager(
			EmployeeRouteManager employeeRouteManager) {
		this.employeeRouteManager = employeeRouteManager;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	@SuppressWarnings("unchecked")
	public String apply() throws IOException {
		
		logManager.addLog(getCurrentUser(), "报名ing...",new Date());
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		Long currentTime = System.currentTimeMillis();
		Long lastTime = (Long) ServletActionContext.getRequest().getSession().getAttribute("VISITTIME");
		if(lastTime == null){
		    lastTime = currentTime - 2000L;
        }
        
        ServletActionContext.getRequest().getSession().setAttribute("VISITTIME",currentTime);
        if((currentTime -lastTime)<500){
            out.print("你点击的速度太快");
            out.flush();
            out.close();
            return null;
        }
        
   	   if(!applyTimeManager.isDuringApplyTime()){
         out.print("现在还不在报名时间段内");
         out.flush();
         out.close();
         return null;
        }
	
		int uid = getCurrentUser().getId();
		int num = getTravelNum();
		if (!employeeRouteManager.isCanAdd(uid)) {
			out.print("已经报名,不能重复报名");
			out.flush();
			out.close();
			return null;
		}
		Map<Integer, Route> routes = (Map<Integer, Route>) ServletActionContext
				.getServletContext().getAttribute("Routes");
		if (routes == null) {
			out.print("获取路线失败");
			out.flush();
			out.close();
			return null;
		}
		Route route = null;
		if (!routes.containsKey(routeId)) {
			out.print("非法的操作");
			out.flush();
			out.close();
			return null;
		} else {
			route = (Route) routes.get(routeId);
		}

		boolean isSuccess = route.addPerson(uid, num);
		if (!isSuccess) {
			out.print("名额不足或人数已满");
			out.flush();
			out.close();
			return null;
		}
		int status = employeeRouteManager.getEmployeeRouteStatus(getCurrentUser().getId());
        getSession().setAttribute("applyStatus", status);
        
        logManager.addLog(getCurrentUser(), "报名成功",new Date());
        out.print("报名成功");
		out.flush();
		out.close();
		return null;
	}

	public String listResult() {
		int uid = getCurrentUser().getId();
		
		EmployeeRoute employeeRoute = employeeRouteManager.findByUserId(uid);
		String str = null;
		if(null != employeeRoute){
			String routeName = employeeRoute.getTravelRoute().getName();
			int count = employeeRoute.getParticipants();
			str = "你已报名<font color='red'>" + routeName + "</font>线" + "<font color='red'>"
					+ count + "</font>人";
			getRequest().setAttribute("userMsg", str);
		}
		ServletActionContext.getRequest().setAttribute("datas",
				employeeRouteManager.searchAll());
		return "to_result";
	}

	public String selectResult() {
		//ServletActionContext.getRequest().getSession().setAttribute("routeId1", routeId);
		if (0 == routeId) {
			ServletActionContext.getRequest().setAttribute("datas",
					employeeRouteManager.searchAll());
			return "to_result";
		}
		
        int uid = getCurrentUser().getId();
		
		EmployeeRoute employeeRoute = employeeRouteManager.findByUserId(uid);
		String str = null;
		if(null != employeeRoute){
			String routeName = employeeRoute.getTravelRoute().getName();
			int count = employeeRoute.getParticipants();
			str = "你已报名<font color='red'>" + routeName + "</font>线" + "<font color='red'>"
					+ count + "</font>人";
			getRequest().setAttribute("userMsg", str);
		}
		ServletActionContext.getRequest().setAttribute("datas",
				employeeRouteManager.searchbyRouteId(routeId));
		return "to_result";
	}

	public String getCurrentTime() throws IOException {
		Date now = Calendar.getInstance().getTime();
		SimpleDateFormat ftime = new SimpleDateFormat("yyyy:MM:dd:HH:mm:ss");
		String timeStr = ftime.format(now);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(timeStr);
		out.flush();
		out.close();
		return null;
	}
   @SuppressWarnings("unchecked")
public String applyOut() throws IOException
   {
	  
	    HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		 if(!applyTimeManager.isDuringApplyTime()){
	            out.print("现在还不在退报时间段内");
	            out.flush();
	            out.close();
	            return null;
	        }		
        Map<Integer, Route> routes = (Map<Integer, Route>) ServletActionContext.getServletContext().getAttribute("Routes"); 
		int uid = getCurrentUser().getId();
		EmployeeRoute employeeRoute = employeeRouteManager.findByUserId(uid); 		
		if(null ==  employeeRoute){
			out.print("已经退报");
			out.flush();
			out.close();
			return null;
		}
		Route route = (Route) routes.get(employeeRoute.getTravelRoute().getId());
	//	employeeRouteManager.delByUserId(uid);
		boolean isSuccess = route.deletePerson(uid,getTravelNum());
		if(!isSuccess) {
		    out.print("非法的操作");
	        out.flush();
	        out.close();
	        return null;
		}
		out.print("退报成功");
		out.flush();
		out.close();
		logManager.addLog(getCurrentUser(), "退报成功",new Date());
		int status = employeeRouteManager.getEmployeeRouteStatus(getCurrentUser().getId());
		getSession().setAttribute("applyStatus",status);	
	//    InitRouteUtil.loadRoute(ServletActionContext.getServletContext());
	   return null;
   }
   
   public String loadRoute() throws IOException
   {
	   HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String content = "${applyStatus}";
		out.print(content);
		out.flush();
		out.close();
	   return null;
   }
}
