package com.fnst.travel.model;

/**
 * @hibernate.class table="t_ACL"
 * @author Lizong
 *
 */
public class ACL
{	
	// 有权限
	public static final int ACL_YES=1;
	// 无权限
	public static final int ACL_NO=0;
	
	//模块
	public static  final int EMPLOYEE_MODULE = 1;
	public static  final int TRAVEL_MODULE = 2;
	
	public static  final int EMPLOYEE_ROUTE_MODULE = 3;
	
	public static  final int TRAVEL_EXPENSE_MODULE = 4;
	
	private int id;
    private int moduleId;
   
   /**
    * 授权状态 从后往前增加、查询/可读、修改、删除、导入、导出、开启/关闭
    */
   private int aclState;
   
   
   
   /**
    * @hibernate.id generator-class="native"
    * @return
    */
public int getId()
{
	return id;
}

public void setId(int id)
{
	this.id = id;
}

/**
 * @hibernate.property not-null="true"
 * @return
 */

/**
 * @hibernate.property not-null="true"
 * @return
 */
public int getModuleId()
{
	return moduleId;
}

public void setModuleId(int moduleId)
{
	this.moduleId = moduleId;
}

/**
 * @hibernate.property not-null="true"
 * @return
 */
public int getAclState()
{
	return aclState;
}

public void setAclState(int aclState)
{
	this.aclState = aclState;
}


/**
 * ACL实例资源和权限有关
 * @param permission
 * @param yes
 */
public void setPermission(int permission,boolean yes)
{
	int temp=1;
	temp = temp << permission;
	if(yes)
	{
		aclState |= temp;
	}
	else {
		aclState &= ~temp;
	}
}

/**
 * 获取ACL授权
 * @param permission
 * @return 允许/不允许
 */
public int getPermission(int permission)
{
	int temp=1;
	temp = temp << permission;
	temp &= aclState;
	if(temp != 0)
		return ACL_YES;
	return ACL_NO;
		
 }


}
