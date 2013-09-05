package com.fnst.travel.service;

import java.util.List;

import com.fnst.travel.model.Family;

public interface FamilyManager {
public void add(Family family,int employeeId);
public void del(int id);
public void update(Family family);
public void setIsTravelOrNot(int id,int flag);
public Family find(int id);
public List<Family> findByEmployeeId(int employeeId);
public List<Family> findIsTravelFamilyByEmployeeId(int employeeId);
}
