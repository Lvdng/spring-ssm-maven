package com.sxd.mapper;

import com.sxd.pojo.AdminIncome;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface AdminIncomeMapper {
    // 插入管理员收入记录
    int insertAdminIncome(AdminIncome adminIncome);

    // 查询所有管理员收入记录
    List<AdminIncome> selectAllAdminIncomes();

    // 查询管理员总收入
    BigDecimal selectTotalAdminIncome();

    // 根据订单ID查询收入记录
    AdminIncome selectAdminIncomeByOrderId(@Param("orderId") Integer orderId);
}