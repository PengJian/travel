package com.fnst.travel.service;

import java.util.List;

import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.util.PageModel;

public interface TravelBathManager {
public void add(TravelBatch travelBatch,int travelYearId);
public void del(int id);
public void update(TravelBatch travelBatch,int travelYearId);
public void update(TravelBatch travelBatch);
public TravelBatch find(int id);
public PageModel searchAll();
public List<TravelBatch> searchByYearId(int yearId);
public List<String> searchRalationBatch(int id);
public void delByYearId(int yearId);
public void setSaved(int bathId);
public void setAbroadOpen(int bathId);
public void setInternalOpen(int bathId);
public void setAbroadOff(int bathId);
public void setInternalOff(int bathId);
public boolean ifCanAdd();
public boolean ifCanEdit(int id);
public boolean ifCanOpen(int id);
public boolean ifCanDel(int id);
public String generateNo(int yearId);
public PageModel select(String str1,String str2,String str3);
}
