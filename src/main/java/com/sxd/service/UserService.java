package com.sxd.service;

import com.sxd.pojo.User;

public interface UserService {
    // 用户登录
    public User login(String username, String password) throws Exception;
    
    // 用户注册
    public boolean register(User user) throws Exception;
    
    // 根据用户名查询用户
    public User queryUserByUsername(String username) throws Exception;
    
    // 根据邮箱查询用户
    public User queryUserByEmail(String email) throws Exception;
    
    // 根据手机号查询用户
    public User queryUserByPhone(String phone) throws Exception;
    
    // 根据id查询用户
    public User queryUserById(int id) throws Exception;
    
    // 更新用户信息
    public boolean updateUser(User user) throws Exception;
    
    // 更新用户状态
    public boolean updateUserStatus(int id, int status) throws Exception;
    
    // 检查用户名是否存在
    public boolean checkUsernameExist(String username) throws Exception;
    
    // 检查邮箱是否存在
    public boolean checkEmailExist(String email) throws Exception;
    
    // 检查手机号是否存在
    public boolean checkPhoneExist(String phone) throws Exception;
    
    // 验证用户密码
    public boolean verifyPassword(int userId, String password) throws Exception;
    
    // 更新用户余额
    public void updateUserBalance(Integer userId, java.math.BigDecimal balance) throws Exception;
}