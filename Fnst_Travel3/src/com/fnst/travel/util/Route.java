package com.fnst.travel.util;

import java.sql.SQLException;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.service.EmployeeRouteManager;


public class Route {
    private int maxPersons;
    /**
     * persons had applied
     */
    private Integer count = new Integer(0);
    private int routeID;
    private String name;
    private EmployeeRouteManager employeeRouteManager = (EmployeeRouteManager)new ClassPathXmlApplicationContext("applicationContext.xml").getBean("employeeRouteManager");
    public Route(int routeID,int maxPersons,String name) {
        this.routeID = routeID;
        this.maxPersons = maxPersons;
        this.name = name;
    }
    
    public Route(int routeID,int maxPersons,String name,Integer count) {
        this.routeID = routeID;
        this.maxPersons = maxPersons;
        this.name = name;
        this.count = count;
    }

    public boolean addPerson(int uid, int num) {
        return isOK(uid, num);
    }

    private boolean isOK(int uid, int num) {
        if (!queue(num)) {
            return false;
        }
        try {
            addToDB(uid,num);
        } catch (SQLException e) {
            synchronized (count) {
                count = Integer.valueOf(count.intValue() - num);   
            }
        }
        return true;
    }

    private boolean queue(int num) {
        synchronized (count) {
            if (num + count.intValue() > maxPersons) {
                return false;
            }
            count = Integer.valueOf(count.intValue() + num);
            return true;
        }
    }

    private void addToDB(int uid, int num) throws SQLException {
      employeeRouteManager.add(new EmployeeRoute(), routeID, uid);
    }
    
    private void deleteFromDB(int uid) throws SQLException {
        employeeRouteManager.delByUserId(uid);
      }

    public boolean deletePerson(int uid,int num) {
        if (!delete(num)) {
            return false;
        }
        try {
            deleteFromDB(uid);
        } catch (SQLException e) {
            synchronized (count) {
                count = Integer.valueOf(count.intValue() + num);   
            }
        }
        return true;
    }
    
    private boolean delete(int num) {
        synchronized (count) {
            if (count.intValue() < num) {
                return false;
            }
            count = Integer.valueOf(count.intValue() - num);
            return true;
        }
    }
    
	public int getMaxPersons() {
		return maxPersons;
	}

	public void setMaxPersons(int maxPersons) {
		this.maxPersons = maxPersons;
	}

	public int getRouteID() {
		return routeID;
	}

	public void setRouteID(int routeID) {
		this.routeID = routeID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCount() {
		synchronized (count) {
			return count;
		}		
	}

	public void setCount(Integer count) {
		this.count = count;
	}
    
    
    
}
