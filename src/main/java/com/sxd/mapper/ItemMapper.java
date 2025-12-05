package com.sxd.mapper;

import com.sxd.pojo.Item;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import org.apache.ibatis.session.RowBounds;

public interface ItemMapper {
    // 查找所有商品信息
    public List<Item> queryAllItems() throws Exception;

    // 模糊查询商品
    public List<Item> queryItemsByKeyword(@Param("keyword") String keyword) throws Exception;

    // 模糊查询商品并分页
    public List<Item> queryItemsByKeywordWithPagination(@Param("keyword") String keyword, RowBounds rowBounds)
            throws Exception;

    // 获取符合条件的商品总数
    public int queryItemsCountByKeyword(@Param("keyword") String keyword) throws Exception;

    // 根据id查询
    public Item queryItemById(int id) throws Exception;

    // 保存商品
    public void insertItem(Item item) throws Exception;

    // 更新商品信息
    public void updateItem(Item item) throws Exception;

    // 删除
    public void deleteItemById(int id) throws Exception;
}
