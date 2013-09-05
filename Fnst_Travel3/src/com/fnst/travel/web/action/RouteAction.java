package com.fnst.travel.web.action;

import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.TravelRoute;

import com.fnst.travel.service.TravelBathManager;
import com.fnst.travel.service.TravelRouteManager;

@SuppressWarnings("serial")
public class RouteAction extends BaseAction {
	private int id;
	private String routeNo;
	private String name;
	private Date startDate;
	private Date endDate;
	private float price;
	private String description;
	private int maxAmount;

	
	
	private int batchId;

	private int isBoard;

	private String str1;
	private String str2;
	private String str3;
	
	
	public String getStr3() {
		return str3;
	}

	public void setStr3(String str3) {
		this.str3 = str3;
	}

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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRouteNo() {
		return routeNo;
	}

	public void setRouteNo(String routeNo) {
		this.routeNo = routeNo;
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

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(int maxAmount) {
		this.maxAmount = maxAmount;
	}

	public int getBatchId() {
		return batchId;
	}

	public void setBatchId(int batchId) {
		this.batchId = batchId;
	}

	public int getIsBoard() {
		return isBoard;
	}

	public void setIsBoard(int isBoard) {
		this.isBoard = isBoard;
	}

	private TravelRouteManager travelRouteManager;

	public void setTravelRouteManager(TravelRouteManager travelRouteManager) {
		this.travelRouteManager = travelRouteManager;
	}

	private TravelBathManager travelBathManager;

	public void setTravelBathManager(TravelBathManager travelBathManager) {
		this.travelBathManager = travelBathManager;
	}

	public String select()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("batch", travelBathManager.find(batchId));
		request.setAttribute("datas1", travelRouteManager.select(str1, str2, batchId, TravelRoute.NOT_BOARD));
		request.setAttribute("datas2", travelRouteManager.select(str1, str2, batchId, TravelRoute.IS_BOARD));
		return "to_onebatch";
	}
	
	public String search()
	{   
		if(null == str1){
			str1="";
		} 
		if(null == str2){
			str2="";
		} 
		if(null == str3){
			str3="";
		} 
		ServletActionContext.getRequest().setAttribute("pm", travelRouteManager.select(str1, str2, str3));
		return "to_list";
	}
	public String add() {
		TravelRoute travelRoute = new TravelRoute();
		travelRoute.setDescription(description);
		travelRoute.setEndDate(endDate);
		travelRoute.setIsBoard(isBoard);
		travelRoute.setMaxAmount(maxAmount);
		travelRoute.setPrice(price);
		travelRoute.setRouteNo(routeNo);
		travelRoute.setName(name);
		travelRoute.setStartDate(startDate);

		travelRouteManager.add(travelRoute, batchId);
		return "pub_add";
	}

	public String generateNo() throws Exception {
		//System.err.println(batchId + ":" + isBoard);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String no = travelRouteManager.generateNo(batchId, isBoard);
		out.print(no);
		out.flush();
		out.close();
		return null;
	}

	public String update() {

		TravelRoute travelRoute = new TravelRoute();
		travelRoute.setId(id);
		travelRoute.setDescription(description);
		travelRoute.setEndDate(endDate);
		travelRoute.setIsBoard(isBoard);
		travelRoute.setMaxAmount(maxAmount);
		travelRoute.setPrice(price);
		travelRoute.setRouteNo(routeNo);
		travelRoute.setName(name);
		travelRoute.setStartDate(startDate);

		travelRouteManager.update(travelRoute, batchId);
		return "pub_update";
	}

	/**
	 * 根据id删除用户信息
	 * 
	 * @return
	 */
	public String del() {
		travelRouteManager.del(id);
		return "pub_del";
	}

	public String list() {

		return "to_list";
	}

	public String addInput() {
		ServletActionContext.getRequest().setAttribute("batch",
				travelBathManager.find(batchId));
		return "to_input";
	}

	public String updateInput() {
		ServletActionContext.getRequest().setAttribute("route",
				travelRouteManager.find(id));
		return "to_update";
	}

	
	public String export() {
		/*
		 * HttpServletResponse response = ServletActionContext.getResponse();
		 * 
		 * response.setContentType("application/msexcel;charset=UTF-8"); //
		 * 两种方法都可以 //
		 * response.setContentType("application/octet-stream;charset=iso-8859-1"
		 * ); try { response.setHeader("Content-Disposition",
		 * "attachment;filename=" + new String(("员工一览表.xls").getBytes(),
		 * "iso-8859-1")); } catch (UnsupportedEncodingException e) {
		 * e.printStackTrace(); } // 客户端不缓存 response.addHeader("Pargam",
		 * "no-cache"); response.addHeader("Cache-Control", "no-cache");
		 * 
		 * try { OutputStream os = response.getOutputStream();
		 * employeeManager.export(os); os.flush(); os.close(); } catch
		 * (IOException e) { throw new SystemException("导出失败"); } //
		 * erportExcel(os);
		 */
		return null;
	}

	public String toImport() {
		return "to_import";

	}

}
