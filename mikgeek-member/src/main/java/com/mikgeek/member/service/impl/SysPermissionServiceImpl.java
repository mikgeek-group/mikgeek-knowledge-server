package com.mikgeek.member.service.impl;

import com.mikgeek.common.satoken.utils.LoginHelper;
import com.mikgeek.member.api.domain.SysUser;
import com.mikgeek.member.service.ISysMenuService;
import com.mikgeek.member.service.ISysPermissionService;
import com.mikgeek.member.service.ISysRoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

/**
 * 用户权限处理
 *
 * @author mikgeek
 */
@RequiredArgsConstructor
@Service
public class SysPermissionServiceImpl implements ISysPermissionService {

    private final ISysRoleService roleService;
    private final ISysMenuService menuService;

    /**
     * 获取角色数据权限
     *
     * @param user 用户
     * @return 角色权限信息
     */
    @Override
    public Set<String> getRolePermission(SysUser user) {
        Set<String> roles = new HashSet<String>();
        // 管理员拥有所有权限
        if (LoginHelper.isAdmin(user.getUserId())) {
            roles.add("admin");
        } else {
            roles.addAll(roleService.selectRolePermissionByUserId(user.getUserId()));
        }
        return roles;
    }

    /**
     * 获取菜单数据权限
     *
     * @param user 用户
     * @return 菜单权限信息
     */
    @Override
    public Set<String> getMenuPermission(SysUser user) {
        Set<String> perms = new HashSet<String>();
        // 管理员拥有所有权限
        if (LoginHelper.isAdmin(user.getUserId())) {
            perms.add("*:*:*");
        } else {
            perms.addAll(menuService.selectMenuPermsByUserId(user.getUserId()));
        }
        return perms;
    }
}
