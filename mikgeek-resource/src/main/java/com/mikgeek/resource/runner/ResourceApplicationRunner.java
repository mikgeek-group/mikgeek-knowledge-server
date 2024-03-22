package com.mikgeek.resource.runner;

import com.mikgeek.resource.service.ISysConfigService;
import com.mikgeek.resource.service.ISysDictTypeService;
import com.mikgeek.resource.service.ISysOssConfigService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * 初始化 system 模块对应业务数据
 *
 * @author Lion Li
 */
@Slf4j
@RequiredArgsConstructor
@Component
public class ResourceApplicationRunner implements ApplicationRunner {

    private final ISysOssConfigService ossConfigService;

    private final ISysConfigService configService;
    private final ISysDictTypeService dictTypeService;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        ossConfigService.init();
        log.info("初始化OSS配置成功");

        configService.loadingConfigCache();
        log.info("加载参数缓存数据成功");
        dictTypeService.loadingDictCache();
        log.info("加载字典缓存数据成功");
    }

}
