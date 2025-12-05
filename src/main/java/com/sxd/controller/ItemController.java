package com.sxd.controller;

import com.sxd.annotation.RequiredPermission;
import com.sxd.pojo.Item;
import com.sxd.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/item")
public class ItemController {
    /*
     * 商品管理系统
     * 任务1：美化页面
     * 任务2：完善用户注册登录功能
     * 任务3：商品列表添加模糊查询
     * 任务4：商品列表实现分页功能
     * 任务5：添加角色权限或事务功能
     * 任务6：导航栏添加其他功能模块
     */
    @Autowired
    private ItemService itemService;

    // 查询所有商品信息，支持模糊查询和分页
    @RequestMapping("/queryItemList")
    public String queryItemList(@RequestParam(required = false, defaultValue = "") String keyword,
            @RequestParam(required = false, defaultValue = "1") int pageNum,
            @RequestParam(required = false, defaultValue = "10") int pageSize,
            Model model) {
        try {
            // 校验参数
            if (pageNum < 1)
                pageNum = 1;
            if (pageSize < 1 || pageSize > 100)
                pageSize = 10;

            // 获取分页数据
            List<Item> items = itemService.queryItemsByKeywordWithPagination(keyword, pageNum, pageSize);
            int totalCount = itemService.queryItemsCountByKeyword(keyword);

            // 计算总页数
            int totalPage = totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;

            // 添加到Model
            model.addAttribute("items", items);
            model.addAttribute("keyword", keyword);
            model.addAttribute("pageNum", pageNum);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("totalPage", totalPage);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "itemList";
    }

    // 跳转到添加商品界面
    @RequestMapping("/toAddItem")
    @RequiredPermission(value = "item:add", description = "添加商品权限")
    public String toAddItem() {
        return "addItem";
    }

    // 添加商品，添加成功后跳转到商品展示界面
    @RequestMapping("/addItem")
    @RequiredPermission(value = "item:add", description = "添加商品权限")
    public String addItem(Item item) {
        try {
            itemService.insertItem(item);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/item/queryItemList";
    }

    // 提交要更新的商品，并传商品 id
    @RequestMapping("/tooUpdate")
    @RequiredPermission(value = "item:update", description = "更新商品权限")
    public String tooUpdate(Integer id, Model model) {
        try {
            Item item = itemService.queryItemById(id);
            model.addAttribute("item", item);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "updateItem";
    }

    // 提交更新后的商品
    @RequestMapping("/updateItem")
    @RequiredPermission(value = "item:update", description = "更新商品权限")
    public String updateItem(Item item) {
        try {
            itemService.updateItem(item);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/item/queryItemList";
    }

    // 直接删除商品
    @RequestMapping("/deleteItem")
    @RequiredPermission(value = "item:delete", description = "删除商品权限")
    public String deleteItem(Integer id) {
        try {
            itemService.deleteItemById(id);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/item/queryItemList";
    }
}
