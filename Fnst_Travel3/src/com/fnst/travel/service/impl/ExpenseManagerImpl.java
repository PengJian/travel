package com.fnst.travel.service.impl;

import java.util.List;

import com.fnst.travel.model.BatchExpenses;
import com.fnst.travel.model.Employee;
import com.fnst.travel.model.EmployeeRoute;
import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.service.ExpenseManager;

public class ExpenseManagerImpl extends AbstractManager implements ExpenseManager {

	@SuppressWarnings("unchecked")
	public void load() {
		String hql1 = "from BatchExpenses be where be.saveStatus = ?";
		List<BatchExpenses> bes = getHibernateTemplate().find(hql1,BatchExpenses.NOT_SAVE_STATUS);
		getHibernateTemplate().deleteAll(bes);
		String hql2 = "from EmployeeRoute er where er.travelRoute.travelBatch.status = ?";
        List<EmployeeRoute> ers = getHibernateTemplate().find(hql2,TravelBatch.STATUS_ACTIVE);
        for(EmployeeRoute er:ers){
        	BatchExpenses batchExpenses = new BatchExpenses();
        	TravelRoute tr = er.getTravelRoute();
        	TravelBatch tb = tr.getTravelBatch();
        	TravelYearth ty = tb.getTravelYearth();
        	Employee e = er.getEmployee();  
        	
        	batchExpenses.setBatchId(tb.getId());
        	batchExpenses.setBatchNo(tb.getBatchNo());
        	batchExpenses.setBatchName(tb.getName());
        	batchExpenses.setRouteId(tr.getId());
        	batchExpenses.setRouteName(tr.getName());
        	batchExpenses.setRouteNo(tr.getRouteNo());
        	batchExpenses.setSaveStatus(BatchExpenses.NOT_SAVE_STATUS);
        	batchExpenses.setIsBoard(tr.getIsBoard());
        	batchExpenses.setUsername(e.getUsername());
        	batchExpenses.setName(e.getName());
        	batchExpenses.setFamilyNum(er.getParticipants() - 1);
        	batchExpenses.setPersonalExpenses(tr.getPrice());
        	batchExpenses.setCompanyExpenses(ty.getEmployeeOff());     	
        	batchExpenses.setFamilyExpenses((er.getParticipants() - 1)*tr.getPrice());
        	batchExpenses.setFamilyOff((er.getParticipants() - 1)*ty.getFamilyOff());
        	batchExpenses.setTotalExpenses(er.getParticipants()*tr.getPrice());
        	batchExpenses.setNeedExpenses(er.getParticipants()*tr.getPrice() - ty.getEmployeeOff() - (er.getParticipants() - 1)*ty.getFamilyOff());
        	getHibernateTemplate().save(batchExpenses);        	
        }
	}

	public void del(int id) {
		getHibernateTemplate().delete(getHibernateTemplate().load(BatchExpenses.class, id));

	}

	public void update(BatchExpenses batchExpenses) {
		getHibernateTemplate().update(batchExpenses);

	}

	@SuppressWarnings("unchecked")
	public List<BatchExpenses> searchAll() {
		String hql1 = "from BatchExpenses be where be.saveStatus = ?";
		return getHibernateTemplate().find(hql1,BatchExpenses.NOT_SAVE_STATUS);
	}

	public BatchExpenses find(int id) {
		return getHibernateTemplate().load(BatchExpenses.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<BatchExpenses> select(int isBoard, int routeId,
			String username, String name) {
		if(routeId == 0 ){
			if(isBoard == -1){
				return getHibernateTemplate().find(
						"from BatchExpenses be where be.username like ? and be.name like ?",
						new Object[] {"%"+username+"%","%"+name+"%"});
			}else{
				return getHibernateTemplate().find(
						"from BatchExpenses be where be.isBoard = ? and be.username like ? and be.name like ?",
						new Object[] {isBoard,"%"+username+"%","%"+name+"%"});
			}
		}else {
			if(isBoard==-1){
				 return getHibernateTemplate().find(
				    		"from BatchExpenses be where be.routeId = ? and be.username like ? and be.name like ?",
							new Object[] {routeId,"%"+username+"%","%"+name+"%"});
		    }else {
		    	return getHibernateTemplate().find(
			    		"from BatchExpenses be where be.isBoard = ? and be.routeId = ? and be.username like ? and be.name like ?",
						new Object[] {isBoard,routeId,"%"+username+"%","%"+name+"%"});
			}
		}
	}
   
}
