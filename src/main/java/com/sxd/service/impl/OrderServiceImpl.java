package com.sxd.service.impl;

import com.sxd.mapper.OrderMapper;
import com.sxd.pojo.Order;
import com.sxd.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public int createOrder(Order order) {
        return orderMapper.insertOrder(order);
    }

    @Override
    public List<Order> getOrdersByUserId(Integer userId) {
        return orderMapper.selectOrdersByUserId(userId);
    }

    @Override
    public List<Order> getAllOrders() {
        return orderMapper.selectAllOrders();
    }

    @Override
    public Order getOrderById(Integer id) {
        return orderMapper.selectOrderById(id);
    }

    @Override
    public List<Map<String, Object>> getOrderStatistics() {
        return orderMapper.selectOrderStatistics();
    }

    @Override
    public int compactOrders() {
        // 获取需要压缩的订单组（相同用户相同商品的订单）
        List<Map<String, Object>> duplicateOrders = orderMapper.findDuplicateOrders();
        int compactedCount = 0;

        for (Map<String, Object> orderGroup : duplicateOrders) {
            Integer userId = (Integer) orderGroup.get("userId");
            Integer itemId = (Integer) orderGroup.get("itemId");
            Integer count = (Integer) orderGroup.get("count");

            // 只处理订单数量大于1的情况
            if (count > 1) {
                // 获取该用户该商品的所有订单
                List<Order> orders = orderMapper.selectOrdersByUserIdAndItemId(userId, itemId);

                if (orders != null && orders.size() > 1) {
                    // 使用第一个订单作为基础进行合并
                    Order mainOrder = orders.get(0);
                    int totalQuantity = mainOrder.getQuantity();
                    BigDecimal totalPrice = mainOrder.getTotalPrice();

                    // 收集需要删除的订单ID
                    List<Integer> orderIdsToDelete = new ArrayList<>();

                    // 从第二个订单开始累加并收集ID
                    for (int i = 1; i < orders.size(); i++) {
                        Order order = orders.get(i);
                        totalQuantity += order.getQuantity();
                        totalPrice = totalPrice.add(order.getTotalPrice());
                        orderIdsToDelete.add(order.getId());
                    }

                    // 更新主订单的数量和总价
                    mainOrder.setQuantity(totalQuantity);
                    mainOrder.setTotalPrice(totalPrice);
                    orderMapper.updateOrder(mainOrder);

                    // 删除重复的订单
                    if (!orderIdsToDelete.isEmpty()) {
                        orderMapper.deleteOrdersByIds(orderIdsToDelete);
                        compactedCount += orderIdsToDelete.size();
                    }
                }
            }
        }

        return compactedCount;
    }

    @Override
    public List<Order> getOrdersWithFilter(String keyword, int pageNum, int pageSize, String orderBy, String orderDir) {
        // 计算起始位置
        int start = (pageNum - 1) * pageSize;
        return orderMapper.selectOrdersWithFilter(keyword, start, pageSize, orderBy, orderDir);
    }

    @Override
    public int getOrdersCountWithFilter(String keyword) {
        return orderMapper.selectOrdersCountWithFilter(keyword);
    }
}