package com.fnst.travel.service.impl;

import java.text.DecimalFormat;
import java.util.List;

import com.fnst.travel.model.TravelBatch;
import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.TravelRouteManager;
import com.fnst.travel.util.PageModel;

public class TravelRouteManagerImpl extends AbstractManager implements
		TravelRouteManager {

	public void add(TravelRoute travelRoute, int travelBatchId) {
		travelRoute.setTravelBatch(getHibernateTemplate().load(
				TravelBatch.class, travelBatchId));
		getHibernateTemplate().save(travelRoute);
	}

	public void del(int id) {
		getHibernateTemplate().delete(
				getHibernateTemplate().load(TravelRoute.class, id));

	}

	public void update(TravelRoute travelRoute, int travelBatchId) {
		travelRoute.setTravelBatch(getHibernateTemplate().load(
				TravelBatch.class, travelBatchId));
		getHibernateTemplate().update(travelRoute);

	}

	public TravelRoute find(int id) {
		return getHibernateTemplate().load(TravelRoute.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchOneBatchRoute(int yearId, int bacthId) {
		return getSession()
				.createQuery(
						"from TravelRoute tr where tr.travelBatch.id =? and tr.travelBatch.travelYearth.id = ?")
				.setParameter(0, bacthId).setParameter(1, yearId).list();
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchCurrentOpenRoute() {
		return getSession()
				.createQuery(
						"from TravelRoute tr where " +
						"(tr.travelBatch.status = ? and tr.travelBatch.internalStatus = ? and tr.isBoard = ?) " +
					 "or (tr.travelBatch.status = ? and tr.travelBatch.abroadStatus = ? and tr.isBoard = ?)")
				         .setParameter(0, TravelBatch.STATUS_ACTIVE)
				         .setParameter(1, TravelBatch.INTERNAL_ON)
				         .setParameter(2, TravelRoute.NOT_BOARD)
				         .setParameter(3, TravelBatch.STATUS_ACTIVE)
				         .setParameter(4, TravelBatch.ABROAD_ON)
				         .setParameter(5, TravelRoute.IS_BOARD).list();

	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchOneRouteAbroad(int batchId) {
		return getSession()
				.createQuery(
						"from TravelRoute tr where tr.travelBatch.id = ?"
								+ " and tr.isBoard = ?")
				.setParameter(0, batchId).setParameter(1, TravelRoute.IS_BOARD)
				.list();
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchOneRouteInternal(int batchId) {
		return getSession()
				.createQuery(
						"from TravelRoute tr where tr.travelBatch.id = ?"
								+ " and tr.isBoard = ?")
				.setParameter(0, batchId)
				.setParameter(1, TravelRoute.NOT_BOARD).list();
	}

	private static final String STR_FORMAT = "00";

	public static String haoAddOne(String liuShuiHao) {
		Integer intHao = Integer.parseInt(liuShuiHao);
		intHao++;
		DecimalFormat df = new DecimalFormat(STR_FORMAT);
		return df.format(intHao);
	}

	public String generateNo(int batchId, int isBroad) {

		String hql = "select max(tr.routeNo) from TravelRoute tr where tr.travelBatch.id = ? and tr.isBoard = ?";
		String maxNum = (String) getSession().createQuery(hql)
				.setParameter(0, batchId).setParameter(1, isBroad)
				.uniqueResult();
		if (null != maxNum) {
			int index = maxNum.length() - 2;
			String str1 = maxNum.substring(index);
			String str2 = maxNum.substring(0, index);
			return str2 + haoAddOne(str1);
		}
		TravelBatch travelBatch = getHibernateTemplate().load(
				TravelBatch.class, batchId);
		return isBroad == 1 ? travelBatch.getBatchNo() + "001" : travelBatch
				.getBatchNo() + "101";
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> select(String str1, String str2, int batchId,
			int flag) {
		return getSession()
				.createQuery(
						"from TravelRoute tr where tr.travelBatch.id = ?"
								+ " and tr.isBoard = ? and tr.routeNo like ? and tr.name like ?")
				.setParameter(0, batchId).setParameter(1, flag)
				.setParameter(2, "%" + str1 + "%")
				.setParameter(3, "%" + str2 + "%").list();

	}

	public PageModel select(String str1, String str2, String str3) {
		return searchPaginated(
				"from TravelRoute tr where tr.travelBatch.name like ? and tr.name like ? and tr.routeNo like ?",
				new Object[] { "%" + str1 + "%", "%" + str2 + "%",
						"%" + str3 + "%" });
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchCurrentActvieBatchOffRoute() {
		return getSession()
		.createQuery(
				"from TravelRoute tr where " +
				"(tr.travelBatch.status = ? and tr.travelBatch.internalStatus = ? and tr.isBoard = ?) " +
			 "or (tr.travelBatch.status = ? and tr.travelBatch.abroadStatus = ? and tr.isBoard = ?)")
		         .setParameter(0, TravelBatch.STATUS_ACTIVE)
		         .setParameter(1, TravelBatch.INTERNAL_OFF)
		         .setParameter(2, TravelRoute.NOT_BOARD)
		         .setParameter(3, TravelBatch.STATUS_ACTIVE)
		         .setParameter(4, TravelBatch.ABROAD_OFF)
		         .setParameter(5, TravelRoute.IS_BOARD).list();
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchActiveBatchRoutes() {
		return getSession()
		.createQuery(
				"from TravelRoute tr where " +
				"tr.travelBatch.status = ?")
		         .setParameter(0, TravelBatch.STATUS_ACTIVE)
		         .list();
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchActiveBatchBoardRoutes() {
		return getSession()
		.createQuery(
				"from TravelRoute tr where " +
				"tr.travelBatch.status = ? and tr.isBoard = ?")
		         .setParameter(0, TravelBatch.STATUS_ACTIVE)
		         .setParameter(1, TravelRoute.IS_BOARD).list();
	}

	@SuppressWarnings("unchecked")
	public List<TravelRoute> searchActiveBatchInternalRoutes() {
		return getSession()
		.createQuery(
				"from TravelRoute tr where " +
				"tr.travelBatch.status = ? and tr.isBoard = ?")
		         .setParameter(0, TravelBatch.STATUS_ACTIVE)
		         .setParameter(1, TravelRoute.NOT_BOARD).list();
	}

}
