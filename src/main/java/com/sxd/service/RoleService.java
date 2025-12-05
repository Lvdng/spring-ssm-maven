package com.sxd.service;

import com.sxd.pojo.Role;
import com.sxd.pojo.User;
import java.util.List;
import java.util.Map;

/**
 * 角色管理Service接口
 */
public interface RoleService {
    
    /**
     * 查询所有角色
     */
    List<Role> queryAllRoles() throws Exception;
    
    /**
     * 根据ID查询角色
     */
    Role queryRoleById(Integer id) throws Exception;
    
    /**
     * 添加角色
     */
    void addRole(Role role, Integer[] permissionIds) throws Exception;
    
    /**
     * 更新角色
     */
    void updateRole(Role role, Integer[] permissionIds) throws Exception;
    
    /**
     * 删除角色
     */
    void deleteRoleById(Integer id) throws Exception;
    
    /**
     * 获取权限按类别分组
     */
    Map<String, List<Object>> getPermissionsByCategory() throws Exception;
    
    /**
     * 查询所有用户及其角色信息
     */
    List<User> queryAllUsersWithRole() throws Exception;
    
    /**
     * 为多个用户分配角色
     */
    void assignRoleToUsers(Integer[] userIds, Integer roleId) throws Exception;
    
    /**
     * 根据用户ID查询角色
     */
    Role queryRoleByUserId(Integer userId) throws Exception;
}
