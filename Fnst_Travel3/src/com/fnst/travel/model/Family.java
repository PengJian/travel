package com.fnst.travel.model;

/**
 * @hibernate.class table="t_Family"
 * @author Administrator
 *
 * id: pk 自动
 * identityNo:身份证号
 */
public class Family {
  private int id;
  private String name;
  private String identityNo;
  private String sex;
  private String relation;
  private String remarks;
  private int isTravel;
  
  public static final int IS_TRAVEL = 1;
  public static final int NOT_TRAVEL = 0;
  
  /**
   * @hibernate.property 
   * @return
   */
  public int getIsTravel() {
	return isTravel;
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


public void setIsTravel(int isTravel) {
	this.isTravel = isTravel;
}

/**
 * @hibernate.many-to-one
 * @return
 */
public Employee getEmployee() {
	return employee;
}

public void setEmployee(Employee employee) {
	this.employee = employee;
}

private Employee employee;

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
public String getIdentityNo() {
	return identityNo;
}

public void setIdentityNo(String identityNo) {
	this.identityNo = identityNo;
}
/**
 * @hibernate.property 
 * @return
 */
public String getSex() {
	return sex;
}

public void setSex(String sex) {
	this.sex = sex;
}
/**
 * @hibernate.property 
 * @return
 */
public String getRelation() {
	return relation;
}

public void setRelation(String relation) {
	this.relation = relation;
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

  
  
  
}
