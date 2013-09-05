package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.BatchExpenses;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.ExpenseManager;
import com.fnst.travel.service.TravelRouteManager;

@SuppressWarnings("serial")
public class ExpenseAction extends BaseAction {
private ExpenseManager expenseManager;
private TravelRouteManager travelRouteManager;
public void setTravelRouteManager(TravelRouteManager travelRouteManager) {
	this.travelRouteManager = travelRouteManager;
}
public void setExpenseManager(ExpenseManager expenseManager) {
	this.expenseManager = expenseManager;
}


private int id;
private int routeId;
private int batchId;
private int isBoard = -1;
private String batchNo;
private String batchName;
private String routeNo;
private String routeName;
private String username;
private String name;
private int familyNum;
private float companyExpenses;
private float personalExpenses;
private float familyExpenses;
private float familyOff;
private float totalExpenses;
private float needExpenses;
private String remarks;


public String toList()
{
	getRequest().setAttribute("datas", expenseManager.searchAll());
	getRequest().setAttribute("routes", travelRouteManager.searchActiveBatchRoutes());
	return "to_list";
}

public String load()
{   
	expenseManager.load();
	getRequest().setAttribute("datas", expenseManager.searchAll());
	getRequest().setAttribute("routes", travelRouteManager.searchActiveBatchRoutes());
	return "to_list";
}

public String update() throws IOException
{
	HttpServletResponse response = ServletActionContext.getResponse();
	response.setHeader("CacheControl", "no-cache");
	response.setContentType("html/text;charset=utf-8");
	PrintWriter out = response.getWriter();
	BatchExpenses batchExpenses = expenseManager.find(id);
	batchExpenses.setRemarks(remarks);
	batchExpenses.setFamilyExpenses(familyExpenses);
	batchExpenses.setFamilyOff(familyOff);
	batchExpenses.setTotalExpenses(batchExpenses.getPersonalExpenses() + familyExpenses);
	batchExpenses.setNeedExpenses(batchExpenses.getTotalExpenses() - batchExpenses.getCompanyExpenses()-familyOff);
	
	expenseManager.update(batchExpenses);
	
	out.print("保存成功");
	out.flush();
	out.close();
	return null;
}

public String select()
{
	List<TravelRoute> list3 = new ArrayList<TravelRoute>();
	if(-1==isBoard){ 
		list3 = travelRouteManager.searchActiveBatchRoutes();
	}else if(1==isBoard){
		 list3 = travelRouteManager.searchActiveBatchBoardRoutes();
	}else if(0==isBoard){
		 list3 = travelRouteManager.searchActiveBatchInternalRoutes();
	}
	getRequest().setAttribute("datas", expenseManager.select(isBoard, routeId, username, name));	
	getRequest().setAttribute("routes", list3);
	return "to_list";
}


public String export() {
	
	List<BatchExpenses> list = expenseManager.select(isBoard,routeId,"","");
	HttpServletResponse response = ServletActionContext.getResponse();

	response.setContentType("application/msexcel;charset=UTF-8"); // 两种方法都可以
	// response.setContentType("application/octet-stream;charset=iso-8859-1");
	try {
		response.setHeader("Content-Disposition", "attachment;filename="
				+ new String(("FNST-Expenselist.xls").getBytes(), "iso-8859-1"));
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
	// 客户端不缓存
	response.addHeader("Pargam", "no-cache");
	response.addHeader("Cache-Control", "no-cache");

	try {
		OutputStream os = response.getOutputStream();
		export(os,list);
		os.flush();
		os.close();
	} catch (IOException e) {
		throw new SystemException("导出失败");
	}
	// erportExcel(os);

	return null;
}

public void export(OutputStream os,List<BatchExpenses> list) {
	Workbook book = new HSSFWorkbook();
	Sheet sheet = book.createSheet("报名费用一览");
	Row row = sheet.createRow(0);
	row.createCell(0).setCellValue("编号");
	row.createCell(1).setCellValue("线路名");
	row.createCell(2).setCellValue("工号");
	row.createCell(3).setCellValue("姓名");
	row.createCell(4).setCellValue("个人费用");
	row.createCell(5).setCellValue("个人补贴");
	row.createCell(6).setCellValue("家属人数");
	row.createCell(7).setCellValue("家属费用");
	row.createCell(8).setCellValue("家属补贴");
	row.createCell(9).setCellValue("总费用");
	row.createCell(10).setCellValue("最后需交费用");	
	row.createCell(11).setCellValue("备注");
	// CellStyle sty = book.createCellStyle();

	for (int i = 0; i < list.size(); i++) {
		BatchExpenses item = (BatchExpenses) list.get(i);
		row = sheet.createRow(i + 1);
		row.createCell(0).setCellValue(i+1);
		row.createCell(1).setCellValue(item.getRouteName());
		row.createCell(2).setCellValue(item.getUsername());
		row.createCell(3).setCellValue(item.getName());
		row.createCell(4).setCellValue(item.getPersonalExpenses());
		row.createCell(5).setCellValue(item.getCompanyExpenses());
		row.createCell(6).setCellValue(item.getFamilyNum());
		row.createCell(7).setCellValue(item.getFamilyExpenses());
		row.createCell(8).setCellValue(item.getFamilyOff());
		row.createCell(9).setCellValue(item.getTotalExpenses());
		row.createCell(10).setCellValue(item.getNeedExpenses());
		row.createCell(11).setCellValue(item.getRemarks());
	}

	try {
		book.write(os);
	} catch (Exception e) {
		throw new SystemException("导出费用信息失败");
	}

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
public String getBatchNo() {
	return batchNo;
}
public void setBatchNo(String batchNo) {
	this.batchNo = batchNo;
}
public String getBatchName() {
	return batchName;
}
public void setBatchName(String batchName) {
	this.batchName = batchName;
}
public String getRouteNo() {
	return routeNo;
}
public void setRouteNo(String routeNo) {
	this.routeNo = routeNo;
}
public String getRouteName() {
	return routeName;
}
public void setRouteName(String routeName) {
	this.routeName = routeName;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getFamilyNum() {
	return familyNum;
}
public void setFamilyNum(int familyNum) {
	this.familyNum = familyNum;
}
public float getCompanyExpenses() {
	return companyExpenses;
}
public void setCompanyExpenses(float companyExpenses) {
	this.companyExpenses = companyExpenses;
}
public float getPersonalExpenses() {
	return personalExpenses;
}
public void setPersonalExpenses(float personalExpenses) {
	this.personalExpenses = personalExpenses;
}
public float getFamilyExpenses() {
	return familyExpenses;
}
public void setFamilyExpenses(float familyExpenses) {
	this.familyExpenses = familyExpenses;
}
public float getFamilyOff() {
	return familyOff;
}
public void setFamilyOff(float familyOff) {
	this.familyOff = familyOff;
}
public float getTotalExpenses() {
	return totalExpenses;
}
public void setTotalExpenses(float totalExpenses) {
	this.totalExpenses = totalExpenses;
}
public float getNeedExpenses() {
	return needExpenses;
}
public void setNeedExpenses(float needExpenses) {
	this.needExpenses = needExpenses;
}
public String getRemarks() {
	return remarks;
}
public void setRemarks(String remarks) {
	this.remarks = remarks;
}
public ExpenseManager getExpenseManager() {
	return expenseManager;
}
public TravelRouteManager getTravelRouteManager() {
	return travelRouteManager;
}


}
