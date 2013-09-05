package com.fnst.travel.service.impl;

import com.fnst.travel.model.ACL;
import com.fnst.travel.service.ACLManager;

public class ACLManagerImpl extends AbstractManager implements ACLManager {

	public void addOrUpdatePermission(int moduleId, int permission, boolean yes) {
		ACL acl = findACL(moduleId);
		if (acl == null) {
			acl = new ACL();
			acl.setModuleId(moduleId);
			acl.setPermission(permission, yes);
			getHibernateTemplate().save(acl);
			return;
		}
		acl.setPermission(permission, yes);
		getHibernateTemplate().update(acl);
	}

	public void delPermission(int moduleId) {
		ACL acl = findACL(moduleId);
		if (null != acl) {
			getHibernateTemplate().delete(acl);
		}

	}

	public boolean hasPermission(int moduleId, int permission) {
		ACL acl = findACL(moduleId);
		if (acl != null) {
			int yesOrNo = acl.getPermission(permission);
			if (yesOrNo == ACL.ACL_YES){
				return true;
			}	
			else{
				return false;
			}
				
		}
		return false;
	}

	public ACL findACL(int moduleId) {
		return (ACL) getSession()
				.createQuery("from ACL a where a.moduleId = ?")
				.setParameter(0, moduleId).uniqueResult();
	}
}
