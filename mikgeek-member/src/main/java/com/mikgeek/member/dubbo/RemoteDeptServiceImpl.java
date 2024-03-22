package com.mikgeek.member.dubbo;

import com.mikgeek.member.api.RemoteDeptService;
import com.mikgeek.member.service.ISysDeptService;
import lombok.RequiredArgsConstructor;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.stereotype.Service;

/**
 * 部门服务
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Service
@DubboService
public class RemoteDeptServiceImpl implements RemoteDeptService {

    private final ISysDeptService sysDeptService;

    @Override
    public String selectDeptNameByIds(String deptIds) {
        return sysDeptService.selectDeptNameByIds(deptIds);
    }
}
