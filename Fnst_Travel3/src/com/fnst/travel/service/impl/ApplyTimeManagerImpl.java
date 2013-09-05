package com.fnst.travel.service.impl;

import java.util.Date;

import org.hibernate.Query;

import com.fnst.travel.model.ApplyTime;
import com.fnst.travel.service.ApplyTimeManager;

public class ApplyTimeManagerImpl extends AbstractManager implements ApplyTimeManager {

	public void addOrUpdateApplyTime(ApplyTime applyTime) {
		getHibernateTemplate().saveOrUpdate(applyTime);

	}

	public ApplyTime getTime() {
		Query query = getSession().createQuery("from ApplyTime at");
		
		return (ApplyTime) query.uniqueResult();
	}

	public boolean isDuringApplyTime() {
		ApplyTime applyTime = getTime();
		if(null == applyTime){
			return false;
		}
		Date currentTime = new Date();
		if(currentTime.after(applyTime.getStartTime()) && currentTime.before(applyTime.getEndTime())){
			return true;
		}
		return false;
	}

}
