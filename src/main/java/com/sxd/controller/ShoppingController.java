package com.sxd.controller;

import com.sxd.annotation.RequiredPermission;
import com.sxd.pojo.AdminIncome;
import com.sxd.pojo.Item;
import com.sxd.pojo.Order;
import com.sxd.pojo.User;
import com.sxd.service.AdminIncomeService;
import com.sxd.service.ItemService;
import com.sxd.service.OrderService;
import com.sxd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/shopping")
public class ShoppingController {

    @Autowired
    private ItemService itemService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @Autowired
    private AdminIncomeService adminIncomeService;

    // 用户购买商品
    @RequestMapping("/buyItem")
    public String buyItem(@RequestParam("itemId") Integer itemId,
            @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
            HttpSession session,
            Model model) {
        try {
            // 获取当前用户
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/toLogin";
            }

            // 获取商品信息
            Item item = itemService.queryItemById(itemId);
            if (item == null) {
                model.addAttribute("error", "商品不存在");
                return "error";
            }

            // 计算总价
            BigDecimal totalPrice = new BigDecimal(item.getPrice()).multiply(new BigDecimal(quantity));

            // 检查余额是否足够
            if (user.getBalance().compareTo(totalPrice) < 0) {
                model.addAttribute("error", "余额不足");
                return "error";
            }

            // 创建订单
            Order order = new Order();
            order.setUserId(user.getId());
            order.setItemId(itemId);
            order.setQuantity(quantity);
            order.setTotalPrice(totalPrice);
            order.setStatus(1); // 已完成

            // 保存订单
            orderService.createOrder(order);

            // 更新用户余额
            BigDecimal newBalance = user.getBalance().subtract(totalPrice);
            userService.updateUserBalance(user.getId(), newBalance);

            // 更新session中的用户信息
            user.setBalance(newBalance);
            session.setAttribute("user", user);

            // 添加管理员收入记录
            AdminIncome adminIncome = new AdminIncome();
            adminIncome.setOrderId(order.getId());
            adminIncome.setAmount(totalPrice);
            adminIncomeService.addAdminIncome(adminIncome);

            // 跳转到订单列表页面
            return "redirect:/shopping/myOrders";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 用户查看自己的订单
    @RequestMapping("/myOrders")
    public String myOrders(HttpSession session, Model model) {
        try {
            // 获取当前用户
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/toLogin";
            }

            // 查询用户订单
            List<Order> orders = orderService.getOrdersByUserId(user.getId());
            model.addAttribute("orders", orders);

            return "myOrders";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 管理员充值用户余额
    @RequestMapping("/rechargeBalance")
    @RequiredPermission(value = "user:update", description = "充值用户余额权限")
    public String rechargeBalance(@RequestParam("userId") Integer userId,
            @RequestParam("amount") BigDecimal amount,
            Model model,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            // 获取用户信息
            User user = userService.queryUserById(userId);
            if (user == null) {
                model.addAttribute("error", "用户不存在");
                return "error";
            }

            // 更新用户余额
            BigDecimal newBalance = user.getBalance().add(amount);
            userService.updateUserBalance(userId, newBalance);

            // 添加成功提示信息
            redirectAttributes.addFlashAttribute("message", "充值成功，为用户" + user.getUsername() + "充值了" + amount + "元");

            // 跳转到用户列表页面
            return "redirect:/user/queryAllUsers";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 管理员查看总收入
    @RequestMapping("/viewIncome")
    @RequiredPermission(value = "user:view", description = "查看收入权限")
    public String viewIncome(Model model) {
        try {
            // 查询管理员总收入
            BigDecimal totalIncome = adminIncomeService.getTotalAdminIncome();
            model.addAttribute("totalIncome", totalIncome);

            // 查询所有收入记录
            List<AdminIncome> incomes = adminIncomeService.getAllAdminIncomes();
            model.addAttribute("incomes", incomes);

            return "adminIncome";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 跳转到充值页面
    @RequestMapping("/toRecharge")
    @RequiredPermission(value = "user:update", description = "跳转到充值页面权限")
    public String toRecharge(@RequestParam("userId") Integer userId, Model model) {
        try {
            // 获取用户信息
            User user = userService.queryUserById(userId);
            model.addAttribute("user", user);

            return "recharge";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 查看订单统计
    @RequestMapping("/orderStatistics")
    @RequiredPermission(value = "user:view", description = "查看订单统计权限")
    public String orderStatistics(Model model) {
        try {
            // 获取订单统计数据
            List<Map<String, Object>> statistics = orderService.getOrderStatistics();
            model.addAttribute("statistics", statistics);

            return "orderStatistics";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 管理员查看所有订单
    @RequestMapping("/allOrders")
    @RequiredPermission(value = "user:view", description = "查看所有订单权限")
    public String allOrders(Model model) {
        try {
            // 查询所有订单
            List<Order> orders = orderService.getAllOrders();
            model.addAttribute("orders", orders);

            return "allOrders";
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 压缩合并订单数据
    @RequestMapping("/compactOrders")
    @RequiredPermission(value = "user:update", description = "压缩订单权限")
    public String compactOrders(Model model) {
        try {
            // 调用服务层进行订单压缩
            int compactedCount = orderService.compactOrders();

            // 添加操作结果到模型
            model.addAttribute("message", "订单压缩完成，共合并了" + compactedCount + "条订单记录");

            // 压缩后重定向到所有订单页面
            return "redirect:/shopping/allOrders";
        } catch (Exception e) {
            model.addAttribute("error", "订单压缩失败：" + e.getMessage());
            return "error";
        }
    }
    
    // 管理员查看用户购买记录（带筛选、分页和排序）
    @RequestMapping("/userOrderRecords")
    @RequiredPermission(value = "user:view", description = "查看用户购买记录权限")
    public String userOrderRecords(@RequestParam(required = false, defaultValue = "") String keyword,
                                   @RequestParam(required = false, defaultValue = "1") int pageNum,
                                   @RequestParam(required = false, defaultValue = "10") int pageSize,
                                   @RequestParam(required = false, defaultValue = "created_at") String orderBy,
                                   @RequestParam(required = false, defaultValue = "desc") String orderDir,
                                   Model model) {
        try {
            // 校验参数
            if (pageNum < 1) pageNum = 1;
            if (pageSize < 1 || pageSize > 100) pageSize = 10;
            
            // 获取带筛选条件的订单列表
            List<Order> orders = orderService.getOrdersWithFilter(keyword, pageNum, pageSize, orderBy, orderDir);
            // 获取带筛选条件的订单总数
            int totalCount = orderService.getOrdersCountWithFilter(keyword);
            // 计算总页数
            int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;
            
            // 添加到Model
            model.addAttribute("orders", orders);
            model.addAttribute("keyword", keyword);
            model.addAttribute("pageNum", pageNum);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("orderBy", orderBy);
            model.addAttribute("orderDir", orderDir);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "userOrderRecords";
    }
}