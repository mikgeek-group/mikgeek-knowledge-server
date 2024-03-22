package com.mikgeek.member.mapper;

import com.mikgeek.common.mybatis.core.mapper.BaseMapperPlus;
import com.mikgeek.member.domain.SysUserRole;

import java.util.List;

/**
 * 用户与角色关联表 数据层
 *
 * @author Lion Li
 */
public interface SysUserRoleMapper extends BaseMapperPlus<SysUserRoleMapper, SysUserRole, SysUserRole> {

    List<Long> selectUserIdsByRoleId(Long roleId);

}
