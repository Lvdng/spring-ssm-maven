package com.sxd.mapper;

import com.sxd.pojo.Permission;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * 权限Mapper接口
 */
public interface PermissionMapper {
    // 根据ID查询权限
    public Permission queryPermissionById(Integer id) throws Exception;
    
    // 查询所有权限
    public List<Permission> queryAllPermissions() throws Exception;
    
    // 添加权限
    public void insertPermission(Permission permission) throws Exception;
    
    // 更新权限
    public void updatePermission(Permission permission) throws Exception;
    
    // 删除权限
    public void deletePermissionById(Integer id) throws Exception;
    
    // 根据角色ID查询权限列表
    public List<Permission> queryPermissionsByRoleId(Integer roleId) throws Exception;
    
    // 根据用户ID查询权限列表
    public List<Permission> queryPermissionsByUserId(Integer userId) throws Exception;
    
    // 根据URL查询权限
    public Permission queryPermissionByUrl(String url) throws Exception;
    
    // 批量删除角色-权限关联
    public void deleteRolePermissionByPermissionIds(@Param("permissionIds") List<Integer> permissionIds) throws Exception;
}