package com.sxd.service;

import com.sxd.pojo.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderService {
    // 创建订单
    int createOrder(Order order);

    // 根据用户ID查询订单列表
    List<Order> getOrdersByUserId(Integer userId);

    // 查询所有订单
    List<Order> getAllOrders();

    // 根据ID查询订单
    Order getOrderById(Integer id);
    
    // 获取订单统计数据
    List<Map<String, Object>> getOrderStatistics();
    
    // 压缩合并订单数据
    int compactOrders();
    
    // 带筛选、分页和排序的订单查询
    List<Order> getOrdersWithFilter(@Param("keyword") String keyword,
                                   @Param("pageNum") int pageNum,
                                   @Param("pageSize") int pageSize,
                                   @Param("orderBy") String orderBy,
                                   @Param("orderDir") String orderDir);
    
    // 获取带筛选条件的订单总数
    int getOrdersCountWithFilter(@Param("keyword") String keyword);
}