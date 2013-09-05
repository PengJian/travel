package com.fnst.travel.model;

import java.util.Date;


/**
 * @hibernate.class table="t_EmployeeRoute"
 * @author Lizong
 *
 */
public class EmployeeRoute {
private int id;
private int participants;

private Employee employee;
private TravelRoute travelRoute;
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
public int getParticipants() {
	return participants;
}
public void setParticipants(int participants) {
	this.participants = participants;
}

/**
 * @hibernate.many-to-one unique="true"
 * @return
 */
public Employee getEmployee() {
	return employee;
}
public void setEmployee(Employee employee) {
	this.employee = employee;
}
/**
 * @hibernate.many-to-one
 * @return
 */
public TravelRoute getTravelRoute() {
	return travelRoute;
}
public void setTravelRoute(TravelRoute travelRoute) {
	this.travelRoute = travelRoute;
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
