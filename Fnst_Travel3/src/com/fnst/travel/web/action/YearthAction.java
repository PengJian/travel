package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.service.TravelYearManager;

@SuppressWarnings("serial")
public class YearthAction extends BaseAction {
 private int id;
 private int intention;
 private String  year;
 private String  remarks;
 private float employeeOff = 4000;
 private float familyOff = 2000;
 
 
public float getEmployeeOff() {
	return employeeOff;
}

public void setEmployeeOff(float employeeOff) {
	this.employeeOff = employeeOff;
}

public float getFamilyOff() {
	return familyOff;
}

public void setFamilyOff(float familyOff) {
	this.familyOff = familyOff;
}

private boolean select = false;


public boolean isSelect() {
	return select;
}

public void setSelect(boolean select) {
	this.select = select;
}

public int getIntention() {
	return intention;
}

public void setIntention(int intention) {
	this.intention = intention;
}

private TravelYearManager travelYearManager;
public void setTravelYearManager(TravelYearManager travelYearManager) {
	this.travelYearManager = travelYearManager;
}
 
 public String add()
 {
	    TravelYearth travelYearth = new TravelYearth();
	    travelYearth.setYear(year);
	    travelYearth.setRemarks(remarks);
	    travelYearth.setEmployeeOff(employeeOff);
	    travelYearth.setFamilyOff(familyOff);
	    travelYearManager.add(travelYearth);
		return "pub_add";
 }
 
 public String update()
 {
	 TravelYearth travelYearth = new TravelYearth();
	    travelYearth.setId(id);
	    travelYearth.setYear(year);
	    travelYearth.setRemarks(remarks);
	    travelYearth.setEmployeeOff(employeeOff);
	    travelYearth.setFamilyOff(familyOff);
	    travelYearManager.update(travelYearth);
   return "pub_update";
 }
 
 
 /**
  * 根据id删除用户信息 
  * @return
  */
public String del()
 {
	travelYearManager.del(id);
	return "pub_del";
 }
 
public String list()
 {
    ServletActionContext.getRequest().setAttribute("pm", travelYearManager.searchAll());
    if(select){
    	return "to_select";
    }
    return "to_list";
 }

public String startIntention()
{
	getRequest().setAttribute("pm", travelYearManager.searchAll());
	return "to_intention";
}


public String setStatus() throws IOException
{
	HttpServletResponse response = ServletActionContext.getResponse();
	response.setHeader("CacheControl", "no-cache");
	response.setContentType("text/html;charset=utf-8");
	PrintWriter out = response.getWriter();	
	String inten = travelYearManager.getCanSetIntention();
    if(1 == intention){
    	if(null != inten){
          out.print("目前已有年份开启调查，请先关闭");
          out.flush();
          out.close();
    	}else {
    		TravelYearth travelYearth = travelYearManager.find(id);
    		travelYearth.setStartIntention(TravelYearth.INTENTION_OPEN);
    		travelYearManager.update(travelYearth);
    		out.print("开启成功");
            out.flush();
            out.close();          
		}
    	 return null;
    }else {
    	TravelYearth travelYearth = travelYearManager.find(id);
		travelYearth.setStartIntention(TravelYearth.INTENTION_CLOSE);
		travelYearManager.update(travelYearth);
		out.print("关闭成功");
        out.flush();
        out.close();    
	}
	return null;
}

public String addInput()
{
	
	return "to_input";
}

public String updateInput()
{
	ServletActionContext.getRequest().setAttribute("yearth", travelYearManager.find(id));
	return "to_update";
}

public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

public String getYear() {
	return year;
}

public void setYear(String year) {
	this.year = year;
}

public String getRemarks() {
	return remarks;
}

public void setRemarks(String remarks) {
	this.remarks = remarks;
}

 
}
