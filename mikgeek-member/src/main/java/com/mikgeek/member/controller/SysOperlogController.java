package com.mikgeek.member.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.mikgeek.common.core.domain.R;
import com.mikgeek.common.core.web.controller.BaseController;
import com.mikgeek.common.excel.utils.ExcelUtil;
import com.mikgeek.common.log.annotation.Log;
import com.mikgeek.common.log.enums.BusinessType;
import com.mikgeek.common.mybatis.core.page.PageQuery;
import com.mikgeek.common.mybatis.core.page.TableDataInfo;
import com.mikgeek.member.service.ISysOperLogService;
import com.mikgeek.member.api.domain.SysOperLog;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 操作日志记录
 *
 * @author Lion Li
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/operlog")
public class SysOperlogController extends BaseController {

    private final ISysOperLogService operLogService;

    /**
     * 查询操作日志记录列表
     */
    @SaCheckPermission("system:operlog:list")
    @GetMapping("/list")
    public TableDataInfo<SysOperLog> list(SysOperLog operLog, PageQuery pageQuery) {
        return operLogService.selectPageOperLogList(operLog, pageQuery);
    }

    /**
     * 导出操作日志记录列表
     */
    @Log(title = "操作日志", businessType = BusinessType.EXPORT)
    @SaCheckPermission("system:operlog:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysOperLog operLog) {
        List<SysOperLog> list = operLogService.selectOperLogList(operLog);
        ExcelUtil.exportExcel(list, "操作日志", SysOperLog.class, response);
    }

    /**
     * 删除操作日志记录
     *
     * @param operIds 操作日志ID串
     */
    @Log(title = "操作日志", businessType = BusinessType.DELETE)
    @SaCheckPermission("system:operlog:remove")
    @DeleteMapping("/{operIds}")
    public R<Void> remove(@PathVariable Long[] operIds) {
        return toAjax(operLogService.deleteOperLogByIds(operIds));
    }

    /**
     * 清空操作日志记录
     */
    @SaCheckPermission("system:operlog:remove")
    @Log(title = "操作日志", businessType = BusinessType.CLEAN)
    @DeleteMapping("/clean")
    public R<Void> clean() {
        operLogService.cleanOperLog();
        return R.ok();
    }

}
