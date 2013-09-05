package com.fnst.travel.service;

import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.util.PageModel;

public interface TravelYearManager {
	public void add(TravelYearth travelYearth);
	public void del(int id);
	public void update(TravelYearth travelYearth);
	public TravelYearth find(int id);
	public TravelYearth findByYearth(String year);
	public PageModel searchAll();
	public String getCanSetIntention();
}
