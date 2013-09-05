package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.service.TravelBathManager;
import com.fnst.travel.service.TravelRouteManager;
import com.fnst.travel.util.InitRouteUtil;

@SuppressWarnings("serial")
public class BatchAction extends BaseAction {
 private int id;
 private int yearId;
 
 private String batchNo;
 private String name;
 private Date startDate;
 private Date endDate;
 private float subsidy;
 private boolean select;
 private String remarks;
 
 
 
 private int flag;
 private int onOrOff;
 
 private String str1;
 private String str2;
 private String str3;
 
 
 


public String getStr1() {
	return str1;
}

public void setStr1(String str1) {
	this.str1 = str1;
}

public String getStr2() {
	return str2;
}

public void setStr2(String str2) {
	this.str2 = str2;
}

public String getStr3() {
	return str3;
}

public void setStr3(String str3) {
	this.str3 = str3;
}

public int getFlag() {
	return flag;
}

public void setFlag(int flag) {
	this.flag = flag;
}

public int getOnOrOff() {
	return onOrOff;
}

public void setOnOrOff(int onOrOff) {
	this.onOrOff = onOrOff;
}

public String getRemarks() {
	return remarks;
}

public void setRemarks(String remarks) {
	this.remarks = remarks;
}

private String relationBatch;
 
public int getYearId() {
	return yearId;
}

public void setYearId(int yearId) {
	this.yearId = yearId;
}

public String getBatchNo() {
	return batchNo;
}

public void setBatchNo(String batchNo) {
	this.batchNo = batchNo;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public Date getStartDate() {
	return startDate;
}

public void setStartDate(Date startDate) {
	this.startDate = startDate;
}

public Date getEndDate() {
	return endDate;
}

public void setEndDate(Date endDate) {
	this.endDate = endDate;
}

public float getSubsidy() {
	return subsidy;
}

public void setSubsidy(float subsidy) {
	this.subsidy = subsidy;
}

public String getRelationBatch() {
	return relationBatch;
}

public void setRelationBatch(String relationBatch) {
	this.relationBatch = relationBatch;
}

public boolean isSelect() {
	return select;
}

public void setSelect(boolean select) {
	this.select = select;
}

private TravelBathManager travelBathManager;
private TravelRouteManager travelRouteManager;
public void setTravelRouteManager(TravelRouteManager travelRouteManager) {
	this.travelRouteManager = travelRouteManager;
}
public void setTravelBathManager(TravelBathManager travelBathManager) {
	this.travelBathManager = travelBathManager;
}
 
 public String add()
 {
	    TravelBatch travelBatch = new TravelBatch();
	    travelBatch.setBatchNo(batchNo);
	    travelBatch.setEndDate(endDate);
	    travelBatch.setName(name);
	    travelBatch.setStartDate(startDate);
	    travelBatch.setRemarks(remarks);
	    travelBatch.setRelationBatch(relationBatch);
	    travelBatch.setSubsidy(subsidy);
	    travelBatch.setStatus(TravelBatch.STATUS_ACTIVE);
	    travelBatch.setInternalStatus(TravelBatch.INTERNAL_OFF);
	    travelBatch.setAbroadStatus(TravelBatch.ABROAD_OFF);
	    travelBathManager.add(travelBatch, yearId);
	    
		return "pub_add";
 }
 
 public String generateNo() throws IOException
 {
	    HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		//System.err.println(travelBathManager.generateNo(yearId));
		out.print(travelBathManager.generateNo(yearId));
		out.flush();
		out.close();
	    return null;
 }
 public String update()
 {
	    TravelBatch travelBatch = new TravelBatch();
	    travelBatch.setId(id);
	    travelBatch.setBatchNo(batchNo);
	    travelBatch.setEndDate(endDate);
	    travelBatch.setName(name);
	    travelBatch.setStartDate(startDate);
	    travelBatch.setRemarks(remarks);
	    travelBatch.setRelationBatch(relationBatch);
	    travelBatch.setSubsidy(subsidy);
	    travelBatch.setStatus(TravelBatch.STATUS_ACTIVE);
	    travelBatch.setInternalStatus(TravelBatch.INTERNAL_OFF);
	    travelBatch.setAbroadStatus(TravelBatch.ABROAD_OFF);
	    travelBathManager.update(travelBatch, yearId);
	   
   return "pub_update";
 }
 
 
 /**
  * 根据id删除用户信息 
  * @return
  */
public String del()
 {
	travelBathManager.del(id);
	return "pub_del";
 }
 
public String list()
 {
    ServletActionContext.getRequest().setAttribute("pm", travelBathManager.searchAll());
    if(select){
    	return "to_select";
    }
    return "to_list";
 }
 
public String addInput()
{
	return "to_input";
}

public String select()
{
	ServletActionContext.getRequest().setAttribute("pm", travelBathManager.select(str1, str2,str3));
   return "to_list";	
}

public String updateInput()
{
	ServletActionContext.getRequest().setAttribute("batch", travelBathManager.find(id));
	return "to_update";
}

public String toSet()
{
	ServletActionContext.getRequest().setAttribute("batch", travelBathManager.find(id));
	return "set_status"; 
	}

public String setStatus() throws Exception
{
	    HttpServletResponse response = ServletActionContext.getResponse();
	    response.setHeader("Pragma","no-cache"); 
	    response.setHeader("Cache-Control","no-cache"); 
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
	    if(flag == 1){
	    	if (onOrOff==1) {
	    		travelBathManager.setInternalOpen(id);
			}
	    	else {
	    		travelBathManager.setInternalOff(id);
			}
	    	
	    	out.print("设置成功");
	    	out.flush();
	    	out.close();
	    }
	    
	    if(flag == 2){
	    	if (onOrOff==1) {
	    		travelBathManager.setAbroadOpen(id);
			}
	    	else {
	    		travelBathManager.setAbroadOff(id);
			}
	    	out.flush();
	    	out.close();
	    	out.print("设置成功");
	    }
		
	    if(flag == 3){
	    	if (onOrOff==1) {
	    		travelBathManager.setSaved(id);
			}
	    	out.flush();
	    	out.close();
	    	out.print("设置成功");
	    }	
	    
	    InitRouteUtil.loadRoute(ServletActionContext.getServletContext());
        return null;
	}

public String setOne()
{
	HttpServletRequest request = ServletActionContext.getRequest();
	request.setAttribute("batch", travelBathManager.find(id));
	request.setAttribute("datas1", travelRouteManager.searchOneRouteInternal(id));
	request.setAttribute("datas2", travelRouteManager.searchOneRouteAbroad(id));
	return "to_onebatch";
}

public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}


}
