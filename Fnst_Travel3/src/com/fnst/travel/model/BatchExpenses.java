package com.fnst.travel.model;

/**
 * @hibernate.class table="t_BatchExpenses"
 * @author Administrator
 *
 */
public class BatchExpenses {
private int id;
private int routeId;
private int batchId;
private int isBoard;
private String batchNo;
private String batchName;
private String routeNo;
private String routeName;
private String username;
private String name;
private int familyNum;
private float companyExpenses;
private float personalExpenses;
private float familyExpenses;
private float familyOff;
private float totalExpenses;
private float needExpenses;
private String saveStatus;
private String remarks;

public static final String NOT_SAVE_STATUS="可归档";
public static final String SAVE_STATUS="已归档";

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
public String getBatchName() {
	return batchName;
}
public void setBatchName(String batchName) {
	this.batchName = batchName;
}
/**
 * @hibernate.property
 * @return
 */
public float getCompanyExpenses() {
	return companyExpenses;
}
public void setCompanyExpenses(float companyExpenses) {
	this.companyExpenses = companyExpenses;
}
/**
 * @hibernate.property
 * @return
 */
public float getPersonalExpenses() {
	return personalExpenses;
}
public void setPersonalExpenses(float personalExpenses) {
	this.personalExpenses = personalExpenses;
}
/**
 * @hibernate.property
 * @return
 */
public float getTotalExpenses() {
	return totalExpenses;
}
public void setTotalExpenses(float totalExpenses) {
	this.totalExpenses = totalExpenses;
}
/**
 * @hibernate.property
 * @return
 */
public String getSaveStatus() {
	return saveStatus;
}
public void setSaveStatus(String saveStatus) {
	this.saveStatus = saveStatus;
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
 * @hibernate.property
 * @return
 */
public int getFamilyNum() {
	return familyNum;
}
public void setFamilyNum(int familyNum) {
	this.familyNum = familyNum;
}
/**
 * @hibernate.property
 * @return
 */
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
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
public String getRouteName() {
	return routeName;
}
public void setRouteName(String routeName) {
	this.routeName = routeName;
}

/**
 * @hibernate.property
 * @return
 */
public float getFamilyExpenses() {
	return familyExpenses;
}
public void setFamilyExpenses(float familyExpenses) {
	this.familyExpenses = familyExpenses;
}
/**
 * @hibernate.property
 * @return
 */
public float getFamilyOff() {
	return familyOff;
}
public void setFamilyOff(float familyOff) {
	this.familyOff = familyOff;
}

/**
 * @hibernate.property
 * @return
 */
public float getNeedExpenses() {
	return needExpenses;
}
public void setNeedExpenses(float needExpenses) {
	this.needExpenses = needExpenses;
}
/**
 * @hibernate.property
 * @return
 */
public int getRouteId() {
	return routeId;
}
public void setRouteId(int routeId) {
	this.routeId = routeId;
}

/**
 * @hibernate.property
 * @return
 */
public int getBatchId() {
	return batchId;
}
public void setBatchId(int batchId) {
	this.batchId = batchId;
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
