package com.sxd.service.impl;

import com.sxd.mapper.PermissionMapper;
import com.sxd.mapper.RoleMapper;
import com.sxd.mapper.UserMapper;
import com.sxd.pojo.Permission;
import com.sxd.pojo.Role;
import com.sxd.pojo.User;
import com.sxd.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 角色管理Service实现类
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Role> queryAllRoles() throws Exception {
        return roleMapper.queryAllRoles();
    }

    @Override
    public Role queryRoleById(Integer id) throws Exception {
        Role role = roleMapper.queryRoleById(id);
        if (role != null) {
            // 获取角色的权限列表
            List<Permission> permissions = permissionMapper.queryPermissionsByRoleId(id);
            role.setPermissions(permissions);
        }
        return role;
    }

    @Override
    @Transactional
    public void addRole(Role role, Integer[] permissionIds) throws Exception {
        // 设置默认状态为启用
        if (role.getStatus() == null) {
            role.setStatus(1);
        }

        // 设置创建和更新时间
        Date now = new Date();
        role.setCreatedAt(now);
        role.setUpdatedAt(now);

        // 插入角色
        roleMapper.insertRole(role);

        // 添加角色权限关联
        if (permissionIds != null && permissionIds.length > 0) {
            for (Integer permissionId : permissionIds) {
                roleMapper.insertRolePermission(role.getId(), permissionId);
            }
        }
    }

    @Override
    @Transactional
    public void updateRole(Role role, Integer[] permissionIds) throws Exception {
        // 设置更新时间
        role.setUpdatedAt(new Date());

        // 更新角色信息
        roleMapper.updateRole(role);

        // 删除原有权限关联
        roleMapper.deleteRolePermissions(role.getId());

        // 添加新的权限关联
        if (permissionIds != null && permissionIds.length > 0) {
            for (Integer permissionId : permissionIds) {
                roleMapper.insertRolePermission(role.getId(), permissionId);
            }
        }
    }

    @Override
    @Transactional
    public void deleteRoleById(Integer id) throws Exception {
        // 检查是否有用户使用该角色
        List<User> users = userMapper.queryUsersByRoleId(id);
        if (users != null && !users.isEmpty()) {
            throw new Exception("该角色已被用户使用，无法删除");
        }

        // 删除角色权限关联
        roleMapper.deleteRolePermissions(id);

        // 删除角色
        roleMapper.deleteRoleById(id);
    }

    @Override
    public Map<String, List<Object>> getPermissionsByCategory() throws Exception {
        List<Permission> permissions = permissionMapper.queryAllPermissions();
        Map<String, List<Object>> permissionsByCategory = new HashMap<>();

        // 按权限URL前缀分组
        for (Permission permission : permissions) {
            String url = permission.getUrl();
            String category = "其他权限";

            // 简单的分类逻辑，根据URL前缀判断
            if (url != null) {
                if (url.startsWith("item:")) {
                    category = "商品管理";
                } else if (url.startsWith("user:")) {
                    category = "用户管理";
                } else if (url.startsWith("role:")) {
                    category = "角色管理";
                } else if (url.startsWith("permission:")) {
                    category = "权限管理";
                }
            }

            permissionsByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(permission);
        }

        return permissionsByCategory;
    }

    @Override
    public List<User> queryAllUsersWithRole() throws Exception {
        List<User> users = userMapper.queryAllUsers();
        for (User user : users) {
            // 查询用户的角色信息
            Role role = roleMapper.queryRoleByUserId(user.getId());
            if (role != null) {
                user.setRoleId(role.getId());
                user.setRole(role);
            }
        }
        return users;
    }

    @Override
    @Transactional
    public void assignRoleToUsers(Integer[] userIds, Integer roleId) throws Exception {
        if (userIds != null && userIds.length > 0) {
            for (Integer userId : userIds) {
                userMapper.updateUserRole(userId, roleId);
            }
        }
    }

    @Override
    public Role queryRoleByUserId(Integer userId) throws Exception {
        return roleMapper.queryRoleByUserId(userId);
    }
}
