package com.sxd.mapper;

import com.sxd.pojo.Role;
import java.util.List;

/**
 * 角色Mapper接口
 */
public interface RoleMapper {
    // 根据ID查询角色
    public Role queryRoleById(Integer id) throws Exception;
    
    // 查询所有角色
    public List<Role> queryAllRoles() throws Exception;
    
    // 添加角色
    public void insertRole(Role role) throws Exception;
    
    // 更新角色
    public void updateRole(Role role) throws Exception;
    
    // 删除角色
    public void deleteRoleById(Integer id) throws Exception;
    
    // 根据用户ID查询角色
    public Role queryRoleByUserId(Integer userId) throws Exception;
    
    // 查询角色拥有的权限列表
    public List<Role> queryRolesWithPermissions() throws Exception;
    
    // 为角色添加权限
    public void insertRolePermission(Integer roleId, Integer permissionId) throws Exception;
    
    // 删除角色的所有权限
    public void deleteRolePermissions(Integer roleId) throws Exception;
}