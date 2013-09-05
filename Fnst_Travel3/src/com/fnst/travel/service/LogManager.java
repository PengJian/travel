package com.fnst.travel.service;

import java.util.Date;

import com.fnst.travel.model.Employee;
import com.fnst.travel.util.PageModel;

public interface LogManager {
public void addLog(Employee employee,String action,Date date);
public PageModel select(String str);

public PageModel searchAll();
}
