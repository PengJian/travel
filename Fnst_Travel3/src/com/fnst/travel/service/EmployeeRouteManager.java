package com.fnst.travel.service;

import java.util.List;

import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.util.PageModel;

public interface EmployeeRouteManager {
public boolean isCanAdd(int employeeId);
public void add(EmployeeRoute employeeRoute,int routeId,int employeeId);
public void del(int id);
public void delByUserId(int userId);
public EmployeeRoute findByUserId(int userId);
public List<Object[]> calculateRouteParticipants();
public EmployeeRoute find(int id);
/**
 * @param employeeId
 * @return 0:还没有参加报名  !0:返回报名的线路号
 */
public int getEmployeeRouteStatus(int employeeId);
public List<EmployeeRoute> searchbyRouteId(int routeId);
public void update(EmployeeRoute employeeRoute);
public List<EmployeeRoute> searchAll();
public List<EmployeeRoute> selectActive(String username,String name,int id,int flag);
public PageModel searchHistoryAll();
public int getTravelSumByRouteId(int routeID);
public int getActiveTravelSum(String username,String name,int routeId,int isBorad);
}
