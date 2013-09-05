package com.fnst.travel.service.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;

import com.fnst.travel.model.Employee;
import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.model.Family;
import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.EmployeeRouteManager;
import com.fnst.travel.util.PageModel;

public class EmployeeRouteManagerImpl extends AbstractManager implements
		EmployeeRouteManager {

	public void add(EmployeeRoute employeeRoute, int routeId, int employeeId) {
		Query query = getSession()
				.createQuery(
						"select count(*) from Family f where f.employee.id = ? and f.isTravel = ?")
				.setParameter(0, employeeId).setParameter(1, Family.IS_TRAVEL);
		int participants = ((Long) query.uniqueResult()).intValue() + 1;
		employeeRoute.setParticipants(participants);
		employeeRoute.setTravelRoute(getHibernateTemplate().load(
				TravelRoute.class, routeId));
		employeeRoute.setEmployee(getHibernateTemplate().load(Employee.class,
				employeeId));
		employeeRoute.setDate(new Date());
		getHibernateTemplate().save(employeeRoute);
	}

	public void del(int id) {
		getHibernateTemplate().delete(
				getHibernateTemplate().load(EmployeeRoute.class, id));

	}

	public int getEmployeeRouteStatus(int employeeId) {
		Query query = getSession().createQuery(
				"from EmployeeRoute er where er.employee.id = ?").setParameter(
				0, employeeId);
		EmployeeRoute employeeRoute = (EmployeeRoute) query.uniqueResult();
		if (null == employeeRoute) {
			return 0;
		}
		return employeeRoute.getTravelRoute().getId();
	}

	@SuppressWarnings("unchecked")
	public List<EmployeeRoute> searchbyRouteId(int routeId) {
		return getHibernateTemplate().find(
				"from EmployeeRoute er where er.travelRoute.id = ? order by er.date desc", routeId);
	}

	public void update(EmployeeRoute employeeRoute) {
		getHibernateTemplate().update(employeeRoute);

	}

	public EmployeeRoute find(int id) {
		return getHibernateTemplate().load(EmployeeRoute.class, id);
	}

	public boolean isCanAdd(int employeeId) {
		Query query = getSession().createQuery(
				"from EmployeeRoute er where er.employee.id = ?").setParameter(
				0, employeeId);
		EmployeeRoute employeeRoute = (EmployeeRoute) query.uniqueResult();
		if (null == employeeRoute) {
			return true;
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> calculateRouteParticipants() {
		String hql = "select er.travelRoute.name,sum(er.participants) from EmployeeRoute er group by er.travelRoute.name";
		return getHibernateTemplate().find(hql);
	}

	@SuppressWarnings("unchecked")
	public List<EmployeeRoute> searchAll() {
		return getHibernateTemplate().find("from EmployeeRoute er where er.travelRoute.travelBatch.status = ? order by er.date desc",TravelBatch.STATUS_ACTIVE);
	}

	public void delByUserId(int userId) {
		Query query = getSession().createQuery(
				"from EmployeeRoute er where er.employee.id = ?").setParameter(
				0, userId);
		EmployeeRoute employeeRoute = (EmployeeRoute) query.uniqueResult();
		getHibernateTemplate().delete(employeeRoute);

	}
	public int getTravelSumByRouteId(int routeID) {
		String hql = "select sum(er.participants) from EmployeeRoute er where er.travelRoute.id = ?";
	    Long num = (Long)getSession().createQuery(hql).setParameter(0, routeID).uniqueResult();
		return null== num ? 0:num.intValue();
	}

	public EmployeeRoute findByUserId(int userId) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery(
		"from EmployeeRoute er where er.employee.id = ?").setParameter(
		0, userId);
       EmployeeRoute employeeRoute = (EmployeeRoute) query.uniqueResult();   
       return employeeRoute;
	}

	public PageModel searchHistoryAll() {
		return searchPaginated("from EmployeeRoute er where er.travelRoute.travelBatch.status = ? order by er.date desc",TravelBatch.STATUS_SAVED);
	}

	@SuppressWarnings("unchecked")
	public List<EmployeeRoute> selectActive(String username,String name,int id,int flag) {
		if(id == 0 ){
			if(flag == -1){
				return getHibernateTemplate().find(
						"from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.employee.username like ? and er.employee.name like ? order by er.date desc",
						new Object[] {TravelBatch.STATUS_ACTIVE,"%"+username+"%","%"+name+"%"});
			}else{
				return getHibernateTemplate().find(
						"from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.isBoard = ? and er.employee.username like ? and er.employee.name like ? order by er.date desc",
						new Object[] {TravelBatch.STATUS_ACTIVE,flag,"%"+username+"%","%"+name+"%"});
			}
		}else {
			if(flag==-1){
				 return getHibernateTemplate().find(
				    		"from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.id = ? and er.employee.username like ? and er.employee.name like ? order by er.date desc",
							new Object[] {TravelBatch.STATUS_ACTIVE,id,"%"+username+"%","%"+name+"%"});
		    }else {
		    	return getHibernateTemplate().find(
			    		"from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.isBoard = ? and er.travelRoute.id = ? and er.employee.username like ? and er.employee.name like ? order by er.date desc",
						new Object[] {TravelBatch.STATUS_ACTIVE,flag,id,"%"+username+"%","%"+name+"%"});
			}
		}
	}

	public int getActiveTravelSum(String username, String name, int routeId,
			int isBorad) {
		String hql;
		if(routeId == 0 ){
			if(isBorad == -1){				
				 hql = "select sum(er.participants) from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.employee.username like ? and er.employee.name like ?";
				 Long num = (Long)getSession().createQuery(hql)
				            .setParameter(0, TravelBatch.STATUS_ACTIVE)
				            .setParameter(1, "%"+username+"%")
				            .setParameter(2, "%"+name+"%").uniqueResult();
				 return null== num ? 0:num.intValue();
			}else{				
				 hql ="select sum(er.participants) from  EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.isBoard = ? and er.employee.username like ? and er.employee.name like ?";
				 Long num = (Long)getSession().createQuery(hql)
		            .setParameter(0, TravelBatch.STATUS_ACTIVE)
		            .setParameter(1, isBorad)
		            .setParameter(2, "%"+username+"%")
		            .setParameter(3, "%"+name+"%").uniqueResult();
		          return null== num ? 0:num.intValue();
			
			}
		}else {
			if(isBorad == -1){				
				 hql ="select sum(er.participants)from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.id = ? and er.employee.username like ? and er.employee.name like ?";
				 Long num = (Long)getSession().createQuery(hql)
		            .setParameter(0, TravelBatch.STATUS_ACTIVE)
		            .setParameter(1, routeId)
		            .setParameter(2, "%"+username+"%")
		            .setParameter(3, "%"+name+"%").uniqueResult();
		          return null== num ? 0:num.intValue();
			
		    }else {
		    	 hql ="select sum(er.participants) from EmployeeRoute er where er.travelRoute.travelBatch.status = ? and er.travelRoute.isBoard = ? and er.travelRoute.id = ? and er.employee.username like ? and er.employee.name like ?";
				 Long num = (Long)getSession().createQuery(hql)
		            .setParameter(0, TravelBatch.STATUS_ACTIVE)
		            .setParameter(1, isBorad)
		            .setParameter(2, routeId)
		            .setParameter(3, "%"+username+"%")
		            .setParameter(4, "%"+name+"%").uniqueResult();
		          return null== num ? 0:num.intValue();
			}
		}
	}
}
