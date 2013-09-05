package com.fnst.travel.model;

import java.util.Date;

/**
 * @hibernate.class table="t_UserLog"
 * @author Lizong
 *
 */
public class UserLog {
private int id;
private String userInfo;
private String action;
private Date date;
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
public String getUserInfo() {
	return userInfo;
}
public void setUserInfo(String userInfo) {
	this.userInfo = userInfo;
}

/**
 * @hibernate.property
 * @return
 */
public String getAction() {
	return action;
}
public void setAction(String action) {
	this.action = action;
}

/**
 * @hibernate.property
 * @return
 */
public Date getDate() {
	return date;
}
public void setDate(Date date) {
	this.date = date;
}


}
