package com.sxd.test;


import com.sxd.pojo.Item;
import com.sxd.service.ItemService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext-dao.xml", "classpath:applicationContext-service.xml"})
public class MyTest {

    @Autowired
    private ItemService itemService;
    @Test
    public void test() throws Exception {
        List<Item> items = itemService.queryAllItems();
        for (Item item : items) {
            System.out.println(item);
        }
    }
}
