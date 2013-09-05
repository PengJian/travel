package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.TravelDetail;
import com.fnst.travel.service.TravelDetailManager;
import com.fnst.travel.service.TravelRouteManager;

@SuppressWarnings("serial")
public class RouteDetailAction extends BaseAction {

    private TravelDetailManager travelDetailManager;
    private int id;
    private int routeId;
    private String details;
    
    private TravelRouteManager travelRouteManager;
    public void setTravelRouteManager(TravelRouteManager travelRouteManager) {
		this.travelRouteManager = travelRouteManager;
	}
	public String add() {
        return "pub_add";
    }

    public String update() {
    	travelDetailManager.add(details,routeId);
        return "pub_update";
    }

    /**
     * 根据id删除用户信息
     * 
     * @return
     */
    public String del() {
      
        return "pub_del";
    }

    public String list() {
       
        return "to_list";
    }
    
    public String find() throws IOException{
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setHeader("CacheControl", "no-cache");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        //System.err.println(travelDetailManager.findByRouteId(routeId));
        TravelDetail td = travelDetailManager.findByRouteId(routeId);
        if(td==null)
        {
        	out.print("暂无详细信息");
        }else {
        	out.print(td.getDetails());
		}           
        out.flush();
        out.close();
        return null;
    }

    public String input() {
       
    	ServletActionContext.getRequest().setAttribute("route",travelRouteManager.find(routeId));
        return "to_input";
    }

    public String updateInput() {
    	ServletActionContext.getRequest().setAttribute("rd", travelDetailManager.findByRouteId(routeId));
    	ServletActionContext.getRequest().setAttribute("route",travelRouteManager.find(routeId));
        return "to_update";
    }

    public TravelDetailManager getTravelDetailManager() {
        return travelDetailManager;
    }

    public void setTravelDetailManager(TravelDetailManager travelDetailManager) {
        this.travelDetailManager = travelDetailManager;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRouteId() {
        return routeId;
    }

    public void setRouteId(int routeId) {
        this.routeId = routeId;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }


}
