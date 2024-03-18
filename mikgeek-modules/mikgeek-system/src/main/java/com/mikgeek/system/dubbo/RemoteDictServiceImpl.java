package com.mikgeek.system.dubbo;

import com.mikgeek.system.api.RemoteDictService;
import com.mikgeek.system.api.domain.SysDictData;
import com.mikgeek.system.service.ISysDictTypeService;
import lombok.RequiredArgsConstructor;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 字典服务
 *
 * @author Lion Li
 */
@RequiredArgsConstructor
@Service
@DubboService
public class RemoteDictServiceImpl implements RemoteDictService {

    private final ISysDictTypeService sysDictTypeService;


    @Override
    public List<SysDictData> selectDictDataByType(String dictType) {
        return sysDictTypeService.selectDictDataByType(dictType);
    }

}
