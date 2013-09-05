package com.fnst.travel.model;

import java.util.Date;

/**
 * @hibernate.class table="t_TravelRoute"
 * @author Administrator
 *
 */
public class TravelRoute {
private int id;
private String routeNo;
private String name;
private Date startDate;
private Date endDate;
private float price;
private String description;
private int maxAmount;

private TravelBatch travelBatch;

private int isBoard;

public static final int IS_BOARD=1;
public static final int NOT_BOARD=0;

/**
 * @hibernate.id generator-class="native"
 * @return
 */
public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

/**
 * @hibernate.property 
 * @return
 */
public String getRouteNo() {
	return routeNo;
}

public void setRouteNo(String routeNo) {
	this.routeNo = routeNo;
}

/**
 * @hibernate.property 
 * @return
 */
public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

/**
 * @hibernate.property 
 * @return
 */
public Date getStartDate() {
	return startDate;
}

public void setStartDate(Date startDate) {
	this.startDate = startDate;
}
/**
 * @hibernate.property 
 * @return
 */
public Date getEndDate() {
	return endDate;
}

public void setEndDate(Date endDate) {
	this.endDate = endDate;
}

/**
 * @hibernate.property 
 * @return
 */
public float getPrice() {
	return price;
}

public void setPrice(float price) {
	this.price = price;
}
/**
 * @hibernate.property 
 * @return
 */
public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}
/**
 * @hibernate.property 
 * @return
 */
public int getMaxAmount() {
	return maxAmount;
}

public void setMaxAmount(int maxAmount) {
	this.maxAmount = maxAmount;
}
/**
 * @hibernate.many-to-one
 * @return
 */
public TravelBatch getTravelBatch() {
	return travelBatch;
}

public void setTravelBatch(TravelBatch travelBatch) {
	this.travelBatch = travelBatch;
}
/**
 * @hibernate.property 
 * @return
 */
public int getIsBoard() {
	return isBoard;
}

public void setIsBoard(int isBoard) {
	this.isBoard = isBoard;
}


}
