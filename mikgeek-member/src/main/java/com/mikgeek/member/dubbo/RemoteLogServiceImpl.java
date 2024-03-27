package com.mikgeek.member.dubbo;

import com.mikgeek.member.api.RemoteLogService;
import com.mikgeek.member.api.domain.SysLoginInfo;
import com.mikgeek.member.api.domain.SysOperLog;
import com.mikgeek.member.service.ISysLoginInfoService;
import com.mikgeek.member.service.ISysOperLogService;
import lombok.RequiredArgsConstructor;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.stereotype.Service;

/**
 * 操作日志记录
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Service
@DubboService
public class RemoteLogServiceImpl implements RemoteLogService {

    private final ISysOperLogService operLogService;
    private final ISysLoginInfoService logininforService;

    @Override
    public Boolean saveLog(SysOperLog sysOperLog) {
        return operLogService.insertOperlog(sysOperLog) > 0;
    }

    @Override
    public Boolean saveLogininfor(SysLoginInfo sysLogininfo) {
        return logininforService.insertLogininfor(sysLogininfo) > 0;
    }
}
