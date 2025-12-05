package com.sxd.service.impl;

import com.sxd.mapper.AdminIncomeMapper;
import com.sxd.pojo.AdminIncome;
import com.sxd.service.AdminIncomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class AdminIncomeServiceImpl implements AdminIncomeService {

    @Autowired
    private AdminIncomeMapper adminIncomeMapper;

    @Override
    public int addAdminIncome(AdminIncome adminIncome) {
        return adminIncomeMapper.insertAdminIncome(adminIncome);
    }

    @Override
    public List<AdminIncome> getAllAdminIncomes() {
        return adminIncomeMapper.selectAllAdminIncomes();
    }

    @Override
    public BigDecimal getTotalAdminIncome() {
        return adminIncomeMapper.selectTotalAdminIncome();
    }

    @Override
    public AdminIncome getAdminIncomeByOrderId(Integer orderId) {
        return adminIncomeMapper.selectAdminIncomeByOrderId(orderId);
    }
}