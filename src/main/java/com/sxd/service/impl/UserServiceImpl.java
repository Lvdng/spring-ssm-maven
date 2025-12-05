package com.sxd.service.impl;

import com.sxd.mapper.UserMapper;
import com.sxd.pojo.User;
import com.sxd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) throws Exception {
        // 根据用户名查询用户
        User user = userMapper.queryUserByUsername(username);
        if (user != null) {
            // 验证密码（数据库中存储的是MD5加密后的密码）
            String md5Password = getMD5(password);
            if (md5Password.equals(user.getPassword())) {
                // 检查用户状态
                if (user.getStatus() == 1) {
                    return user;
                } else {
                    throw new Exception("用户已被禁用");
                }
            } else {
                throw new Exception("密码错误");
            }
        } else {
            throw new Exception("用户名不存在");
        }
    }

    /**
     * 生成MD5加密字符串
     */
    private String getMD5(String str) throws Exception {
        java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
        byte[] array = md.digest(str.getBytes("UTF-8"));
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < array.length; ++i) {
            sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
        }
        return sb.toString();
    }

    @Override
    public boolean register(User user) throws Exception {
        // 检查用户名是否已存在
        if (checkUsernameExist(user.getUsername())) {
            throw new Exception("用户名已存在");
        }
        // 检查邮箱是否已存在
        if (user.getEmail() != null && !user.getEmail().trim().isEmpty() && checkEmailExist(user.getEmail())) {
            throw new Exception("邮箱已被注册");
        }
        // 检查手机号是否已存在
        if (user.getPhone() != null && !user.getPhone().trim().isEmpty() && checkPhoneExist(user.getPhone())) {
            throw new Exception("手机号已被注册");
        }
        // 设置默认状态为启用
        user.setStatus(1);
        // 对密码进行MD5加密
        user.setPassword(getMD5(user.getPassword()));
        // 插入用户
        userMapper.insertUser(user);
        return true;
    }

    @Override
    public User queryUserByUsername(String username) throws Exception {
        return userMapper.queryUserByUsername(username);
    }

    @Override
    public User queryUserByEmail(String email) throws Exception {
        return userMapper.queryUserByEmail(email);
    }

    @Override
    public User queryUserByPhone(String phone) throws Exception {
        return userMapper.queryUserByPhone(phone);
    }

    @Override
    public User queryUserById(int id) throws Exception {
        return userMapper.queryUserById(id);
    }

    @Override
    public boolean updateUser(User user) throws Exception {
        // 检查邮箱是否被其他用户使用
        User existingUser = userMapper.queryUserByEmail(user.getEmail());
        if (existingUser != null && existingUser.getId() != user.getId()) {
            throw new Exception("邮箱已被其他用户使用");
        }
        // 检查手机号是否被其他用户使用
        existingUser = userMapper.queryUserByPhone(user.getPhone());
        if (existingUser != null && existingUser.getId() != user.getId()) {
            throw new Exception("手机号已被其他用户使用");
        }
        // 更新用户信息
        userMapper.updateUser(user);
        return true;
    }

    @Override
    public boolean updateUserStatus(int id, int status) throws Exception {
        userMapper.updateUserStatus(id, status);
        return true;
    }

    @Override
    public boolean checkUsernameExist(String username) throws Exception {
        User user = userMapper.queryUserByUsername(username);
        return user != null;
    }

    @Override
    public boolean checkEmailExist(String email) throws Exception {
        User user = userMapper.queryUserByEmail(email);
        return user != null;
    }

    @Override
    public boolean checkPhoneExist(String phone) throws Exception {
        User user = userMapper.queryUserByPhone(phone);
        return user != null;
    }

    @Override
    public boolean verifyPassword(int userId, String password) throws Exception {
        // 根据用户ID查询用户
        User user = userMapper.queryUserById(userId);
        if (user != null) {
            // 验证密码（使用MD5加密进行比对）
            String md5Password = getMD5(password);
            return md5Password.equals(user.getPassword());
        }
        return false;
    }

    @Override
    public void updateUserBalance(Integer userId, java.math.BigDecimal balance) throws Exception {
        userMapper.updateUserBalance(userId, balance);
    }

}