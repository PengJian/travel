package com.fnst.travel.web.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.Family;
import com.fnst.travel.service.FamilyManager;

@SuppressWarnings("serial")
public class FamilyAction extends BaseAction {

    private FamilyManager familyManager;
    private int id;
    private String name;
    private String identityNo;
    private String sex;
    private String relation;
    private String remarks;
    private int isTravel;
    


	public String add() {
		if (0!=getApplyStatus()) {
			throw new SystemException("已报名不能修改家属信息");
		}
		if (null==name || "".equals(name)){
			throw new SystemException("姓名不能为空");
		}
		if (0!=isTravel && 1!=isTravel){
			throw new SystemException("非法的操作");
		}
        Family family = new Family();
        family.setName(name);
        family.setIdentityNo(identityNo);
        family.setSex(sex);
        family.setRelation(relation);
        family.setIsTravel(isTravel);
        family.setRemarks(remarks);
        familyManager.add(family,getCurrentUser().getId());
        if(1==isTravel){
        	setTravelNum(getTravelNum() + 1);
        }
        return "pub_add";
    }

    public String update() {
    	if (0 != getApplyStatus()) {
			throw new SystemException("已报名不能修改家属信息");
		}
    	if (null==name || "".equals(name)){
			throw new SystemException("姓名不能为空");
		}
		if (0!=isTravel && 1!=isTravel){
			throw new SystemException("非法的操作");
		}
        Family family = familyManager.find(id);
        int temp = family.getIsTravel();
        family.setName(name);
        family.setSex(sex);
        family.setIdentityNo(identityNo);       
        family.setIsTravel(isTravel);
        family.setRelation(relation);
        family.setRemarks(remarks);
        familyManager.update(family);
        if(temp!=isTravel){
        	setTravelNum(getTravelNum() + (isTravel - temp));
        }
        return "pub_update";
    }

    /**
     * 根据id删除用户信息
     * 
     * @return
     */
    public String del() {
    	if (0!=getApplyStatus()) {
			throw new SystemException("已报名不能删除家属信息");
		}
        
    	if (isTravel != 1 && isTravel !=0 ){
    		throw new SystemException("非法的操作！！！！！！！");
    	}
        familyManager.del(id);
        if(1==isTravel){
        	setTravelNum(getTravelNum()-1);
        }
        return "pub_del";
    }

    public String list() {
        ServletActionContext.getRequest().setAttribute("familys", familyManager.findByEmployeeId(getCurrentUser().getId()));
        return "to_list";
    }

    public String addInput() {
    	if (0!=getApplyStatus()) {
			throw new SystemException("已报名不能添加家属信息");
		}
        return "to_input";
    }

    public String updateInput() {
    	if (0!=getApplyStatus()) {
			throw new SystemException("已报名不能修改家属信息");
		}
        ServletActionContext.getRequest().setAttribute("family", familyManager.find(id));
        return "to_update";
    }

    public String seeStatus() throws IOException{
    	HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("CacheControl", "no-cache");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("1");
		out.flush();
		out.close();
		return null;
    }
    public FamilyManager getFamilyManager() {
        return familyManager;
    }

    public void setFamilyManager(FamilyManager familyManager) {
        this.familyManager = familyManager;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdentityNo() {
        return identityNo;
    }

    public void setIdentityNo(String identityNo) {
        this.identityNo = identityNo;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public int getIsTravel() {
        return isTravel;
    }

    public void setIsTravel(int isTravel) {
        this.isTravel = isTravel;
    }

}
