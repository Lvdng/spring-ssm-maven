package com.sxd.interceptor;

import com.sxd.annotation.RequiredPermission;
import com.sxd.mapper.PermissionMapper;
import com.sxd.pojo.Permission;
import com.sxd.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 权限验证拦截器
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private PermissionMapper permissionMapper;

    @SuppressWarnings("null")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
            Object handler) throws Exception {
        // 获取当前用户
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 如果用户未登录，重定向到登录页面
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/toLogin");
            return false;
        }

        // 获取当前请求的URL
        String requestUri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String url = requestUri.substring(contextPath.length());

        // 如果是管理员，拥有所有权限
        if ("admin".equals(user.getUsername())) {
            return true;
        }

        // 如果不是管理员，需要验证权限
        try {
            // 检查是否有RequiredPermission注解
            if (handler instanceof HandlerMethod) {
                HandlerMethod handlerMethod = (HandlerMethod) handler;
                RequiredPermission annotation = handlerMethod.getMethodAnnotation(RequiredPermission.class);

                // 如果没有权限注解，允许访问
                if (annotation == null) {
                    return true;
                }

                // 获取权限名称
                String permissionName = annotation.value();

                // 根据用户ID查询权限列表
                List<Permission> permissions = permissionMapper.queryPermissionsByUserId(user.getId());
                Set<String> permissionNames = new HashSet<>();
                Set<String> permissionUrls = new HashSet<>();

                // 构建权限集合
                for (Permission permission : permissions) {
                    if (permission != null) {
                        permissionNames.add(permission.getName());
                        permissionUrls.add(permission.getUrl());
                    }
                }

                // 检查是否拥有该权限
                if (permissionNames.contains(permissionName) || permissionUrls.contains(url)) {
                    return true;
                } else {
                    // 没有权限，重定向到无权限页面
                    response.sendRedirect(request.getContextPath() + "/error/noPermission");
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error/500");
            return false;
        }

        // 默认允许访问
        return true;
    }
}