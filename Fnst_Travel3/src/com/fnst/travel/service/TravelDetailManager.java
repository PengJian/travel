package com.fnst.travel.service;

import com.fnst.travel.model.TravelDetail;

public interface TravelDetailManager {
  public void add(String detail,int routeId);
  public TravelDetail findByRouteId(int routeId);
  public void del(int id);
  public void update(TravelDetail travelDetail,int travelRouteId);
  public TravelDetail find(int id);
}
