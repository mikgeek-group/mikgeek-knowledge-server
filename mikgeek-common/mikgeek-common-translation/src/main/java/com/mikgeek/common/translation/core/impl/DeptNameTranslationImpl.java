package com.mikgeek.common.translation.core.impl;

import com.mikgeek.common.translation.annotation.TranslationType;
import com.mikgeek.common.translation.constant.TransConstant;
import com.mikgeek.common.translation.core.TranslationInterface;
import com.mikgeek.system.api.RemoteDeptService;
import lombok.AllArgsConstructor;
import org.apache.dubbo.config.annotation.DubboReference;

/**
 * 部门翻译实现
 *
 * @author Lion Li
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.DEPT_ID_TO_NAME)
public class DeptNameTranslationImpl implements TranslationInterface<String> {

    @DubboReference
    private RemoteDeptService remoteDeptService;

    @Override
    public String translation(Object key, String other) {
        return remoteDeptService.selectDeptNameByIds(key.toString());
    }
}
