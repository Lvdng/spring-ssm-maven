package com.sxd.service.impl;

import com.sxd.mapper.ItemMapper;
import com.sxd.pojo.Item;
import com.sxd.service.ItemService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    private ItemMapper itemMapper;

    @Override
    public List<Item> queryAllItems() throws Exception {
        return itemMapper.queryAllItems();
    }
    
    @Override
    public List<Item> queryItemsByKeyword(String keyword) throws Exception {
        return itemMapper.queryItemsByKeyword(keyword);
    }
    
    @Override
    public List<Item> queryItemsByKeywordWithPagination(String keyword, int pageNum, int pageSize) throws Exception {
        // 计算偏移量，pageNum从1开始
        int offset = (pageNum - 1) * pageSize;
        RowBounds rowBounds = new RowBounds(offset, pageSize);
        return itemMapper.queryItemsByKeywordWithPagination(keyword, rowBounds);
    }
    
    @Override
    public int queryItemsCountByKeyword(String keyword) throws Exception {
        return itemMapper.queryItemsCountByKeyword(keyword);
    }

    @Override
    public Item queryItemById(int id) throws Exception {
        return itemMapper.queryItemById(id);
    }

    @Override
    public void insertItem(Item item) throws Exception {
        itemMapper.insertItem(item);
    }

    @Override
    public void updateItem(Item item) throws Exception {
        itemMapper.updateItem(item);
    }

    @Override
    public void deleteItemById(int id) throws Exception {
        itemMapper.deleteItemById(id);
    }


}
