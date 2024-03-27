package com.mikgeek.member.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.mikgeek.common.core.constant.CacheConstants;
import com.mikgeek.common.core.domain.R;
import com.mikgeek.common.core.web.controller.BaseController;
import com.mikgeek.common.excel.utils.ExcelUtil;
import com.mikgeek.common.log.annotation.Log;
import com.mikgeek.common.log.enums.BusinessType;
import com.mikgeek.common.mybatis.core.page.PageQuery;
import com.mikgeek.common.mybatis.core.page.TableDataInfo;
import com.mikgeek.common.redis.utils.RedisUtils;
import com.mikgeek.member.service.ISysLoginInfoService;
import com.mikgeek.member.api.domain.SysLoginInfo;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 系统访问记录
 *
 * @author Lion Li
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/loginInfo")
public class SysLoginInfoController extends BaseController {

    private final ISysLoginInfoService logininforService;

    /**
     * 查询系统访问记录列表
     */
    @SaCheckPermission("system:loginInfo:list")
    @GetMapping("/list")
    public TableDataInfo<SysLoginInfo> list(SysLoginInfo logininfor, PageQuery pageQuery) {
        return logininforService.selectPageLogininforList(logininfor, pageQuery);
    }

    /**
     * 导出系统访问记录列表
     */
    @Log(title = "登录日志", businessType = BusinessType.EXPORT)
    @SaCheckPermission("system:loginInfo:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysLoginInfo logininfor) {
        List<SysLoginInfo> list = logininforService.selectLogininforList(logininfor);
        ExcelUtil.exportExcel(list, "登录日志", SysLoginInfo.class, response);
    }

    /**
     * 删除系统访问记录
     *
     * @param infoIds 记录ID串
     */
    @SaCheckPermission("system:loginInfo:remove")
    @Log(title = "登录日志", businessType = BusinessType.DELETE)
    @DeleteMapping("/{infoIds}")
    public R<Void> remove(@PathVariable Long[] infoIds) {
        return toAjax(logininforService.deleteLogininforByIds(infoIds));
    }

    /**
     * 清空系统访问记录
     */
    @SaCheckPermission("system:loginInfo:remove")
    @Log(title = "登录日志", businessType = BusinessType.DELETE)
    @DeleteMapping("/clean")
    public R<Void> clean() {
        logininforService.cleanLogininfor();
        return R.ok();
    }

    @SaCheckPermission("system:loginInfo:unlock")
    @Log(title = "账户解锁", businessType = BusinessType.OTHER)
    @GetMapping("/unlock/{userName}")
    public R<Void> unlock(@PathVariable("userName") String userName) {
        String loginName = CacheConstants.PWD_ERR_CNT_KEY + userName;
        if (RedisUtils.hasKey(loginName)) {
            RedisUtils.deleteObject(loginName);
        }
        return R.ok();
    }

}
