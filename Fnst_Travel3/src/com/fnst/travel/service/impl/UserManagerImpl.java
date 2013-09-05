package com.fnst.travel.service.impl;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.User;
import com.fnst.travel.service.UserManager;
import com.fnst.travel.util.PageModel;

public class UserManagerImpl extends AbstractManager implements UserManager {

	public void add(User user) {
		User user2 = (User) getSession()
				.createQuery("from User u where u.username = ?")
				.setParameter(0, user.getUsername()).uniqueResult();
		if (null != user2) {
			throw new SystemException("该用户已经存在");
		}
		getHibernateTemplate().save(user);

	}

	public void del(int id) {
		getHibernateTemplate().delete(
				getHibernateTemplate().load(User.class, id));
	}

	public void update(User user) {
		getHibernateTemplate().update(user);

	}

	public User find(int id) {
		return getHibernateTemplate().load(User.class, id);
	}

	public PageModel searchAll() {
		return searchPaginated("from User u");
	}

	public PageModel searchByCondition(String username, String name) {
		return searchPaginated(
				"from User u where u.username like ? and u.name like ?",
				new Object[] { "%"+username+"%", "%"+name+"%"});
	}

	public User login(String username, String password) {
		return (User)getSession()
		.createQuery("from User u where u.username = ? and u.password=?")
		.setParameter(0, username).setParameter(1, password).uniqueResult();
	}

}
