package com.sxd.controller;

import com.sxd.annotation.RequiredPermission;
import com.sxd.pojo.User;
import com.sxd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 跳转到登录页面
    @RequestMapping("/toLogin")
    public String toLogin() {
        return "login";
    }

    // 跳转到注册页面
    @RequestMapping("/toRegister")
    public String toRegister() {
        return "register";
    }

    // 用户登录
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            // 调用Service层进行登录验证
            User user = userService.login(username, password);
            // 将用户信息存入session
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("userId", user.getId());
            // 登录成功，重定向到商品列表页面
            redirectAttributes.addFlashAttribute("message", "登录成功");
            return "redirect:/item/queryItemList";
        } catch (Exception e) {
            // 登录失败，返回登录页面并显示错误信息
            model.addAttribute("error", e.getMessage());
            model.addAttribute("username", username);
            return "login";
        }
    }

    // 用户注册
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
            // 调用Service层进行注册
            userService.register(user);
            // 注册成功，重定向到登录页面
            redirectAttributes.addFlashAttribute("message", "注册成功，请登录");
            return "redirect:/user/toLogin";
        } catch (Exception e) {
            // 注册失败，返回注册页面并显示错误信息
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "register";
        }
    }

    // 用户登出
    @RequestMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // 清除session中的用户信息
        session.invalidate();
        // 重定向到登录页面
        redirectAttributes.addFlashAttribute("message", "已成功登出");
        return "redirect:/user/toLogin";
    }

    // 检查用户是否已登录的拦截方法（可在其他Controller中调用）
    public static boolean checkLogin(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "请先登录");
            return false;
        }
        return true;
    }

    // 获取当前登录用户信息
    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin";
        }
        // 从数据库获取最新的用户信息
        try {
            User currentUser = userService.queryUserById(user.getId());
            model.addAttribute("user", currentUser);
            // 更新session中的用户信息
            session.setAttribute("user", currentUser);
        } catch (Exception e) {
            model.addAttribute("error", "获取用户信息失败");
        }
        return "profile";
    }

    // 更新用户信息
    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    public String updateProfile(@RequestParam("id") Integer id,
            @RequestParam("nickname") String nickname,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam(value = "oldPassword", required = false) String oldPassword,
            @RequestParam(value = "newPassword", required = false) String newPassword,
            @RequestParam(value = "confirmPassword", required = false) String confirmPassword,
            HttpSession session, Model model) {
        // 在方法顶部声明currentUser变量，确保在整个方法内都能访问
        User currentUser = (User) session.getAttribute("user");
        try {
            // 确保更新的是当前登录用户的信息
            if (currentUser == null || !id.equals(currentUser.getId())) {
                throw new Exception("无权更新其他用户信息");
            }

            // 创建User对象并设置属性
            User user = new User();
            user.setId(id);
            user.setUsername(currentUser.getUsername());
            user.setNickname(nickname);
            user.setEmail(email);
            user.setPhone(phone);
            user.setStatus(currentUser.getStatus());
            user.setRoleId(currentUser.getRoleId());
            user.setBalance(currentUser.getBalance());

            // 处理密码修改逻辑
            if ((oldPassword != null && !oldPassword.isEmpty()) ||
                    (newPassword != null && !newPassword.isEmpty()) ||
                    (confirmPassword != null && !confirmPassword.isEmpty())) {

                // 如果要修改密码，必须提供旧密码和新密码
                if (oldPassword == null || oldPassword.isEmpty()) {
                    throw new Exception("修改密码时必须输入旧密码");
                }

                if (newPassword == null || newPassword.isEmpty()) {
                    throw new Exception("必须输入新密码");
                }

                if (confirmPassword == null || !confirmPassword.equals(newPassword)) {
                    throw new Exception("两次输入的新密码不一致");
                }

                // 验证旧密码是否正确
                boolean isValid = userService.verifyPassword(currentUser.getId(), oldPassword);
                if (!isValid) {
                    throw new Exception("原密码错误");
                }

                // 密码验证通过，Service层会处理加密
            } else {
                // 不修改密码时，保持原密码不变
                user.setPassword(currentUser.getPassword());
            }

            // 调用Service层更新用户信息
            userService.updateUser(user);
            // 更新session中的用户信息
            session.setAttribute("user", user);
            model.addAttribute("successMsg", "更新成功");
            model.addAttribute("user", user);
            return "profile";
        } catch (Exception e) {
            // 重新获取用户信息，保持表单数据完整性
            User user = new User();
            user.setId(id);
            user.setUsername(currentUser != null ? currentUser.getUsername() : "");
            user.setNickname(nickname);
            user.setEmail(email);
            user.setPhone(phone);
            model.addAttribute("errorMsg", e.getMessage());
            model.addAttribute("user", user);
            return "profile";
        }
    }
}