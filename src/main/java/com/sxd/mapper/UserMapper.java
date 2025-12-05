package com.sxd.mapper;

import com.sxd.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    // 根据用户名查询用户
    public User queryUserByUsername(String username) throws Exception;

    // 查询用户通过邮箱
    public User queryUserByEmail(String email) throws Exception;

    // 查询所有用户
    public List<User> queryAllUsers() throws Exception;

    // 根据手机号查询用户
    public User queryUserByPhone(String phone) throws Exception;

    // 根据id查询用户
    public User queryUserById(Integer id) throws Exception;

    // 更新用户角色
    public void updateUserRole(@Param("userId") Integer userId, @Param("roleId") Integer roleId) throws Exception;

    // 插入用户
    public void insertUser(User user) throws Exception;

    // 更新用户信息
    public void updateUser(User user) throws Exception;

    // 更新用户状态
    public void updateUserStatus(int id, int status) throws Exception;

    // 根据角色ID查询用户列表
    public List<User> queryUsersByRoleId(Integer roleId) throws Exception;

    // 更新用户余额
    public void updateUserBalance(@Param("userId") Integer userId, @Param("balance") java.math.BigDecimal balance)
            throws Exception;
}