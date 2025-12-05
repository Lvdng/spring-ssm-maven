package com.sxd.service;

import com.sxd.pojo.AdminIncome;

import java.math.BigDecimal;
import java.util.List;

public interface AdminIncomeService {
    // 添加管理员收入记录
    int addAdminIncome(AdminIncome adminIncome);

    // 查询所有管理员收入记录
    List<AdminIncome> getAllAdminIncomes();

    // 查询管理员总收入
    BigDecimal getTotalAdminIncome();

    // 根据订单ID查询收入记录
    AdminIncome getAdminIncomeByOrderId(Integer orderId);
}