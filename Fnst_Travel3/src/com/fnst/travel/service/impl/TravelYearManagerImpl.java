package com.fnst.travel.service.impl;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.service.TravelBathManager;
import com.fnst.travel.service.TravelYearManager;
import com.fnst.travel.util.PageModel;

public class TravelYearManagerImpl extends AbstractManager implements
		TravelYearManager {
    @SuppressWarnings("unused")
	private TravelBathManager travelBathManager;
    public void setTravelBathManager(TravelBathManager travelBathManager) {
		this.travelBathManager = travelBathManager;
	}
	public void add(TravelYearth travelYearth) {
		TravelYearth travelYearth2 = (TravelYearth) getSession()
				.createQuery("from TravelYearth ty where ty.year = ?")
				.setParameter(0, travelYearth.getYear()).uniqueResult();
		if (null != travelYearth2) {
			throw new SystemException("该年份已经存在");
		}
		getHibernateTemplate().save(travelYearth);
	}

	public void del(int id) {
		//travelBathManager.delByYearId(id);
		getHibernateTemplate().delete(
				getHibernateTemplate().load(TravelYearth.class, id));

	}

	public void update(TravelYearth travelYearth) {
		getHibernateTemplate().update(travelYearth);

	}

	public TravelYearth find(int id) {
		return getHibernateTemplate().load(TravelYearth.class, id);
	}
	
	public TravelYearth findByYearth(String year) {
	    return (TravelYearth) getSession()
                .createQuery("from TravelYearth ty where ty.year = ?")
                .setParameter(0, year).uniqueResult();
    }

	public PageModel searchAll() {
		return searchPaginated("from TravelYearth ty");
	}
	public String getCanSetIntention() {
		TravelYearth travelYearth = (TravelYearth) getSession()
		.createQuery("from TravelYearth ty where ty.startIntention = ?")
		.setParameter(0, TravelYearth.INTENTION_OPEN).uniqueResult();
		if(null==travelYearth){
			return null;
		}
		return travelYearth.getYear();
	}
}
