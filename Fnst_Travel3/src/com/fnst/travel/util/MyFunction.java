package com.fnst.travel.util;

import com.fnst.travel.service.ApplyTimeManager;
import com.fnst.travel.service.TravelBathManager;

public class MyFunction {
private static TravelBathManager travelBathManager;
private static ApplyTimeManager applyTimeManager;

public void setApplyTimeManager(ApplyTimeManager applyTimeManager) {
	MyFunction.applyTimeManager = applyTimeManager;
}

public void setTravelBathManager(TravelBathManager travelBathManager) {
	MyFunction.travelBathManager = travelBathManager;
}

public static boolean ifCanAdd(){
	return travelBathManager.ifCanAdd();
}
public static boolean ifCanEdit(int id){
	return travelBathManager.ifCanEdit(id); 
}
public static boolean ifCanOpen(int id){
	return travelBathManager.ifCanOpen(id);
}
public static boolean ifCanDel(int id){
	return travelBathManager.ifCanDel(id);
}
public static boolean isDuringApplyTime()
{
	return applyTimeManager.isDuringApplyTime();
}
}
