package com.fnst.travel.service;

import java.io.File;
import java.io.OutputStream;
import java.util.List;

import com.fnst.travel.model.Employee;
import com.fnst.travel.util.PageModel;

public interface EmployeeManager {
 public Employee login(String username,String password); 
 public void add(Employee employee);
 public Employee find(int id);
 public void update(Employee employee);
 public void del(int id);
 public void export(OutputStream os);
 public void importData(File excelFile,String filename);
 public PageModel searchByConditon(String username,String name);
 public PageModel searchALL();
 public List<Employee> searchALlNotByPage();
 public int getTravelNum(int employeeId);
 public PageModel select(String str1,String str2);
}
