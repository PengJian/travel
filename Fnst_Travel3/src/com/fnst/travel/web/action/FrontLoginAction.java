package com.fnst.travel.web.action;

import java.security.NoSuchAlgorithmException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.springframework.dao.DataAccessResourceFailureException;

import com.fnst.travel.model.Employee;
import com.fnst.travel.service.EmployeeManager;
import com.fnst.travel.service.EmployeeRouteManager;
import com.fnst.travel.service.LogManager;
import com.fnst.travel.util.MD5;

@SuppressWarnings("serial")
public class FrontLoginAction extends BaseAction {
	private int userId;
	private String username;
	private String password;
	private String rand;
	
	private LogManager logManager;
	public void setLogManager(LogManager logManager) {
		this.logManager = logManager;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}

	private EmployeeManager employeeManager;
	private EmployeeRouteManager employeeRouteManager;
	public void setEmployeeRouteManager(EmployeeRouteManager employeeRouteManager) {
		this.employeeRouteManager = employeeRouteManager;
	}
	public void setEmployeeManager(EmployeeManager employeeManager) {
		this.employeeManager = employeeManager;
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

	public String getRand() {
		return rand;
	}

	public void setRand(String rand) {
		this.rand = rand;
	}
    
	public String login() throws DataAccessResourceFailureException, HibernateException, IllegalStateException, NoSuchAlgorithmException {
		if (null == rand || "".equals(rand)) {
			this.addActionMessage("验证码不能为空");
			return "to_login";
		}
		String rand1 = (String) ServletActionContext.getRequest().getSession()
				.getAttribute("rand");
		if(null==rand1){
			return "to_login";
		}
		if (!rand1.equalsIgnoreCase(rand)) {
			this.addActionMessage("验证码不正确");
			return "to_login";
		}
		String ip = ServletActionContext.getRequest().getRemoteAddr();
		Employee employee = employeeManager.login(username,password);
		if (null == employee) {
			this.addActionMessage("用户名或密码不正确");
			return "to_login";
		}
        		
	    if(MD5.md5("fnst1234").equals(password)){
	    	ServletActionContext.getRequest().getSession().setAttribute("temp", employee.getId());
	    	return "to_updatePwd";
	    }		    
	    HttpSession session = (HttpSession)getServletContext().getAttribute(username);
	    if(null != session && !session.getId().equals(getSession().getId())){
	    	try {
	    		if(null != session.getAttribute("user")){
			     	session.removeAttribute("user");
		    	}
			} catch (Exception e) {
				//
			}
	    }
		getServletContext().setAttribute(username, getSession());
	    employee.setLoginFlag(Employee.LOGIN_ON);
	    employee.setIpStr(ip);
	    employeeManager.update(employee);
	    getSession().setAttribute("user", employee);
		getSession().setAttribute("num",employeeManager.getTravelNum(employee.getId()));
		getSession().setAttribute("applyStatus", employeeRouteManager.getEmployeeRouteStatus(employee.getId()));
		logManager.addLog(employee, "login",new Date());
		//return "to_index";
	    getRequest().setAttribute("flag","true");
		return "to_help";
	}
	
	public String logout()
	{
		Employee employee = null;;
		try {
			employee = getCurrentUser();
		} catch (Exception e) {
			return "to_login";
		}
		
		if(employee != null){
			logManager.addLog(employee, "logOut",new Date());
			employee.setLoginFlag(Employee.LOGIN_OFF);
			employee.setIpStr(Employee.IP_NULL);
			employeeManager.update(employee);
			ServletActionContext.getRequest().getSession().removeAttribute("user");			
		}
		
		return "to_login";
	}
	
	public String updatePwd() throws NoSuchAlgorithmException
	{
		Employee employee = (Employee)employeeManager.find(userId);
		employee.setPassword(MD5.md5(password));
		employeeManager.update(employee);
		ServletActionContext.getRequest().getSession().removeAttribute("temp");
		return "to_login";
	}
}
