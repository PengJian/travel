package com.fnst.travel.service;

import com.fnst.travel.model.ApplyTime;

public interface ApplyTimeManager {
public void addOrUpdateApplyTime(ApplyTime applyTime);
public ApplyTime getTime();
public boolean isDuringApplyTime();
}
