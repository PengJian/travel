package com.fnst.travel.web.action;

import java.security.NoSuchAlgorithmException;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.model.User;
import com.fnst.travel.service.UserManager;
import com.fnst.travel.util.MD5;

@SuppressWarnings("serial")
public class UserAction extends BaseAction {

    private UserManager userManager;
    private int id;
    private String username;
    private String password;
    private String name;
    private int flag;
    

    public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String add() throws NoSuchAlgorithmException {
        User user = new User();
        user.setName(name);
        user.setUsername(username);
        user.setPassword(MD5.md5(password));
        user.setFlag(User.MANAGER_FLAG);
        userManager.add(user);
        return "pub_add";
    }

    public String update() throws NoSuchAlgorithmException {
        User user = userManager.find(id);
        user.setId(id);
        user.setName(name);
        user.setUsername(username);
        user.setFlag(flag);
        userManager.update(user);
        return "pub_update";
    }

    /**
     * 根据id删除用户信息
     * 
     * @return
     */
    public String del() {
        userManager.del(id);
        return "pub_del";
    }

    public String resetPassword() throws NoSuchAlgorithmException{
        User user = userManager.find(id);
        user.setPassword(MD5.md5("fnst1234"));
        userManager.update(user);
        return "pub_reset";
    }
    
    public String list() {
        ServletActionContext.getRequest().setAttribute("pm", userManager.searchAll());
        return "to_list";
    }

    public String addInput() {

        return "to_input";
    }

    public String updateInput() {
        ServletActionContext.getRequest().setAttribute("user", userManager.find(id));
        return "to_update";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public UserManager getUserManager() {
        return userManager;
    }

    public void setUserManager(UserManager userManager) {
        this.userManager = userManager;
    }

}
