package com.sxd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 首页控制器，处理根路径请求
 */
@Controller
public class HomeController {

    /**
     * 处理根路径GET请求，重定向到登录页面
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "redirect:/user/toLogin";
    }
}