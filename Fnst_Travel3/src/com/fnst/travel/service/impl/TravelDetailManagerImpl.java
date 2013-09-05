package com.fnst.travel.service.impl;

import com.fnst.travel.model.TravelDetail;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.TravelDetailManager;

public class TravelDetailManagerImpl extends AbstractManager implements
		TravelDetailManager {

	public void add(String detail,int routeId) {
		TravelDetail travelDetail = (TravelDetail)getSession().createQuery("from TravelDetail td where td.travelRoute.id = ?").setParameter(0, routeId).uniqueResult();
		if(null == travelDetail){
			travelDetail=new TravelDetail();
			travelDetail.setDetails(detail);
			travelDetail.setTravelRoute(getHibernateTemplate().load(TravelRoute.class, routeId));
			getHibernateTemplate().save(travelDetail);
			return ;
		}
		travelDetail.setDetails(detail);
		getHibernateTemplate().update(travelDetail);

	}

	public void del(int id) {
		getHibernateTemplate().delete(
				getHibernateTemplate().load(TravelDetail.class, id));

	}

	public void update(TravelDetail travelDetail, int travelRouteId) {
		travelDetail.setTravelRoute(getHibernateTemplate().load(
				TravelRoute.class, travelRouteId));
		getHibernateTemplate().update(travelDetail);

	}

	public TravelDetail find(int id) {
		return getHibernateTemplate().load(TravelDetail.class, id);
	}

    public TravelDetail findByRouteId(int routeId) {
        // TODO Auto-generated method stub
        return (TravelDetail)getSession().createQuery("from TravelDetail td where td.travelRoute.id = ?").setParameter(0, routeId).uniqueResult();
    }

}
