package com.fnst.travel.service;

import com.fnst.travel.model.User;
import com.fnst.travel.util.PageModel;

public interface UserManager {
public User login(String username,String password);
public void add(User user);
public void del(int id);
public void update(User user);
public User find(int id);
public PageModel searchAll();
public PageModel searchByCondition(String username,String name);
}
