package com.fnst.travel.service;

import com.fnst.travel.model.ACL;

public interface ACLManager {
	public  ACL findACL(int moduleId);
	/**
	 * 添加或更新授权
	 * @param moduleId  模块标志
	 * @param permission 操作标志 （C/R/U/D ...）
	 * @param yes 是否允许
	 */
   public void addOrUpdatePermission(
		                        int moduleId,
		                        int permission,
		                        boolean yes);
   /**
    * 删除授权
    * @param moduleId
    */
   public void delPermission(int moduleId);
   
   /**
    * 即时认证，判断某个用户是否拥有对某个模块的某个操作的权限
    * @param userId 用户标志
    * @param moduleId 模块标志
    * @param permission 操作标志（C/R/U/D...）
    * @return
    */
   public boolean hasPermission(int moduleId,int permission);
}
