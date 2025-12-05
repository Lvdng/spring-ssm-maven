package com.sxd.mapper;

import com.sxd.pojo.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderMapper {
    // 创建订单
    int insertOrder(Order order);

    // 根据用户ID查询订单列表
    List<Order> selectOrdersByUserId(@Param("userId") Integer userId);

    // 查询所有订单（管理员用）
    List<Order> selectAllOrders();

    // 根据ID查询订单
    Order selectOrderById(@Param("id") Integer id);

    // 获取用户购买商品的统计数据
    List<Map<String, Object>> selectOrderStatistics();

    // 查找重复的订单组（相同用户相同商品）
    List<Map<String, Object>> findDuplicateOrders();

    // 根据用户ID和商品ID查询订单列表
    List<Order> selectOrdersByUserIdAndItemId(@Param("userId") Integer userId, @Param("itemId") Integer itemId);

    // 更新订单信息
    int updateOrder(Order order);

    // 批量删除订单
    int deleteOrdersByIds(@Param("ids") List<Integer> ids);

    // 带筛选、分页和排序的订单查询
    List<Order> selectOrdersWithFilter(@Param("keyword") String keyword,
            @Param("start") int start,
            @Param("size") int size,
            @Param("orderBy") String orderBy,
            @Param("orderDir") String orderDir);

    // 获取带筛选条件的订单总数
    int selectOrdersCountWithFilter(@Param("keyword") String keyword);
}