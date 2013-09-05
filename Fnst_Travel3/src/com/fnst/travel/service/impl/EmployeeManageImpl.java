package com.fnst.travel.service.impl;

import java.io.File;
import java.io.FileInputStream;

import java.io.OutputStream;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fnst.travel.exception.SystemException;
import com.fnst.travel.model.Employee;
import com.fnst.travel.model.Family;
import com.fnst.travel.service.EmployeeManager;
import com.fnst.travel.util.PageModel;

public class EmployeeManageImpl extends AbstractManager implements
		EmployeeManager {

	public Employee login(String username, String password) {
		Employee employee = (Employee) getSession()
				.createQuery("from Employee e where e.username = ? and e.password=?")
				.setParameter(0, username).setParameter(1, password).uniqueResult();
		return employee;
	}

	public void add(Employee employee) {
		Employee employee1 = (Employee) getSession()
				.createQuery("from Employee e where e.username = ?")
				.setParameter(0, employee.getUsername()).uniqueResult();
		if (null != employee1) {
			throw new SystemException("【"+employee.getName()+"】"+"该用户已经存在");
		}
		getHibernateTemplate().save(employee);

	}

	public void update(Employee employee) {
		getHibernateTemplate().update(employee);
	}

	@SuppressWarnings("unchecked")
	public void del(int id) {
		List<Object> list = getHibernateTemplate().find(
				"from Family f where f.employee.id = ?", id);
		if (null != list) {
			getHibernateTemplate().deleteAll(list);
		}
		getHibernateTemplate().delete(
				getHibernateTemplate().load(Employee.class, id));
	}

	public PageModel searchALL() {
		return searchPaginated("from Employee e");
	}

	public PageModel searchByConditon(String username, String name) {
		return searchPaginated(
				"from Employee e where e.username = ? and e.name = ?",
				new Object[] { username, name });
	}

	public void export(OutputStream os) {

		List<Employee> list = searchALlNotByPage();
		Workbook book = new HSSFWorkbook();
		Sheet sheet = book.createSheet("员工导出信息");
		Row row = sheet.createRow(0);
		row.createCell(0).setCellValue("姓名");
		row.createCell(1).setCellValue("性别");
		row.createCell(2).setCellValue("用户名");
		row.createCell(3).setCellValue("密码");
		row.createCell(4).setCellValue("身份证号");
		row.createCell(5).setCellValue("电话");

		// CellStyle sty = book.createCellStyle();

		for (int i = 0; i < list.size(); i++) {
			Employee employee = (Employee) list.get(i);
			row = sheet.createRow(i + 1);
			row.createCell(0).setCellValue(employee.getName());
			row.createCell(1).setCellValue(employee.getSex());
			row.createCell(2).setCellValue(employee.getUsername());
			row.createCell(3).setCellValue(employee.getPassword());
			row.createCell(4).setCellValue(employee.getIdentityNo());
			row.createCell(5).setCellValue(employee.getTelephone());
		}

		try {
			book.write(os);
		} catch (Exception e) {
			throw new SystemException("导出员工信息失败");
		}

	}

	public void importData(File excelFile,String fileName) {
		Workbook book = createWorkBook(excelFile,fileName);
		// book.getNumberOfSheets(); 判断Excel文件有多少个sheet
		Sheet sheet = book.getSheetAt(0);
		// sheet.getSheetName();
		// 保存工作单名称
		// Row firstRow = sheet.getRow(0);
		// Iterator<Cell> iterator = firstRow.iterator();

		// 保存列名
		/*
		 * List<String> cellNames = new ArrayList<String>(); while
		 * (iterator.hasNext()) {
		 * cellNames.add(iterator.next().getStringCellValue()); }
		 */
        try {
        	for (int i = 1; i <= sheet.getLastRowNum(); i++) {
    			Row ros = sheet.getRow(i);
    			Employee employee = new Employee();
    			employee.setName(ros.getCell(0).getStringCellValue().trim());
    			employee.setSex(ros.getCell(1).getStringCellValue().trim());
    			if(ros.getCell(2).getCellType()==0){
    			   employee.setUsername(new Double(ros.getCell(2).getNumericCellValue()).toString());
    			}else {
    				employee.setUsername(ros.getCell(2).getStringCellValue().trim());
    			}
    			employee.setPassword(ros.getCell(3).getStringCellValue().trim());
    			if(ros.getCell(4).getCellType()==0){
    				   employee.setIdentityNo(new Double(ros.getCell(4).getNumericCellValue()).toString());
    				}else {
    					employee.setIdentityNo(ros.getCell(4).getStringCellValue().trim());
    				}
    			if(ros.getCell(5).getCellType()==0){
    				   employee.setTelephone(new Double(ros.getCell(5).getNumericCellValue()).toString());
    				}else {
    					employee.setTelephone(ros.getCell(5).getStringCellValue().trim());
    				}
    			add(employee);
    		}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private Workbook createWorkBook(File excelFile,String fileName) {
		try {

			if (fileName.endsWith("xls")) {
				return new HSSFWorkbook(new FileInputStream(excelFile));
			}
			if (fileName.endsWith("xlsx")) {
				return new XSSFWorkbook(new FileInputStream(excelFile));
			}
		} catch (Exception e) {
			throw new SystemException("导入文件失败");
		}
		return null;
	}

	public Employee find(int id) {
		return getHibernateTemplate().load(Employee.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Employee> searchALlNotByPage() {
		return getHibernateTemplate().find("from Employee");
	}

	public int getTravelNum(int employeeId) {
        String hql = "select count(*) from Family f where f.employee.id = ? and f.isTravel = ?";
        Object object = getSession().createQuery(hql).setParameter(0, employeeId).setParameter(1, Family.IS_TRAVEL).uniqueResult();
        Long num = (Long)object;        
		return num.intValue() + 1;
	}

	public PageModel select(String str1, String str2) {
		return searchPaginated(
				"from Employee e where e.username like ? and e.name like ?",
				new Object[] {"%"+str1+"%","%"+str2+"%"});
	}


}
