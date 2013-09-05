package com.fnst.travel.model;

/**
 * @hibernate.class table="t_TravelYearth"
 * @author Administrator
 *
 */
public class TravelYearth {
  private int id;
  private String year;
  private float employeeOff;
  private float familyOff;
  
  private String remarks;
  private int startIntention;
  
  public final static int INTENTION_OPEN = 1;
  public final static int INTENTION_CLOSE = 0; 
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
public String getYear() {
	return year;
}

public void setYear(String year) {
	this.year = year;
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
public float getEmployeeOff() {
	return employeeOff;
}

public void setEmployeeOff(float employeeOff) {
	this.employeeOff = employeeOff;
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
public int getStartIntention() {
	return startIntention;
}

public void setStartIntention(int startIntention) {
	this.startIntention = startIntention;
} 
  
}
