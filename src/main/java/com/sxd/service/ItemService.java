package com.sxd.service;

import com.sxd.pojo.Item;

import java.util.List;

public interface ItemService {
    // 查找所有商品信息
    public List<Item> queryAllItems() throws Exception;
    
    // 模糊查询商品
    public List<Item> queryItemsByKeyword(String keyword) throws Exception;
    
    // 模糊查询商品并分页
    public List<Item> queryItemsByKeywordWithPagination(String keyword, int pageNum, int pageSize) throws Exception;
    
    // 获取符合条件的商品总数
    public int queryItemsCountByKeyword(String keyword) throws Exception;

    // 根据id查询
    public Item queryItemById(int id) throws Exception;

    // 保存商品
    public void insertItem(Item item) throws Exception;

    // 更新商品信息
    public void updateItem(Item item) throws Exception;

    // 删除
    public void deleteItemById(int id) throws Exception;
}
