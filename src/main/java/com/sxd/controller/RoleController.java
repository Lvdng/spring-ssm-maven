package com.sxd.controller;

import com.sxd.annotation.RequiredPermission;
import com.sxd.mapper.PermissionMapper;
import com.sxd.mapper.RoleMapper;
import com.sxd.mapper.UserMapper;
import com.sxd.pojo.Permission;
import com.sxd.pojo.Role;
import com.sxd.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;

import java.util.List;

/**
 * 角色管理控制器
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private UserMapper userMapper;

    // 角色列表页面
    @RequestMapping("/list")
    @RequiredPermission(value = "role:list", description = "角色列表权限")
    public String roleList(Model model) {
        try {
            List<Role> roles = roleMapper.queryAllRoles();
            model.addAttribute("roles", roles);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取角色列表失败");
        }
        return "role/roleList";
    }

    // 跳转到添加角色页面
    @RequestMapping("/toAdd")
    @RequiredPermission(value = "role:add", description = "添加角色权限")
    public String toAddRole(Model model) {
        try {
            // 获取所有权限列表
            List<Permission> permissions = permissionMapper.queryAllPermissions();
            model.addAttribute("permissions", permissions);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取权限列表失败");
        }
        return "role/addRole";
    }

    // 添加角色
    @RequestMapping("/add")
    @RequiredPermission(value = "role:add", description = "添加角色权限")
    public String addRole(Role role, @RequestParam(value = "permissionIds", required = false) Integer[] permissionIds,
            RedirectAttributes redirectAttributes) {
        try {
            // 添加角色
            role.setStatus(1);
            roleMapper.insertRole(role);

            // 添加角色权限关联
            if (permissionIds != null && permissionIds.length > 0) {
                for (Integer permissionId : permissionIds) {
                    roleMapper.insertRolePermission(role.getId(), permissionId);
                }
            }

            redirectAttributes.addFlashAttribute("message", "角色添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "角色添加失败：" + e.getMessage());
        }
        return "redirect:/role/list";
    }

    // 跳转到编辑角色页面
    @RequestMapping("/toEdit")
    @RequiredPermission(value = "role:edit", description = "编辑角色权限")
    public String toEditRole(Integer id, Model model) {
        try {
            // 获取角色信息
            Role role = roleMapper.queryRoleById(id);
            model.addAttribute("role", role);

            // 获取所有权限列表
            List<Permission> permissions = permissionMapper.queryAllPermissions();
            model.addAttribute("permissions", permissions);

            // 获取角色已拥有的权限
            List<Permission> rolePermissions = permissionMapper.queryPermissionsByRoleId(id);
            model.addAttribute("rolePermissions", rolePermissions);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取角色信息失败");
        }
        return "role/editRole";
    }

    // 编辑角色
    @RequestMapping("/edit")
    @RequiredPermission(value = "role:edit", description = "编辑角色权限")
    public String editRole(Role role, @RequestParam(value = "permissionIds", required = false) Integer[] permissionIds,
            RedirectAttributes redirectAttributes) {
        try {
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

            redirectAttributes.addFlashAttribute("message", "角色更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "角色更新失败：" + e.getMessage());
        }
        return "redirect:/role/list";
    }

    // 删除角色
    @RequestMapping("/delete")
    @RequiredPermission(value = "role:delete", description = "删除角色权限")
    public String deleteRole(Integer id, RedirectAttributes redirectAttributes) {
        try {
            // 删除角色权限关联
            roleMapper.deleteRolePermissions(id);

            // 删除角色
            roleMapper.deleteRoleById(id);

            redirectAttributes.addFlashAttribute("message", "角色删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "角色删除失败：" + e.getMessage());
        }
        return "redirect:/role/list";
    }

    // 用户角色分配页面
    @RequestMapping("/assignUserRole")
    @RequiredPermission(value = "role:assign", description = "分配用户角色权限")
    public String assignUserRole(Model model) {
        try {
            // 获取所有用户
            List<User> users = userMapper.queryAllUsers();
            model.addAttribute("users", users);

            // 获取所有角色
            List<Role> roles = roleMapper.queryAllRoles();
            model.addAttribute("roles", roles);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取数据失败");
        }
        return "role/assignUserRole";
    }

    // 更新用户角色
    @RequestMapping("/updateUserRole")
    @RequiredPermission(value = "role:assign", description = "分配用户角色权限")
    public String updateUserRole(@RequestParam(value = "selectedUserIds", required = false) Integer[] userIds,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        try {
            if (userIds != null && userIds.length > 0) {
                int successCount = 0;
                for (Integer userId : userIds) {
                    // 获取对应的角色ID
                    String roleIdStr = request.getParameter("roleId-" + userId);
                    if (roleIdStr != null && !roleIdStr.isEmpty()) {
                        Integer roleId = Integer.parseInt(roleIdStr);
                        // 更新用户角色
                        userMapper.updateUserRole(userId, roleId);
                        successCount++;
                    }
                }
                redirectAttributes.addFlashAttribute("message", "成功分配 " + successCount + " 个用户的角色");
            } else {
                redirectAttributes.addFlashAttribute("message", "请选择要分配角色的用户");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "角色分配失败：" + e.getMessage());
        }
        return "redirect:/role/assignUserRole";
    }
}