package com.fnst.travel.service.impl;

import java.text.DecimalFormat;
import java.util.List;

import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.model.TravelYearth;
import com.fnst.travel.service.TravelBathManager;
import com.fnst.travel.util.PageModel;

public class TravelBatchManagerImpl extends AbstractManager implements
		TravelBathManager {

	public void add(TravelBatch travelBatch, int travelYearId) {
		travelBatch.setTravelYearth(getHibernateTemplate().load(
				TravelYearth.class, travelYearId));
		getHibernateTemplate().save(travelBatch);
	}

	@SuppressWarnings("unchecked")
	public void del(int id) {
		List<Object> list = getHibernateTemplate().find(
				"from TravelRoute tb where tb.travelBatch.id = ?", id);
		if (null != list) {
			getHibernateTemplate().deleteAll(list);
		}
		getHibernateTemplate().delete(
				getHibernateTemplate().load(TravelBatch.class, id));

	}

	public void update(TravelBatch travelBatch, int travelYearId) {
		travelBatch.setTravelYearth(getHibernateTemplate().load(
				TravelYearth.class, travelYearId));
		getHibernateTemplate().update(travelBatch);

	}

	public TravelBatch find(int id) {
		return getHibernateTemplate().load(TravelBatch.class, id);
	}

	public PageModel searchAll() {
		return searchPaginated("from TravelBatch tb");
	}

	@SuppressWarnings("unchecked")
	public List<TravelBatch> searchByYearId(int yearId) {
		return getSession()
				.createQuery("from TravelBatch tb where tb.travelYearth.id = ?")
				.setParameter(0, yearId).list();
	}

	public void delByYearId(int yearId) {
		List<TravelBatch> list = searchByYearId(yearId);
		for (TravelBatch tb : list) {
			del(tb.getId());
		}
	}

	public void setSaved(int bathId) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, bathId);
		tb.setStatus(TravelBatch.STATUS_SAVED);
		tb.setAbroadStatus(TravelBatch.ABROAD_OFF);
		tb.setInternalStatus(TravelBatch.INTERNAL_OFF);
		getHibernateTemplate().update(tb);

	}

	public void setAbroadOpen(int bathId) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, bathId);
		tb.setAbroadStatus(TravelBatch.ABROAD_ON);
		getHibernateTemplate().update(tb);
	}

	public boolean ifCanAdd() {
		TravelBatch tb = (TravelBatch) getSession()
				.createQuery("from TravelBatch tb where tb.status = ?")
				.setParameter(0, TravelBatch.STATUS_ACTIVE).uniqueResult();
		if (null != tb) {
			return false;
		}
		return true;
	}

	public boolean ifCanEdit(int id) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, id);
		if (tb.getStatus() == TravelBatch.STATUS_ACTIVE
				&& tb.getAbroadStatus() == TravelBatch.ABROAD_OFF
				&& tb.getInternalStatus() == TravelBatch.INTERNAL_OFF) {
			return true;
		}
		// TravelBatch tb1 = (TravelBatch) getSession()
		// .createQuery("from TravelBatch tb where tb.status = ? " +
		// "and tb.internalStatus = ? " +
		// "and abroadStatus = ?")
		// .setParameter(0, TravelBatch.STATUS_ACTIVE).uniqueResult();
		return false;
	}

	public boolean ifCanOpen(int id) {
		TravelBatch travelBatch = find(id);
		if(TravelBatch.STATUS_SAVED == travelBatch.getStatus()){
			return false;
		}
		
		TravelBatch tBatch = (TravelBatch) getSession()
				.createQuery(
						"from TravelBatch tb where tb.internalStatus = ? or tb.abroadStatus = ?")
				.setParameter(0, TravelBatch.INTERNAL_ON)
				.setParameter(1, TravelBatch.ABROAD_ON).uniqueResult();
		if (null != tBatch) {
			return false;
		}
		return true;
	}

	public boolean ifCanDel(int id) {
		return ifCanEdit(id);
	}

	@SuppressWarnings("unchecked")
	public List<String> searchRalationBatch(int id) {
		TravelBatch tb = find(id);
		return getSession()
				.createQuery(
						"select tb.batchNo from TravelBatch tb where tb.travelYearth.id = ? and tb.id != ?")
				.setParameter(0, tb.getTravelYearth().getId())
				.setParameter(1, id).list();
	}

	// 流水号加1后返回，流水号长度为4
	private static final String STR_FORMAT = "00";

	public static String haoAddOne(String liuShuiHao) {
		Integer intHao = Integer.parseInt(liuShuiHao);
		intHao++;
		DecimalFormat df = new DecimalFormat(STR_FORMAT);
		return df.format(intHao);
	}

	public String generateNo(int yearId) {

		String hql = "select max(tb.batchNo) from TravelBatch tb where tb.travelYearth.id = ?";
		String maxNum = (String) getSession().createQuery(hql)
				.setParameter(0, yearId).uniqueResult();
		if (null != maxNum) {
			int index = maxNum.length() - 2;
			String str1 = maxNum.substring(index);
			String str2 = maxNum.substring(0, index);
			return str2 + haoAddOne(str1);
		}
		TravelYearth travelYearth = getHibernateTemplate().load(
				TravelYearth.class, yearId);
		return travelYearth.getYear() + "01";
	}

	public void setInternalOpen(int bathId) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, bathId);
		tb.setInternalStatus(TravelBatch.INTERNAL_ON);
		getHibernateTemplate().update(tb);

	}

	public void setAbroadOff(int bathId) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, bathId);
		tb.setAbroadStatus(TravelBatch.ABROAD_OFF);
		getHibernateTemplate().update(tb);

	}

	public void setInternalOff(int bathId) {
		TravelBatch tb = getHibernateTemplate().load(TravelBatch.class, bathId);
		tb.setInternalStatus(TravelBatch.INTERNAL_OFF);
		getHibernateTemplate().update(tb);

	}

	public PageModel select(String str1, String str2, String str3) {

		return searchPaginated(
				"from TravelBatch tb where tb.travelYearth.year like ? and tb.batchNo like ? and tb.name like ?",
				new Object[] {"%"+str1+"%","%"+str2+"%","%"+str3+"%"});
	}

	public void update(TravelBatch travelBatch) {
		getHibernateTemplate().update(travelBatch);
		
	}

}
