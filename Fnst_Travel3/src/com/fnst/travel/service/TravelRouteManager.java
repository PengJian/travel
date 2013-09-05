package com.fnst.travel.service;

import java.util.List;

import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.util.PageModel;

public interface TravelRouteManager {
public void add(TravelRoute travelRoute ,int travelBatchId);
public void del(int id);
public void update(TravelRoute travelRoute,int travelBatchId);
public TravelRoute find(int id);
public List<TravelRoute> searchOneBatchRoute(int yearId,int bacthId);
public List<TravelRoute> searchCurrentOpenRoute();
public List<TravelRoute> searchOneRouteAbroad(int batchId);
public List<TravelRoute> searchOneRouteInternal(int batchId);
public String generateNo(int batchId,int isBroad);
public List<TravelRoute> select(String str1,String str2,int batchId,int flag);
public PageModel select(String str1,String str2,String str3);
public List<TravelRoute> searchCurrentActvieBatchOffRoute();
public List<TravelRoute> searchActiveBatchRoutes();
public List<TravelRoute> searchActiveBatchBoardRoutes();
public List<TravelRoute> searchActiveBatchInternalRoutes();

}
