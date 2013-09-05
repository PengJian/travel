package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.Employee;
import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.service.EmployeeManager;
import com.fnst.travel.service.LogManager;
import com.fnst.travel.service.TravelBathManager;
import com.fnst.travel.service.TravelYearManager;

@SuppressWarnings("serial")
public class IntentionAction extends BaseAction {
	public static Integer flag = 1;
    private int id;
    private int yearId;

    private String batchNo;
    private String name;
    private String year;
   
    private LogManager logManager;
    public void setLogManager(LogManager logManager) {
		this.logManager = logManager;
	}
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getYearId() {
        return yearId;
    }

    public void setYearId(int yearId) {
        this.yearId = yearId;
    }
    
    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
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

    private TravelBathManager travelBathManager;
    private EmployeeManager employeeManager;
    private TravelYearManager travelYearManager;

    public void setTravelBathManager(TravelBathManager travelBathManager) {
        this.travelBathManager = travelBathManager;
    }
    
    public void setEmployeeManager(EmployeeManager employeeManager) {
        this.employeeManager = employeeManager;
    }
    
    public void setTravelYearManager(TravelYearManager travelYearManager) {
        this.travelYearManager = travelYearManager;
    }

    public String list() {
        HttpServletRequest request = ServletActionContext.getRequest();
        String year = travelYearManager.getCanSetIntention();
        List<TravelBatch> list = new ArrayList<TravelBatch>();
        if(null != year){
            TravelYearth travelYearth = travelYearManager.findByYearth(year);
           list = travelBathManager.searchByYearId(travelYearth.getId());
        }
        request.setAttribute("batches", list);
        return "to_list";
    }
    
    public void apply() throws IOException {
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setHeader("CacheControl", "no-cache");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        Employee employee = getCurrentUser();
        logManager.addLog(employee, "apply intention...", new Date());
        if(employee.getIntentionFlag() == Calendar.getInstance().get(Calendar.YEAR)){
            out.print("您已提交调查，请勿重复操作");
            out.flush();
            out.close();
            return;
        }
        employee.setIntentionFlag(Calendar.getInstance().get(Calendar.YEAR));
        employeeManager.update(employee);
        synchronized (flag) {	
	        TravelBatch batch = travelBathManager.find(id);
            batch.setIntentionNum(batch.getIntentionNum() + 1);
            travelBathManager.update(batch);
    	}
        out.println("选择批次成功，多谢参与调查");
        out.flush();
        out.close();
        logManager.addLog(employee, "apply intention succeed", new Date());
    }

}
