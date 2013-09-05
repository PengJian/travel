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
import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.model.Family;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.EmployeeRouteManager;
import com.fnst.travel.service.FamilyManager;
import com.fnst.travel.service.TravelRouteManager;
import com.google.gson.Gson;

@SuppressWarnings("serial")
public class EmployeeRouteAction extends BaseAction{
  private EmployeeRouteManager employeeRouteManager;
  private FamilyManager familyManager;
  private TravelRouteManager travelRouteManager;
  public void setTravelRouteManager(TravelRouteManager travelRouteManager) {
	this.travelRouteManager = travelRouteManager;
}
  public void setFamilyManager(FamilyManager familyManager) {
	this.familyManager = familyManager;
}
  private int id;
  private int flag = -1;
  private String str1="";
  private String str2="";
  
  
  public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public int getFlag() {
	return flag;
}


public void setFlag(int flag) {
	this.flag = flag;
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


public void setEmployeeRouteManager(EmployeeRouteManager employeeRouteManager) {
	this.employeeRouteManager = employeeRouteManager;
}
  
public String listActive()
{
	
	List<EmployeeRoute> list = employeeRouteManager.searchAll();
	List<DataObject> list2 = new ArrayList<EmployeeRouteAction.DataObject>();
	for(EmployeeRoute employeeRoute:list){
		DataObject dataObject = new DataObject(employeeRoute,familyManager
				                .findByEmployeeId(employeeRoute.getEmployee().getId()));
		list2.add(dataObject);
	}
	int total = employeeRouteManager.getActiveTravelSum("", "", 0, -1);
	int subnum = list.size();
	getRequest().setAttribute("total", total);
	getRequest().setAttribute("sub",subnum);
	getRequest().setAttribute("datas", list2);
	getRequest().setAttribute("routes", travelRouteManager.searchActiveBatchRoutes());
	return "to_activelist";
}

public String selectActive(){  
	List<EmployeeRoute> list = employeeRouteManager.selectActive(str1, str2,id,flag);
	List<DataObject> list2 = new ArrayList<EmployeeRouteAction.DataObject>();
	for(EmployeeRoute employeeRoute:list){
		DataObject dataObject = new DataObject(employeeRoute,familyManager
				                .findByEmployeeId(employeeRoute.getEmployee().getId()));
		list2.add(dataObject);
	}
	List<TravelRoute> list3 = new ArrayList<TravelRoute>();
	if(-1==flag){ 
		list3 = travelRouteManager.searchActiveBatchRoutes();
	 }else if(1==flag){
		 list3 = travelRouteManager.searchActiveBatchBoardRoutes();
	 }else if(0==flag){
		 list3 = travelRouteManager.searchActiveBatchInternalRoutes();
	 }
	int total = employeeRouteManager.getActiveTravelSum(str1, str2, id, flag);
	int subnum =  list.size();
	getRequest().setAttribute("total", total);
	getRequest().setAttribute("sub",subnum);
	
	getRequest().setAttribute("routes", list3);
	getRequest().setAttribute("datas", list2);
	return "to_activelist";
}
public String update()
{	   
  return "pub_update";
}

public String del()
{   
	employeeRouteManager.del(id);
	return "pub_del";
}

public String list()
{
   return "to_list";
}

public String addInput()
{
	return "to_input";
}

public String updateInput()
{
	return "to_update";
}

public String toSet()
{
	return "set_status"; 
	}

public String getRouteList() throws IOException
{
	HttpServletResponse response = ServletActionContext.getResponse();
	response.setHeader("CacheControl", "no-cache");
	response.setContentType("application/json;charset=utf-8");
	
	PrintWriter out = response.getWriter();
	List<TravelRoute> list = new ArrayList<TravelRoute>();
	if(-1==flag){ 
		list = travelRouteManager.searchActiveBatchRoutes();
	 }else if(1==flag){
		 list = travelRouteManager.searchActiveBatchBoardRoutes();
	 }else if(0==flag){
		 list = travelRouteManager.searchActiveBatchInternalRoutes();
	 }
	out.print(new Gson().toJson(list));
	out.flush();
	out.close();
	return null;
}

public String export() {
	
	List<EmployeeRoute> list = employeeRouteManager.selectActive("", "",id,flag);
	List<DataObject> list2 = new ArrayList<EmployeeRouteAction.DataObject>();
	for(EmployeeRoute employeeRoute:list){
		DataObject dataObject = new DataObject(employeeRoute,familyManager
				                .findByEmployeeId(employeeRoute.getEmployee().getId()));
		list2.add(dataObject);
	}
	
	HttpServletResponse response = ServletActionContext.getResponse();

	response.setContentType("application/msexcel;charset=UTF-8"); // 两种方法都可以
	// response.setContentType("application/octet-stream;charset=iso-8859-1");
	try {
		response.setHeader("Content-Disposition", "attachment;filename="
				+ new String(("FNST-Applylist.xls").getBytes(), "iso-8859-1"));
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
	// 客户端不缓存
	response.addHeader("Pargam", "no-cache");
	response.addHeader("Cache-Control", "no-cache");

	try {
		OutputStream os = response.getOutputStream();
		export(os,list2);
		os.flush();
		os.close();
	} catch (IOException e) {
		throw new SystemException("导出失败");
	}
	// erportExcel(os);

	return null;
}

public void export(OutputStream os,List<DataObject> list) {
	Workbook book = new HSSFWorkbook();
	Sheet sheet = book.createSheet("员工导出信息");
	Row row = sheet.createRow(0);
	row.createCell(0).setCellValue("编号");
	row.createCell(1).setCellValue("线路名");
	row.createCell(2).setCellValue("姓名");
	row.createCell(3).setCellValue("工号");
	row.createCell(4).setCellValue("人数");
	row.createCell(5).setCellValue("证件号");
	row.createCell(6).setCellValue("报名时间");
	row.createCell(7).setCellValue("家属信息(关系-姓名-性别-证件号-备注)");

	// CellStyle sty = book.createCellStyle();

	for (int i = 0; i < list.size(); i++) {
		DataObject item = (DataObject) list.get(i);
		row = sheet.createRow(i + 1);
		row.createCell(0).setCellValue(i+1);
		row.createCell(1).setCellValue(item.getData().getTravelRoute().getName());
		row.createCell(2).setCellValue(item.getData().getEmployee().getName());
		row.createCell(3).setCellValue(item.getData().getEmployee().getUsername());
		row.createCell(4).setCellValue(item.getData().getParticipants());
		row.createCell(5).setCellValue(item.getData().getEmployee().getIdentityNo());
		row.createCell(6).setCellValue(item.getData().getDate());
		String str = "";
		for(Family family:item.getFamilies()){
			if(family.getIsTravel() == Family.IS_TRAVEL){
				str = str + family.getRelation()+"-"
				          + family.getName()+"-"
				          + family.getSex() +"-"
				          + family.getIdentityNo()+"-"
				          + family.getRemarks() + " || \r\n";
			}
		}
		row.createCell(7).setCellValue(str);
	}

	try {
		book.write(os);
	} catch (Exception e) {
		throw new SystemException("导出员工信息失败");
	}

}
public class DataObject{
	public EmployeeRoute data;
	public List<Family> families;
		
	public DataObject(EmployeeRoute data, List<Family> families) {
		super();
		this.data = data;
		this.families = families;
	}
	public EmployeeRoute getData() {
		return data;
	}
	public List<Family> getFamilies() {
		return families;
	}
	
}
}

