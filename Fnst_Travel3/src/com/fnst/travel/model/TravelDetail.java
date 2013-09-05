package com.fnst.travel.model;

/**
 * @hibernate.class table="t_TravelDetail"
 * @author Administrator
 *
 */
public class TravelDetail {
  private int id;
  private TravelRoute travelRoute;
  private String details;
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
 * @hibernate.many-to-one  unique="true"
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
public String getDetails() {
	return details;
}
public void setDetails(String details) {
	this.details = details;
}
  
  
}
