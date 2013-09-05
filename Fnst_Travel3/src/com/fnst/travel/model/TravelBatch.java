package com.fnst.travel.model;

import java.util.Date;

/**
 * @hibernate.class table="t_TravelBatch"
 * @author Administrator
 *
 */
public class TravelBatch {
 private int id;
 private String batchNo;
 private String name;
 private Date startDate;
 private Date endDate;
 private float subsidy;
 private int intentionNum;
 
 private TravelYearth travelYearth;
 private String relationBatch;
 private int status;
 private int abroadStatus;
 private int internalStatus;
 
 private String remarks;

 
 public static final int STATUS_ACTIVE=0;
 public static final int STATUS_SAVED=1;
 public static final int ABROAD_OFF=0;
 public static final int ABROAD_ON=1;
 public static final int INTERNAL_OFF=0;
 public static final int INTERNAL_ON=1;
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
public float getSubsidy() {
	return subsidy;
}


public void setSubsidy(float subsidy) {
	this.subsidy = subsidy;
}

/**
 * @hibernate.property 
 * @return
 */
public int getIntentionNum() {
    return intentionNum;
}

public void setIntentionNum(int intentionNum) {
    this.intentionNum = intentionNum;
}


/**
 * @hibernate.property 
 * @return
 */
public String getRelationBatch() {
	return relationBatch;
}


public void setRelationBatch(String relationBatch) {
	this.relationBatch = relationBatch;
}

/**
 * @hibernate.property 
 * @return
 */
public int getStatus() {
	return status;
}


public void setStatus(int status) {
	this.status = status;
}

/**
 * @hibernate.property 
 * @return
 */
public int getAbroadStatus() {
	return abroadStatus;
}


public void setAbroadStatus(int abroadStatus) {
	this.abroadStatus = abroadStatus;
}

/**
 * @hibernate.property 
 * @return
 */
public int getInternalStatus() {
	return internalStatus;
}


public void setInternalStatus(int internalStatus) {
	this.internalStatus = internalStatus;
}

/**
 * @hibernate.property 
 * @return
 */
public String getRemarks() {
	return remarks;
}


public void setRemarks(String remarks) {
	this.remarks = remarks;
}




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
public String getBatchNo() {
	return batchNo;
}


public void setBatchNo(String batchNo) {
	this.batchNo = batchNo;
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
 * @hibernate.many-to-one
 * @return
 */
public TravelYearth getTravelYearth() {
	return travelYearth;
}


public void setTravelYearth(TravelYearth travelYearth) {
	this.travelYearth = travelYearth;
}
 
 
}
