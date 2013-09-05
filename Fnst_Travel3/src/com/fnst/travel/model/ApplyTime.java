package com.fnst.travel.model;

import java.util.Date;
/**
 * @hibernate.class table="t_ApplyTime"
 * @author Lizong
 *
 */
public class ApplyTime {
private int id;
private Date startTime;
private Date endTime;

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
public Date getStartTime() {
	return startTime;
}
public void setStartTime(Date startTime) {
	this.startTime = startTime;
}

/**
 * @hibernate.property
 * @return
 */
public Date getEndTime() {
	return endTime;
}
public void setEndTime(Date endTime) {
	this.endTime = endTime;
}


}
