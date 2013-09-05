package com.fnst.travel.model;

/**
 * @hibernate.class table="t_User"
 */
public class User {
private int id;
private String username;
private String password;
private String name;
private int flag;

public static final int MANAGER_FLAG = 1;
public static final int SUPER_MANAGER_FLAG =2;

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
public int getFlag() {
	return flag;
}
public void setFlag(int flag) {
	this.flag = flag;
}


}
