package com.fnst.travel.model;

/**
 * @hibernate.class table="t_employee"
 * @author Administrator
 *  id:pk 自动
 *  username:employee Id (014001)
 *  password
 *  sex
 *  identityNo:身份证号
 *  telephone:电话号码
 *   
 */

public class Employee {
private int id;
private String  username;
private String password;
private String name;
private String sex;
private String identityNo;
private String telephone;
private int loginFlag;
private String ipStr;
private int intentionFlag;

public static final int LOGIN_ON = 1;
public static final int LOGIN_OFF = 0;
public static final String IP_NULL = "00.000.000.000";
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
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
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
public String getTelephone() {
	return telephone;
}
public void setTelephone(String telephone) {
	this.telephone = telephone;
}

/**
 * @hibernate.property 
 * @return
 */
public int getLoginFlag() {
	return loginFlag;
}
public void setLoginFlag(int loginFlag) {
	this.loginFlag = loginFlag;
}

/**
 * @hibernate.property 
 * @return
 */
public String getIpStr() {
	return ipStr;
}
public void setIpStr(String ipStr) {
	this.ipStr = ipStr;
}

/**
 * @hibernate.property 
 * @return
 */
public int getIntentionFlag() {
    return intentionFlag;
}
public void setIntentionFlag(int intentionFlag) {
    this.intentionFlag = intentionFlag;
}

}
