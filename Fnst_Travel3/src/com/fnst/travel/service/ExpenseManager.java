package com.fnst.travel.service;

import java.util.List;

import com.fnst.travel.model.BatchExpenses;

public interface ExpenseManager {
public BatchExpenses find(int id);
public void load();
public void del(int id);
public void update(BatchExpenses batchExpenses);
public List<BatchExpenses> select(int isBoard,int routeId,String username,String name);
public List<BatchExpenses> searchAll();
}
