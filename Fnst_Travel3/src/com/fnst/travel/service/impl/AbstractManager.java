package com.fnst.travel.service.impl;

import java.text.DecimalFormat;
import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fnst.travel.util.SystemContext;
import com.fnst.travel.util.PageModel;


public abstract class AbstractManager extends HibernateDaoSupport
{
	//流水号加1后返回，流水号长度为4
	private static final String STR_FORMAT = "0000";

	public static String haoAddOne(String liuShuiHao){
	    Integer intHao = Integer.parseInt(liuShuiHao);
	    intHao++;
	    DecimalFormat df = new DecimalFormat(STR_FORMAT);
	    return df.format(intHao);
	}
	public PageModel searchPaginated(String hql)
	{   
		
		int offset = SystemContext.getOffset();
		int pageSize = SystemContext.getPageSize();
		return searchPaginated(hql,null,offset,pageSize);
		
	}
	
	public PageModel searchPaginated(String hql,Object param)
	{
		int offset = SystemContext.getOffset();
		int pageSize = SystemContext.getPageSize();
		return searchPaginated(hql,param,offset,pageSize);
		
	}
	
	public PageModel searchPaginated(String hql,Object[] params)
	{
		int offset = SystemContext.getOffset();
		int pageSize = SystemContext.getPageSize();
		return searchPaginated(hql,params,offset,pageSize);
		
	}
	
	public PageModel searchPaginated(String hql,int offset,int pageSize)
	{
		return searchPaginated(hql,null,offset,pageSize);
	}
	
	public PageModel searchPaginated(String hql,Object param,int offset,int pageSize)
	{
		return searchPaginated(hql,new Object[]{param},offset,pageSize);
	}
	
   /**
    * @param hql 查询的hql语句
    * @param params hql需要输入的参数
    * @param offset 页列表的起始点
    * @param pageSize 每页的最大记录条数
    * @return
    */
   @SuppressWarnings("unchecked")
   public PageModel searchPaginated(String hql,Object[] params,int offset,int pageSize)
   {
	   int total=getTotalCount(hql,params);
	   PageModel pm = new PageModel();
	   pm.setTotal(total);
	   
	   Query query = getSession().createQuery(hql);
	   
	   if(null!=params && params.length>0)
	   {
		   for(int i=0;i<params.length;i++)
		   {
			   query.setParameter(i, params[i]);
		   }
	   
	   }
	   List<Object> datas = query.setFirstResult(offset).setMaxResults(pageSize).list();
	   pm.setDatas(datas);
	   return pm; 
   }
  
  
   /**
    * 得到总的页数
    * 如：根据
    * select .. from Organization o where o.parent.id is null;
    * 得到
    * select count(*) from Organization o where o.parent.id is null;  
    * @param hql
    * @return
    */
   private int getTotalCount(String hql,Object[] params)
   {
	   int index = hql.indexOf("from");
	   int index2 = hql.indexOf("order by");
	   String getCountStr;
	   if(index2 == -1 ){
	        getCountStr="select count(*) " + hql.substring(index);
	   }
	   else {
		   getCountStr="select count(*) " + hql.substring(index,index2-1);
	}
	   Query query=getSession().createQuery(getCountStr);
	   if(null!=params && params.length>0)
	   {
		   for(int i=0;i<params.length;i++)
		   {
			   query.setParameter(i, params[i]);
		   }
	   
	   }
	   int total=((Long)query.uniqueResult()).intValue();
	   
	   return total;
   }
   
   protected String generateNumber(String entity)
   {
	   String hql = "select max(number) from " + entity;
	   String maxNum = (String)getSession().createQuery(hql).uniqueResult();
	   if(null!=maxNum)
	   {
		   String liuShuiHao = maxNum.substring(maxNum.indexOf("编号")+2);
		   return "编号" + haoAddOne(liuShuiHao) ;
	   }    
	   return "编号0001";
   }
   
 /*  protected Member getCurrUser()
   {
		return (Member) ServletActionContext.getRequest().getSession()
		.getAttribute("currentUser");
   }*/
}
