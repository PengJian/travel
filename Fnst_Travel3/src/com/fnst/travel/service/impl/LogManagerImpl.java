package com.fnst.travel.service.impl;

import java.util.Date;

import com.fnst.travel.model.Employee;
import com.fnst.travel.model.UserLog;
import com.fnst.travel.service.LogManager;
import com.fnst.travel.util.PageModel;

public class LogManagerImpl  extends AbstractManager implements LogManager {

	public void addLog(Employee employee, String action ,Date date) {
		String userInfo = employee.getUsername()+":"+employee.getName()
		                  +":"+ employee.getIpStr();
		UserLog userLog = new UserLog();
		userLog.setUserInfo(userInfo);
		userLog.setAction(action);
		userLog.setDate(date);
		getHibernateTemplate().save(userLog);
	}

	public PageModel select(String str) {
		return searchPaginated(
				"from UserLog ul where ul.userInfo like ?",
				"%"+str+"%");
	}

	public PageModel searchAll() {
		return searchPaginated(
				"from UserLog ul");

	}

}
