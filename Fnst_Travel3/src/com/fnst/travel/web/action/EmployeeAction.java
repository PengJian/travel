package com.fnst.travel.web.action;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.Employee;
import com.fnst.travel.service.EmployeeManager;
import com.fnst.travel.util.MD5;

@SuppressWarnings("serial")
public class EmployeeAction extends BaseAction {

	private EmployeeManager employeeManager;

	private int id;
	private String username;
	private String password;
	private String name;
	private String sex;
	private String identityNo;
	private String telephone;
	private File excelFile;
	private String excelFileFileName;

	private String str1;
	private String str2;
	
	
	
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

	public void setExcelFileFileName(String excelFileFileName) {
		this.excelFileFileName = excelFileFileName;
	}

	public String getExcelFileFileName() {
		return excelFileFileName;
	}

	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}

	public File getExcelFile() {
		return excelFile;
	}

	public String add() throws NoSuchAlgorithmException {
		Employee employee = new Employee();
		employee.setName(name);
		employee.setUsername(username);
		employee.setPassword(MD5.md5(password));
		employee.setSex(sex);
		employee.setTelephone(telephone);
		employee.setIdentityNo(identityNo);
		employee.setLoginFlag(Employee.LOGIN_OFF);
		employee.setIpStr(Employee.IP_NULL);
		employeeManager.add(employee);
		return "pub_add";
	}

	public String update() {
		Employee employee = employeeManager.find(id);
		employee.setId(id);
		employee.setName(name);
		employee.setUsername(username);
		employee.setSex(sex);
		employee.setTelephone(telephone);
		employee.setIdentityNo(identityNo);
		employeeManager.update(employee);
		return "pub_update";
	}

	/**
	 * 根据id删除用户信息
	 * 
	 * @return
	 */
	public String del() {
		employeeManager.del(id);
		return "pub_del";
	}

	public String list() {
		ServletActionContext.getRequest().setAttribute("pm",
				employeeManager.searchALL());
		return "to_list";
	}

	public String select()
	{
		try {
			ServletActionContext.getRequest().setAttribute("pm", employeeManager.select(str1, str2));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return "to_list";
	}
	
	public String addInput() {

		return "to_input";
	}

	public String updateInput() {
		ServletActionContext.getRequest().setAttribute("employee",
				employeeManager.find(id));
		return "to_update";
	}

	public String export() {
		HttpServletResponse response = ServletActionContext.getResponse();

		response.setContentType("application/msexcel;charset=UTF-8"); // 两种方法都可以
		// response.setContentType("application/octet-stream;charset=iso-8859-1");
		try {
			response.setHeader("Content-Disposition", "attachment;filename="
					+ new String(("FNST-EmployeeList.xls").getBytes(), "iso-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 客户端不缓存
		response.addHeader("Pargam", "no-cache");
		response.addHeader("Cache-Control", "no-cache");

		try {
			OutputStream os = response.getOutputStream();
			employeeManager.export(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			throw new SystemException("导出失败");
		}
		// erportExcel(os);

		return null;
	}

	public String toImport() {
		return "to_import";

	}

	public String importData() {
		//System.err.println(excelFileFileName);
		employeeManager.importData(excelFile, excelFileFileName);
		return "pub_import";
	}

	public String updateInfo() throws IOException, NoSuchAlgorithmException
	{   
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Employee employee = getCurrentUser();
		employee.setName(name);
		employee.setSex(sex);
		employee.setTelephone(telephone);
		employee.setIdentityNo(identityNo);
		employeeManager.update(employee);
		out.print("信息修改成功");
		out.flush();
		out.close();
		return null;
	}
	
	public String resetPassword() throws NoSuchAlgorithmException {
	    Employee employee = employeeManager.find(id);
	    employee.setPassword(MD5.md5("fnst1234"));
	    employeeManager.update(employee);
	    return "pub_reset";
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIdentityNo() {
		return identityNo;
	}

	public void setIdentityNo(String identityNo) {
		this.identityNo = identityNo;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public EmployeeManager getEmployeeManager() {
		return employeeManager;
	}

	public void setEmployeeManager(EmployeeManager employeeManager) {
		this.employeeManager = employeeManager;
	}

}
