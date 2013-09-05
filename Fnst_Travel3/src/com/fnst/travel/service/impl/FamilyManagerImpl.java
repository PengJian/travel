package com.fnst.travel.service.impl;

import java.util.List;

import com.fnst.travel.model.Employee;
import com.fnst.travel.model.Family;
import com.fnst.travel.service.FamilyManager;

public class FamilyManagerImpl extends AbstractManager implements FamilyManager {

	public void add(Family family, int employeeId) {
		family.setEmployee(getHibernateTemplate().load(Employee.class,
				employeeId));
		getHibernateTemplate().save(family);
	}

	public void del(int id) {
		getHibernateTemplate().delete(
				getHibernateTemplate().load(Family.class, id));

	}

	public void update(Family family) {
		getHibernateTemplate().update(family);

	}

	public Family find(int id) {
		return getHibernateTemplate().load(Family.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Family> findByEmployeeId(int employeeId) {
		return getHibernateTemplate().find("from Family f where f.employee.id = ?",
				employeeId);
	}

	@SuppressWarnings("unchecked")
	public List<Family> findIsTravelFamilyByEmployeeId(int employeeId) {
		return getHibernateTemplate().find("from Family f where f.employee.id = ? and f.isTravel = ?",
				new Object[]{employeeId,Family.IS_TRAVEL});
	}

	public void setIsTravelOrNot(int id, int flag) {
		Family family = find(id);
		if(0==flag){
			family.setIsTravel(Family.NOT_TRAVEL);
		}
		else {
			family.setIsTravel(Family.IS_TRAVEL);
		}
		getHibernateTemplate().update(family);
	}

}
