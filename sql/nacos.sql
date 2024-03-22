/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : nacos

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 18/03/2024 18:15:48
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`
(
    `id`                 bigint                           NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`            varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
    `group_id`           varchar(255) COLLATE utf8mb3_bin          DEFAULT NULL,
    `content`            longtext COLLATE utf8mb3_bin     NOT NULL COMMENT 'content',
    `md5`                varchar(32) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'md5',
    `gmt_create`         datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`       datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`           text COLLATE utf8mb3_bin COMMENT 'source user',
    `src_ip`             varchar(50) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'source ip',
    `app_name`           varchar(128) COLLATE utf8mb3_bin          DEFAULT NULL,
    `tenant_id`          varchar(128) COLLATE utf8mb3_bin          DEFAULT '' COMMENT '租户字段',
    `c_desc`             varchar(256) COLLATE utf8mb3_bin          DEFAULT NULL,
    `c_use`              varchar(64) COLLATE utf8mb3_bin           DEFAULT NULL,
    `effect`             varchar(64) COLLATE utf8mb3_bin           DEFAULT NULL,
    `type`               varchar(64) COLLATE utf8mb3_bin           DEFAULT NULL,
    `c_schema`           text COLLATE utf8mb3_bin,
    `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info';

-- ----------------------------
-- Records of config_info
-- ----------------------------
BEGIN;
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (1, 'application-common.yml', 'DEFAULT_GROUP',
        'server:\n  # undertow 配置\n  undertow:\n    # HTTP post内容的最大大小。当值为-1时，默认值为大小是无限的\n    max-http-post-size: -1\n    # 以下的配置会影响buffer,这些buffer会用于服务器连接的IO操作,有点类似netty的池化内存管理\n    # 每块buffer的空间大小,越小的空间被利用越充分\n    buffer-size: 512\n    # 是否分配的直接内存\n    direct-buffers: true\n    threads:\n      # 设置IO线程数, 它主要执行非阻塞的任务,它们会负责多个连接, 默认设置每个CPU核心一个线程\n      io: 8\n      # 阻塞任务线程池, 当执行类似servlet请求阻塞操作, undertow会从这个线程池中取得线程,它的值设置取决于系统的负载\n      worker: 256\n\ndubbo:\n  application:\n    logger: slf4j\n    # 元数据中心 local 本地 remote 远程 这里使用远程便于其他服务获取\n    metadataType: remote\n    # 可选值 interface、instance、all，默认是 all，即接口级地址、应用级地址都注册\n    register-mode: instance\n    service-discovery:\n      # FORCE_INTERFACE，只消费接口级地址，如无地址则报错，单订阅 2.x 地址\n      # APPLICATION_FIRST，智能决策接口级/应用级地址，双订阅\n      # FORCE_APPLICATION，只消费应用级地址，如无地址则报错，单订阅 3.x 地址\n      migration: FORCE_APPLICATION\n    qos-enable: false\n  protocol:\n    # 设置为 tri 即可使用 Triple 3.0 新协议\n    # 性能对比 dubbo 协议并没有提升 但基于 http2 用于多语言异构等 http 交互场景\n    # 使用 dubbo 协议通信\n    name: dubbo\n    # dubbo 协议端口(-1表示自增端口,从20880开始)\n    port: -1\n    # 指定dubbo协议注册ip\n    # host: 192.168.0.100\n  # 注册中心配置\n  registry:\n    address: nacos://${spring.cloud.nacos.server-addr}\n    group: DUBBO_GROUP\n    parameters:\n      namespace: ${spring.profiles.active}\n  # 消费者相关配置\n  consumer:\n    # 结果缓存(LRU算法)\n    # 会有数据不一致问题 建议在注解局部开启\n    cache: false\n    # 支持校验注解\n    validation: true\n    # 超时时间\n    timeout: 3000\n    # 初始化检查\n    check: false\n  scan:\n    # 接口实现类扫描\n    base-packages: com.mikgeek.**.dubbo\n  # 自定义配置\n  custom:\n    # 全局请求log\n    request-log: true\n    # info 基础信息 param 参数信息 full 全部\n    log-level: info\n\nspring:\n  # 资源信息\n  messages:\n    # 国际化资源文件路径\n    basename: i18n/messages\n  servlet:\n    multipart:\n      # 整个请求大小限制\n      max-request-size: 20MB\n      # 上传单个文件大小限制\n      max-file-size: 10MB\n  mvc:\n    format:\n      date-time: yyyy-MM-dd HH:mm:ss\n  #jackson配置\n  jackson:\n    # 日期格式化\n    date-format: yyyy-MM-dd HH:mm:ss\n    serialization:\n      # 格式化输出\n      INDENT_OUTPUT: false\n      # 忽略无法转换的对象\n      fail_on_empty_beans: false\n    deserialization:\n      # 允许对象忽略json中不存在的属性\n      fail_on_unknown_properties: false\n  cloud:\n    # sentinel 配置\n    sentinel:\n      # sentinel 开关\n      enabled: true\n      # 取消控制台懒加载\n      eager: true\n      transport:\n        # dashboard控制台服务名 用于服务发现\n        # 如无此配置将默认使用下方 dashboard 配置直接注册\n        server-name: mikgeek-sentinel-dashboard\n        # 客户端指定注册的ip 用于多网卡ip不稳点使用\n        # client-ip:\n        # 控制台地址 从1.3.0开始使用 server-name 注册\n        # dashboard: localhost:8718\n\n  # redis通用配置 子服务可以自行配置进行覆盖\n  redis:\n    host: localhost\n    port: 6379\n    # 密码(如没有密码请注释掉)\n    # password:\n    database: 2\n    timeout: 10s\n    ssl: false\n\n# redisson 配置\nredisson:\n  # redis key前缀\n  keyPrefix:\n  # 线程池数量\n  threads: 4\n  # Netty线程池数量\n  nettyThreads: 8\n  # 单节点配置\n  singleServerConfig:\n    # 客户端名称\n    clientName: ${spring.application.name}\n    # 最小空闲连接数\n    connectionMinimumIdleSize: 8\n    # 连接池大小\n    connectionPoolSize: 32\n    # 连接空闲超时，单位：毫秒\n    idleConnectionTimeout: 10000\n    # 命令等待超时，单位：毫秒\n    timeout: 3000\n    # 发布和订阅连接池大小\n    subscriptionConnectionPoolSize: 50\n\n# 分布式锁 lock4j 全局配置\nlock4j:\n  # 获取分布式锁超时时间，默认为 3000 毫秒\n  acquire-timeout: 3000\n  # 分布式锁的超时时间，默认为 30 秒\n  expire: 30000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: ALWAYS\n    logfile:\n      external-file: ./logs/${spring.application.name}/console.log\n\n# 日志配置\nlogging:\n  level:\n    org.springframework: warn\n    org.apache.dubbo: warn\n    com.alibaba.nacos: warn\n  config: classpath:logback-plus.xml\n\n# Sa-Token配置\nsa-token:\n  # token名称 (同时也是cookie名称)\n  token-name: Authorization\n  # token有效期 设为一天 (必定过期) 单位: 秒\n  timeout: 86400\n  # 多端不同 token 有效期 可查看 LoginHelper.loginByDevice 方法自定义\n  # token最低活跃时间 (指定时间无操作就过期) 单位: 秒\n  active-timeout: 1800\n  # 允许动态设置 token 有效期\n  dynamic-active-timeout: true\n  # 开启内网服务调用鉴权\n  check-same-token: true\n  # Same-Token的有效期 (单位: 秒)(默认一天）\n  # same-token-timeout: 600\n  # 是否允许同一账号并发登录 (为true时允许一起登录, 为false时新登录挤掉旧登录)\n  is-concurrent: true\n  # 在多人登录同一账号时，是否共用一个token (为true时所有登录共用一个token, 为false时每次登录新建一个token)\n  is-share: false\n  # 是否尝试从header里读取token\n  is-read-header: true\n  # 是否尝试从cookie里读取token\n  is-read-cookie: false\n  # token前缀\n  token-prefix: \"Bearer\"\n  # jwt秘钥\n  jwt-secret-key: abcdefghijklmnopqrstuvwxyz\n\n# MyBatisPlus配置\n# https://baomidou.com/config/\nmybatis-plus:\n  # 不支持多包, 如有需要可在注解配置 或 提升扫包等级\n  # 例如 com.**.**.mapper\n  mapperPackage: com.mikgeek.**.mapper\n  # 对应的 XML 文件位置\n  mapperLocations: classpath*:mapper/**/*Mapper.xml\n  # 实体扫描，多个package用逗号或者分号分隔\n  typeAliasesPackage: com.mikgeek.**.domain\n  # 启动时是否检查 MyBatis XML 文件的存在，默认不检查\n  checkConfigLocation: false\n  configuration:\n    # 自动驼峰命名规则（camel case）映射\n    mapUnderscoreToCamelCase: true\n    # MyBatis 自动映射策略\n    # NONE：不启用 PARTIAL：只对非嵌套 resultMap 自动映射 FULL：对所有 resultMap 自动映射\n    autoMappingBehavior: PARTIAL\n    # MyBatis 自动映射时未知列或未知属性处理策\n    # NONE：不做处理 WARNING：打印相关警告 FAILING：抛出异常和详细信息\n    autoMappingUnknownColumnBehavior: NONE\n    # 更详细的日志输出 会有性能损耗 org.apache.ibatis.logging.stdout.StdOutImpl\n    # 关闭日志记录 (可单纯使用 p6spy 分析) org.apache.ibatis.logging.nologging.NoLoggingImpl\n    # 默认日志输出 org.apache.ibatis.logging.slf4j.Slf4jImpl\n    logImpl: org.apache.ibatis.logging.nologging.NoLoggingImpl\n  global-config:\n    # 是否打印 Logo banner\n    banner: true\n    dbConfig:\n      # 主键类型\n      # AUTO 自增 NONE 空 INPUT 用户输入 ASSIGN_ID 雪花 ASSIGN_UUID 唯一 UUID\n      idType: ASSIGN_ID\n      # 逻辑已删除值\n      logicDeleteValue: 2\n      # 逻辑未删除值\n      logicNotDeleteValue: 0\n      insertStrategy: NOT_NULL\n      updateStrategy: NOT_NULL\n      where-strategy: NOT_NULL\n\n# 数据加密\nmybatis-encryptor:\n  # 是否开启加密\n  enable: false\n  # 默认加密算法\n  algorithm: BASE64\n  # 编码方式 BASE64/HEX。默认BASE64\n  encode: BASE64\n  # 安全秘钥 对称算法的秘钥 如：AES，SM4\n  password:\n  # 公私钥 非对称算法的公私钥 如：SM2，RSA\n  publicKey:\n  privateKey:\n\nspringdoc:\n  api-docs:\n    # 是否开启接口文档\n    enabled: true\n#  swagger-ui:\n#    # 持久化认证数据\n#    persistAuthorization: true\n  info:\n    # 标题\n    title: \' 标题：mikgeek-cloud微服务权限管理系统_接口文档\'\n    # 描述\n    description: \'描述：微服务权限管理系统,
        具体包括XXX, XXX模块...\'\n    # 版本\n    version: \' 版本号：系统版本...\'\n    # 作者信息\n    contact:\n      name: Lion Li\n      email: crazylionli@163.com\n      url: https://gitee.com/dromara/mikgeek-cloud\n  components:\n    # 鉴权方式配置\n    security-schemes:\n      apiKey:\n        type: APIKEY\n        in: HEADER\n        name: ${sa-token.token-name}\n  # 服务文档路径映射 参考 gateway router 配置\n  # 默认为服务名去除前缀转换为path 此处填特殊的配置\n  service-mapping:\n    mikgeek-gen: /code\n\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: true\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  config:\n    type: nacos\n    nacos:\n      server-addr: ${spring.cloud.nacos.server-addr}\n      group: ${spring.cloud.nacos.config.group}\n      namespace: ${spring.profiles.active}\n      data-id: seata-server.properties\n  registry:\n    type: nacos\n    nacos:\n      application: mikgeek-seata-server\n      server-addr: ${spring.cloud.nacos.server-addr}\n      group: ${spring.cloud.nacos.discovery.group}\n      namespace: ${spring.profiles.active}\n',
        '85fec0c78bcf71462fdd415693edd25a', '2022-01-09 15:18:55', '2024-03-18 09:54:14', 'nacos', '127.0.0.1', '',
        'dev', '通用配置基础配置', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (2, 'datasource.yml', 'DEFAULT_GROUP',
        'datasource:\n  system-master:\n    # jdbc 所有参数配置参考 https://lionli.blog.csdn.net/article/details/122018562\n    # rewriteBatchedStatements=true 批处理优化 大幅提升批量插入更新删除性能\n    url: jdbc:mysql://localhost:3306/mikgeek_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true\n    username: root\n    password: root\n  job:\n    url: jdbc:mysql://localhost:3306/mikgeek_job?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true\n    username: root\n    password: root\n\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    # 动态数据源文档 https://www.kancloud.cn/tracy5546/dynamic-datasource/content\n    dynamic:\n      # 性能分析插件(有性能损耗 不建议生产环境使用)\n      p6spy: true\n      # 开启seata代理，开启后默认每个数据源都代理，如果某个不需要代理可单独关闭\n      seata: true\n      # 严格模式 匹配不到数据源则报错\n      strict: true\n      hikari:\n        # 最大连接池数量\n        maxPoolSize: 20\n        # 最小空闲线程数量\n        minIdle: 10\n        # 配置获取连接等待超时的时间\n        connectionTimeout: 30000\n        # 校验超时时间\n        validationTimeout: 5000\n        # 空闲连接存活最大时间，默认10分钟\n        idleTimeout: 600000\n        # 此属性控制池中连接的最长生命周期，值0表示无限生命周期，默认30分钟\n        maxLifetime: 1800000\n        # 连接测试query（配置检测连接是否有效）\n        connectionTestQuery: SELECT 1\n        # 多久检查一次连接的活性\n        keepaliveTime: 30000\n\n# seata配置\nseata:\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n',
        'c76050fbcd163145c1200fffc1efc80d', '2022-01-09 15:19:07', '2024-03-18 09:54:37', 'nacos', '127.0.0.1', '',
        'dev', '数据源配置', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (3, 'mikgeek-gateway.yml', 'DEFAULT_GROUP',
        '# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    # 是否开启验证码\n    enabled: true\n    # 验证码类型 math 数组计算 char 字符验证\n    type: MATH\n    # line 线段干扰 circle 圆圈干扰 shear 扭曲干扰\n    category: CIRCLE\n    # 数字验证码位数\n    numberLength: 1\n    # 字符验证码长度\n    charLength: 4\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /code\n      - /auth/logout\n      - /auth/login\n      - /auth/smsLogin\n      - /auth/xcxLogin\n      - /auth/register\n      - /resource/sms/code\n      - /*/v3/api-docs\n      - /csrf\n\nspring:\n  cloud:\n    # 网关配置\n    gateway:\n      # 打印请求日志(自定义)\n      requestLog: true\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: mikgeek-auth\n          uri: lb://mikgeek-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: mikgeek-gen\n          uri: lb://mikgeek-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: mikgeek-system\n          uri: lb://mikgeek-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 资源服务\n        - id: mikgeek-resource\n          uri: lb://mikgeek-resource\n          predicates:\n            - Path=/resource/**\n          filters:\n            - StripPrefix=1\n        # 演示服务\n        - id: mikgeek-demo\n          uri: lb://mikgeek-demo\n          predicates:\n            - Path=/demo/**\n          filters:\n            - StripPrefix=1\n        # MQ演示服务\n        - id: mikgeek-stream-mq\n          uri: lb://mikgeek-stream-mq\n          predicates:\n            - Path=/stream-mq/**\n          filters:\n            - StripPrefix=1\n\n    # sentinel 配置\n    sentinel:\n      filter:\n        enabled: false\n      # nacos配置持久化\n      datasource:\n        ds1:\n          nacos:\n            server-addr: ${spring.cloud.nacos.server-addr}\n            dataId: sentinel-${spring.application.name}.json\n            groupId: ${spring.cloud.nacos.config.group}\n            namespace: ${spring.profiles.active}\n            data-type: json\n            rule-type: gw-flow\n',
        'c7009f26e8c981e7cbccf833455fca7a', '2022-01-09 15:19:43', '2024-03-18 09:54:51', 'nacos', '127.0.0.1', '',
        'dev', '网关模块', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (4, 'mikgeek-auth.yml', 'DEFAULT_GROUP',
        '# 用户配置\nuser:\n  password:\n    # 密码最大错误次数\n    maxRetryCount: 5\n    # 密码锁定时间（默认10分钟）\n    lockTime: 10\n',
        '1fd08de287662e81f0ced8808d7b19e6', '2022-01-09 15:19:43', '2024-03-18 09:55:02', 'nacos', '127.0.0.1', '',
        'dev', '认证中心', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (5, 'mikgeek-monitor.yml', 'DEFAULT_GROUP',
        '# 监控中心配置\nspring:\n  security:\n    user:\n      name: mikgeek\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: mikgeek-cloud服务监控中心\n      discovery:\n        # seata 不具有健康检查的能力 防止报错排除掉\n        ignored-services: mikgeek-seata-server\n',
        '61dabcdf29444e5801de74cc61ac0af2', '2022-01-09 15:20:18', '2024-03-18 09:55:16', 'nacos', '127.0.0.1', '',
        'dev', '监控中心', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (6, 'mikgeek-system.yml', 'DEFAULT_GROUP',
        'spring:\n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为 master\n      primary: master\n      datasource:\n        # 主库数据源\n        master:\n          type: ${spring.datasource.type}\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: ${datasource.system-master.url}\n          username: ${datasource.system-master.username}\n          password: ${datasource.system-master.password}\n',
        '4171eb1fc85049c9c4c0aa21d40f4f8d', '2022-01-09 15:20:18', '2024-03-18 09:55:38', 'nacos', '127.0.0.1', '',
        'dev', '系统模块', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (8, 'mikgeek-job.yml', 'DEFAULT_GROUP',
        'spring:\n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为 master\n      primary: master\n      datasource:\n        # 主库数据源\n        master:\n          type: ${spring.datasource.type}\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: ${datasource.job.url}\n          username: ${datasource.job.username}\n          password: ${datasource.job.password}\n\nxxl:\n  job:\n    # 执行器开关\n    enabled: true\n    # 调度中心地址：如调度中心集群部署存在多个地址则用逗号分隔。\n    # admin-addresses: http://localhost:9900\n    # 调度中心应用名 通过服务名连接调度中心(启用admin-appname会导致admin-addresses不生效)\n    admin-appname: mikgeek-xxl-job-admin\n    # 执行器通讯TOKEN：非空时启用\n    access-token: xxl-job\n    # 执行器配置\n    executor:\n      # 执行器AppName：执行器心跳注册分组依据；为空则关闭自动注册\n      appname: ${spring.application.name}-executor\n      # 29203 端口 随着主应用端口飘逸 避免集群冲突\n      port: 2${server.port}\n      # 执行器注册：默认IP:PORT\n      address:\n      # 执行器IP：默认自动获取IP\n      ip:\n      # 执行器运行日志文件存储磁盘路径\n      logpath: ./logs/${spring.application.name}/xxl-job\n      # 执行器日志文件保存天数：大于3生效\n      logretentiondays: 30\n',
        '26b053a2fb840f184ea2f13a9d87eaca', '2022-01-09 15:20:18', '2024-03-18 10:09:00', 'nacos', '127.0.0.1', '',
        'dev', '定时任务', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (9, 'mikgeek-resource.yml', 'DEFAULT_GROUP',
        'spring:\n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为 master\n      primary: master\n      datasource:\n        # 主库数据源\n        master:\n          type: ${spring.datasource.type}\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: ${datasource.system-master.url}\n          username: ${datasource.system-master.username}\n          password: ${datasource.system-master.password}\n\n\nmail:\n  enabled: false\n  host: smtp.163.com\n  port: 465\n  # 是否需要用户名密码验证\n  auth: true\n  # 发送方，遵循RFC-822标准\n  from: xxx@163.com\n  # 用户名（注意：如果使用foxmail邮箱，此处user为qq号）\n  user: xxx@163.com\n  # 密码（注意，某些邮箱需要为SMTP服务单独设置密码，详情查看相关帮助）\n  pass: xxxxxxxxxx\n  # 使用 STARTTLS安全连接，STARTTLS是对纯文本通信协议的扩展。\n  starttlsEnable: true\n  # 使用SSL安全连接\n  sslEnable: true\n  # SMTP超时时长，单位毫秒，缺省值不超时\n  timeout: 0\n  # Socket连接超时值，单位毫秒，缺省值不超时\n  connectionTimeout: 0\n\n# sms 短信 支持 阿里云 腾讯云 云片 等等各式各样的短信服务商\n# https://wind.kim/doc/start 文档地址 各个厂商可同时使用\nsms:\n  # 阿里云 dysmsapi.aliyuncs.com\n  alibaba:\n    #请求地址 默认为 dysmsapi.aliyuncs.com 如无特殊改变可以不用设置\n    requestUrl: dysmsapi.aliyuncs.com\n    #阿里云的accessKey\n    accessKeyId: xxxxxxx\n    #阿里云的accessKeySecret\n    accessKeySecret: xxxxxxx\n    #短信签名\n    signature: 测试\n  tencent:\n    #请求地址默认为 sms.tencentcloudapi.com 如无特殊改变可不用设置\n    requestUrl: sms.tencentcloudapi.com\n    #腾讯云的accessKey\n    accessKeyId: xxxxxxx\n    #腾讯云的accessKeySecret\n    accessKeySecret: xxxxxxx\n    #短信签名\n    signature: 测试\n    #短信sdkAppId\n    sdkAppId: appid\n    #地域信息默认为 ap-guangzhou 如无特殊改变可不用设置\n    territory: ap-guangzhou\n',
        '8436355213f752d7b9ffa4d02f46e83e', '2022-01-09 15:20:35', '2024-03-18 09:56:15', 'nacos', '127.0.0.1', '',
        'dev', '文件服务', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (10, 'sentinel-mikgeek-gateway.json', 'DEFAULT_GROUP',
        '[\n  {\n    \"resource\": \"mikgeek-auth\",\n    \"count\": 500,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0,\n    \"controlBehavior\": 0\n  },\n  {\n    \"resource\": \"mikgeek-system\",\n    \"count\": 1000,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0,\n    \"controlBehavior\": 0\n  },\n  {\n    \"resource\": \"mikgeek-resource\",\n    \"count\": 500,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0,\n    \"controlBehavior\": 0\n  }\n]\n',
        'eeece51d7b72d7fc35ee01ac746a9072', '2022-01-09 15:21:02', '2024-03-18 09:56:42', 'nacos', '127.0.0.1', '',
        'dev', '限流策略', '', '', 'json', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (11, 'mikgeek-xxl-job-admin.yml', 'DEFAULT_GROUP',
        '# server 配置\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: ${datasource.job.url}\n    username: ${datasource.job.username}\n    password: ${datasource.job.password}\n    hikari:\n      auto-commit: true\n      connection-test-query: SELECT 1\n      connection-timeout: 10000\n      idle-timeout: 30000\n      max-lifetime: 900000\n      maximum-pool-size: 30\n      minimum-idle: 10\n      pool-name: HikariCP\n      validation-timeout: 1000\n  mail:\n    from: xxx@qq.com\n    host: smtp.qq.com\n    username: xxx@qq.com\n    password: xxx\n    port: 25\n    properties:\n      mail:\n        smtp:\n          auth: true\n          socketFactory:\n            class: javax.net.ssl.SSLSocketFactory\n          starttls:\n            enable: true\n            required: true\n\n# mybatis 配置\nmybatis:\n  mapper-locations: classpath:/mybatis-mapper/*Mapper.xml\n\n# Actuator 监控端点的配置项\nmanagement:\n  health:\n    mail:\n      enabled: false\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: ALWAYS\n    logfile:\n      external-file: ./logs/${spring.application.name}/console.log\n\n# xxljob系统配置\nxxl:\n  job:\n    # 鉴权token\n    accessToken: xxl-job\n    # 国际化\n    i18n: zh_CN\n    # 日志清理\n    logretentiondays: 30\n    triggerpool:\n      fast:\n        max: 200\n      slow:\n        max: 100\n',
        '0e2612c76e9c75fb10cb69adf076ae55', '2022-01-09 15:21:02', '2024-03-18 10:08:46', 'nacos', '127.0.0.1', '',
        'dev', '定时任务控制台', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (12, 'seata-server.properties', 'DEFAULT_GROUP',
        'service.vgroupMapping.mikgeek-auth-group=default\nservice.vgroupMapping.mikgeek-system-group=default\nservice.vgroupMapping.mikgeek-resource-group=default\nservice.vgroupMapping.mikgeek-gen-group=default\nservice.vgroupMapping.mikgeek-job-group=default\n\nservice.enableDegrade=false\nservice.disableGlobalTransaction=false\n\n#Transaction storage configuration, only for the server. The file, DB, and redis configuration values are optional.\nstore.mode=db\nstore.lock.mode=db\nstore.session.mode=db\n#Used for password encryption\nstore.publicKey=\n\n#These configurations are required if the `store mode` is `db`. If `store.mode,store.lock.mode,store.session.mode` are not equal to `db`, you can remove the configuration block.\nstore.db.datasource=hikari\nstore.db.dbType=mysql\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\nstore.db.url=jdbc:mysql://127.0.0.1:3306/mikgeek_seata?useUnicode=true&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true\nstore.db.user=root\nstore.db.password=root\nstore.db.minConn=5\nstore.db.maxConn=30\nstore.db.globalTable=global_table\nstore.db.branchTable=branch_table\nstore.db.distributedLockTable=distributed_lock\nstore.db.queryLimit=100\nstore.db.lockTable=lock_table\nstore.db.maxWait=5000\n\n# redis æ¨¡å¼ store.mode=redis å¼å¯ (æ§å¶å°æ¥è¯¢åè½æé,ä¸å½±åå®éæ§è¡åè½)\n# store.redis.host=127.0.0.1\n# store.redis.port=6379\n# æå¤§è¿æ¥æ°\n# store.redis.maxConn=10\n# æå°è¿æ¥æ°\n# store.redis.minConn=1\n# store.redis.database=0\n# store.redis.password=\n# store.redis.queryLimit=100\n\n#Transaction rule configuration, only for the server\nserver.recovery.committingRetryPeriod=1000\nserver.recovery.asynCommittingRetryPeriod=1000\nserver.recovery.rollbackingRetryPeriod=1000\nserver.recovery.timeoutRetryPeriod=1000\nserver.maxCommitRetryTimeout=-1\nserver.maxRollbackRetryTimeout=-1\nserver.rollbackRetryTimeoutUnlockEnable=false\nserver.distributedLockExpireTime=10000\nserver.xaerNotaRetryTimeout=60000\nserver.session.branchAsyncQueueSize=5000\nserver.session.enableBranchAsyncRemove=false\n\n#Transaction rule configuration, only for the client\nclient.rm.asyncCommitBufferLimit=10000\nclient.rm.lock.retryInterval=10\nclient.rm.lock.retryTimes=30\nclient.rm.lock.retryPolicyBranchRollbackOnConflict=true\nclient.rm.reportRetryCount=5\nclient.rm.tableMetaCheckEnable=true\nclient.rm.tableMetaCheckerInterval=60000\nclient.rm.sqlParserType=druid\nclient.rm.reportSuccessEnable=false\nclient.rm.sagaBranchRegisterEnable=false\nclient.rm.sagaJsonParser=fastjson\nclient.rm.tccActionInterceptorOrder=-2147482648\nclient.tm.commitRetryCount=5\nclient.tm.rollbackRetryCount=5\nclient.tm.defaultGlobalTransactionTimeout=60000\nclient.tm.degradeCheck=false\nclient.tm.degradeCheckAllowTimes=10\nclient.tm.degradeCheckPeriod=2000\nclient.tm.interceptorOrder=-2147482648\nclient.undo.dataValidation=true\nclient.undo.logSerialization=jackson\nclient.undo.onlyCareUpdateColumns=true\nserver.undo.logSaveDays=7\nserver.undo.logDeletePeriod=86400000\nclient.undo.logTable=undo_log\nclient.undo.compress.enable=true\nclient.undo.compress.type=zip\nclient.undo.compress.threshold=64k\n\n#For TCC transaction mode\ntcc.fence.logTableName=tcc_fence_log\ntcc.fence.cleanPeriod=1h\n\n#Log rule configuration, for client and server\nlog.exceptionRate=100\n\n#Metrics configuration, only for the server\nmetrics.enabled=false\nmetrics.registryType=compact\nmetrics.exporterList=prometheus\nmetrics.exporterPrometheusPort=9898\n\n#For details about configuration items, see https://seata.io/zh-cn/docs/user/configurations.html\n#Transport configuration, for client and server\ntransport.type=TCP\ntransport.server=NIO\ntransport.heartbeat=true\ntransport.enableTmClientBatchSendRequest=false\ntransport.enableRmClientBatchSendRequest=true\ntransport.enableTcServerBatchSendResponse=false\ntransport.rpcRmRequestTimeout=30000\ntransport.rpcTmRequestTimeout=30000\ntransport.rpcTcRequestTimeout=30000\ntransport.threadFactory.bossThreadPrefix=NettyBoss\ntransport.threadFactory.workerThreadPrefix=NettyServerNIOWorker\ntransport.threadFactory.serverExecutorThreadPrefix=NettyServerBizHandler\ntransport.threadFactory.shareBossWorker=false\ntransport.threadFactory.clientSelectorThreadPrefix=NettyClientSelector\ntransport.threadFactory.clientSelectorThreadSize=1\ntransport.threadFactory.clientWorkerThreadPrefix=NettyClientWorkerThread\ntransport.threadFactory.bossThreadSize=1\ntransport.threadFactory.workerThreadSize=default\ntransport.shutdown.wait=3\ntransport.serialization=seata\ntransport.compressor=none\n',
        'fe56688fb8fea6d58cbf7aad70325391', '2022-01-09 15:21:02', '2024-03-18 09:57:18', 'nacos', '127.0.0.1', '',
        'dev', 'seata配置文件', '', '', 'properties', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (13, 'mikgeek-sentinel-dashboard.yml', 'DEFAULT_GROUP',
        'spring:\n  mvc:\n    pathmatch:\n      # 修复 sentinel 控制台未适配 springboot 2.6 新路由方式\n      matching-strategy: ANT_PATH_MATCHER\n\nserver:\n  servlet:\n    encoding:\n      force: true\n      charset: UTF-8\n      enabled: true\n    session:\n      cookie:\n        name: sentinel_dashboard_cookie\n\nlogging:\n  level:\n    org.springframework.web: INFO\n\nauth:\n  enabled: true\n  filter:\n    exclude-urls: /,/auth/login,/auth/logout,/registry/machine,/version,/actuator,/actuator/**\n    exclude-url-suffixes: htm,html,js,css,map,ico,ttf,woff,png\n  username: sentinel\n  password: sentinel\n',
        '59055747c62f08cd2c38a6016d4b9227', '2022-01-09 15:21:02', '2024-03-18 10:10:31', 'nacos', '127.0.0.1', '',
        'dev', 'sentinel控制台配置文件', '', '', 'yaml', '', '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (101, 'application-common.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '通用配置基础配置', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (102, 'datasource.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '数据源配置', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (103, 'mikgeek-gateway.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '网关模块', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (104, 'mikgeek-auth.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '认证中心', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (105, 'mikgeek-monitor.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '监控中心', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (106, 'mikgeek-system.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '系统模块', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (107, 'mikgeek-gen.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '代码生成', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (108, 'mikgeek-job.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '定时任务', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (109, 'mikgeek-resource.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '文件服务', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (110, 'sentinel-mikgeek-gateway.json', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:23:00', '2022-01-09 15:23:00', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '限流策略', NULL, NULL, 'json', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (111, 'mikgeek-xxl-job-admin.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:21:02', '2022-01-09 15:21:02', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', '定时任务控制台', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (112, 'seata-server.properties', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:21:02', '2022-01-09 15:21:02', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', 'seata配置文件', NULL, NULL, 'properties', NULL, '');
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`,
                           `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`,
                           `encrypted_data_key`)
VALUES (113, 'mikgeek-sentinel-dashboard.yml', 'DEFAULT_GROUP', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2022-01-09 15:21:02', '2022-01-09 15:21:02', NULL, '0:0:0:0:0:0:0:1', '',
        'prod', 'sentinel控制台配置文件', NULL, NULL, 'yaml', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`
(
    `id`           bigint                           NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`      varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
    `group_id`     varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
    `datum_id`     varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
    `content`      longtext COLLATE utf8mb3_bin     NOT NULL COMMENT '内容',
    `gmt_modified` datetime                         NOT NULL COMMENT '修改时间',
    `app_name`     varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
    `tenant_id`    varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='增加租户字段';

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`
(
    `id`                 bigint                           NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`            varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
    `group_id`           varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
    `app_name`           varchar(128) COLLATE utf8mb3_bin          DEFAULT NULL COMMENT 'app_name',
    `content`            longtext COLLATE utf8mb3_bin     NOT NULL COMMENT 'content',
    `beta_ips`           varchar(1024) COLLATE utf8mb3_bin         DEFAULT NULL COMMENT 'betaIps',
    `md5`                varchar(32) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'md5',
    `gmt_create`         datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`       datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`           text COLLATE utf8mb3_bin COMMENT 'source user',
    `src_ip`             varchar(50) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'source ip',
    `tenant_id`          varchar(128) COLLATE utf8mb3_bin          DEFAULT '' COMMENT '租户字段',
    `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_beta';

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`
(
    `id`           bigint                           NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`      varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
    `group_id`     varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
    `tenant_id`    varchar(128) COLLATE utf8mb3_bin          DEFAULT '' COMMENT 'tenant_id',
    `tag_id`       varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
    `app_name`     varchar(128) COLLATE utf8mb3_bin          DEFAULT NULL COMMENT 'app_name',
    `content`      longtext COLLATE utf8mb3_bin     NOT NULL COMMENT 'content',
    `md5`          varchar(32) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'md5',
    `gmt_create`   datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`     text COLLATE utf8mb3_bin COMMENT 'source user',
    `src_ip`       varchar(50) COLLATE utf8mb3_bin           DEFAULT NULL COMMENT 'source ip',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_tag';

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`
(
    `id`        bigint                           NOT NULL COMMENT 'id',
    `tag_name`  varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
    `tag_type`  varchar(64) COLLATE utf8mb3_bin  DEFAULT NULL COMMENT 'tag_type',
    `data_id`   varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
    `group_id`  varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
    `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
    `nid`       bigint                           NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`nid`),
    UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
    KEY         `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_tag_relation';

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`
(
    `id`                bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `group_id`          varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
    `quota`             int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage`             int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size`          int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    `max_aggr_count`    int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
    `max_aggr_size`     int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    `gmt_create`        datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`      datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='集群、各Group容量信息表';

-- ----------------------------
-- Records of group_capacity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`
(
    `id`                 bigint unsigned NOT NULL,
    `nid`                bigint unsigned NOT NULL AUTO_INCREMENT,
    `data_id`            varchar(255) COLLATE utf8mb3_bin NOT NULL,
    `group_id`           varchar(128) COLLATE utf8mb3_bin NOT NULL,
    `app_name`           varchar(128) COLLATE utf8mb3_bin          DEFAULT NULL COMMENT 'app_name',
    `content`            longtext COLLATE utf8mb3_bin     NOT NULL,
    `md5`                varchar(32) COLLATE utf8mb3_bin           DEFAULT NULL,
    `gmt_create`         datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified`       datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `src_user`           text COLLATE utf8mb3_bin,
    `src_ip`             varchar(50) COLLATE utf8mb3_bin           DEFAULT NULL,
    `op_type`            char(10) COLLATE utf8mb3_bin              DEFAULT NULL,
    `tenant_id`          varchar(128) COLLATE utf8mb3_bin          DEFAULT '' COMMENT '租户字段',
    `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
    PRIMARY KEY (`nid`),
    KEY                  `idx_gmt_create` (`gmt_create`),
    KEY                  `idx_gmt_modified` (`gmt_modified`),
    KEY                  `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='多租户改造';

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
BEGIN;
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (1, 1, 'application-common.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:54:14', '2024-03-18 09:54:14', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (2, 2, 'datasource.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:54:36', '2024-03-18 09:54:37', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (3, 3, 'mikgeek-gateway.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:54:51', '2024-03-18 09:54:51', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (4, 4, 'mikgeek-auth.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:55:02', '2024-03-18 09:55:02', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (5, 5, 'mikgeek-monitor.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:55:16', '2024-03-18 09:55:16', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (6, 6, 'mikgeek-system.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:55:37', '2024-03-18 09:55:38', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (7, 7, 'mikgeek-gen.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:55:44', '2024-03-18 09:55:45', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (8, 8, 'mikgeek-job.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:55:57', '2024-03-18 09:55:58', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (9, 9, 'mikgeek-resource.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:56:15', '2024-03-18 09:56:15', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (10, 10, 'sentinel-mikgeek-gateway.json', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:56:42', '2024-03-18 09:56:42', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (12, 11, 'seata-server.properties', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 17:57:18', '2024-03-18 09:57:18', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 12, 'com.mikgeek.resource.api.RemoteFileService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 13, 'com.mikgeek.resource.api.RemoteFileService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteFileService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"upload\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"byte[]\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"annotations\":[],\"name\":\"selectUrlByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341114\"},\"types\":[{\"enums\":[],\"items\":[\"byte\"],\"properties\":{},\"type\":\"byte[]\"},{\"enums\":[],\"items\":[],\"properties\":{\"ossId\":\"java.lang.Long\",\"name\":\"java.lang.String\",\"url\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"byte\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteFileService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'ac87615768d5dcf7f52724dff8d7d682', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 14, 'com.mikgeek.resource.api.RemoteMailService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteMailService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\"],\"parameters\":[],\"returnType\":\"void\"},{\"annotations\":[],\"name\":\"sendWithAttachment\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"java.util.List<java.io.File>\"],\"parameters\":[],\"returnType\":\"void\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341694\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"void\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"path\":\"java.lang.String\"},\"type\":\"java.io.File\"},{\"enums\":[],\"items\":[\"java.io.File\"],\"properties\":{},\"type\":\"java.util.List<java.io.File>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteMailService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'd306676bbc8cce12458506fb1dd07bf1', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 15, 'com.mikgeek.resource.api.RemoteMailService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 16, 'com.mikgeek.resource.api.RemoteSmsService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteSmsService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysSms\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341748\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"response\":\"java.lang.String\",\"message\":\"java.lang.String\",\"isSuccess\":\"java.lang.Boolean\"},\"type\":\"com.mikgeek.resource.api.domain.SysSms\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteSmsService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'e17e3ece84abea801e66df837b85b3b9', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 17, 'com.mikgeek.resource.api.RemoteSmsService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:05:41', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 18, 'mikgeek-resource', '9cd8f2e7653efce580709995bb1507c2', '',
        '{\"app\":\"mikgeek-resource\",\"revision\":\"9cd8f2e7653efce580709995bb1507c2\",\"services\":{\"com.mikgeek.resource.api.RemoteSmsService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteSmsService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteSmsService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteMailService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteMailService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteMailService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteFileService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteFileService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteFileService\",\"port\":20880,\"protocol\":\"dubbo\"}}}',
        'f4c0228879fc5a9cdd8c5b5a300b5a7f', '2024-03-18 18:05:42', '2024-03-18 10:05:42', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 19, 'com.mikgeek.resource.api.RemoteDictService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 20, 'com.mikgeek.resource.api.RemoteDictService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteDictService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDictDataByType\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347408\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"com.mikgeek.resource.api.domain.SysDictData\"],\"properties\":{},\"type\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"},{\"enums\":[],\"items\":[],\"properties\":{\"dictValue\":\"java.lang.String\",\"listClass\":\"java.lang.String\",\"dictSort\":\"java.lang.Integer\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"dictType\":\"java.lang.String\",\"dictLabel\":\"java.lang.String\",\"isDefault\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"cssClass\":\"java.lang.String\",\"dictCode\":\"java.lang.Long\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysDictData\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteDictService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '42cd7acca07b419a973b8d12962e1664', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 21, 'com.mikgeek.member.api.RemoteDataScopeService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getRoleCustom\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getDeptAndChild\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347775\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDataScopeService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        'adc610954a8e24788b54d0f984992f43', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 22, 'com.mikgeek.member.api.RemoteDataScopeService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 23, 'com.mikgeek.member.api.RemoteDeptService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDeptService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDeptNameByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347799\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDeptService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '4fc6355acc1d668a0902e142fa4edf7e', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 24, 'com.mikgeek.member.api.RemoteDeptService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 25, 'com.mikgeek.member.api.RemoteLogService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteLogService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"saveLogininfor\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysLogininfor\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"saveLog\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysOperLog\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347818\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"msg\":\"java.lang.String\",\"infoId\":\"java.lang.Long\",\"loginTime\":\"java.util.Date\",\"os\":\"java.lang.String\",\"browser\":\"java.lang.String\",\"userName\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysLogininfor\"},{\"enums\":[],\"items\":[\"java.lang.Integer\"],\"properties\":{},\"type\":\"java.lang.Integer[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"method\":\"java.lang.String\",\"requestMethod\":\"java.lang.String\",\"operId\":\"java.lang.Long\",\"title\":\"java.lang.String\",\"businessTypes\":\"java.lang.Integer[]\",\"jsonResult\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"errorMsg\":\"java.lang.String\",\"operLocation\":\"java.lang.String\",\"operIp\":\"java.lang.String\",\"operUrl\":\"java.lang.String\",\"operName\":\"java.lang.String\",\"operatorType\":\"java.lang.Integer\",\"businessType\":\"java.lang.Integer\",\"operParam\":\"java.lang.String\",\"status\":\"java.lang.Integer\",\"operTime\":\"java.util.Date\"},\"type\":\"domain.com.mikgeek.member.api.SysOperLog\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteLogService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '28937fc5b0a4d4fd7f25efa12f8b7e83', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 26, 'com.mikgeek.member.api.RemoteLogService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 27, 'com.mikgeek.member.api.RemoteUserService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 28, 'com.mikgeek.member.api.RemoteUserService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteUserService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getUserInfoByPhonenumber\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByEmail\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByOpenid\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.XcxLoginUser\"},{\"annotations\":[],\"name\":\"registerUserInfo\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysUser\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"selectUserNameById\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getUserInfo\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347846\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.List<T>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[],\"properties\":{\"flag\":\"boolean\",\"roleId\":\"java.lang.Long\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"dataScope\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"roleSort\":\"java.lang.Integer\",\"deptCheckStrictly\":\"java.lang.Boolean\",\"createBy\":\"java.lang.String\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"menuCheckStrictly\":\"java.lang.Boolean\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"deptIds\":\"java.lang.Long[]\",\"menuIds\":\"java.lang.Long[]\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysRole\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"leader\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"orderNum\":\"java.lang.Integer\",\"updateTime\":\"java.util.Date\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"parentId\":\"java.lang.Long\",\"parentName\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"phone\":\"java.lang.String\",\"children\":\"java.util.List<T>\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"ancestors\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"email\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysDept\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.Set<java.lang.String>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"},{\"enums\":[],\"items\":[\"java.lang.Long\"],\"properties\":{},\"type\":\"java.lang.Long[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roleId\":\"java.lang.Long\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"dataScope\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.RoleDTO\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[\"model.com.mikgeek.member.api.RoleDTO\"],\"properties\":{},\"type\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\"},{\"enums\":[],\"items\":[\"domain.com.mikgeek.member.api.SysRole\"],\"properties\":{},\"type\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.LoginUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roles\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\",\"phonenumber\":\"java.lang.String\",\"loginDate\":\"java.util.Date\",\"remark\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"password\":\"java.lang.String\",\"updateBy\":\"java.lang.String\",\"postIds\":\"java.lang.Long[]\",\"loginIp\":\"java.lang.String\",\"email\":\"java.lang.String\",\"nickName\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"sex\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"updateTime\":\"java.util.Date\",\"avatar\":\"java.lang.String\",\"dept\":\"domain.com.mikgeek.member.api.SysDept\",\"userName\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"userId\":\"java.lang.Long\",\"createBy\":\"java.lang.String\",\"roleIds\":\"java.lang.Long[]\",\"createTime\":\"java.util.Date\",\"userType\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"openid\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.XcxLoginUser\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteUserService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '465a381279c18a5f1bf4f06e29d135e4', '2024-03-18 18:05:47', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (0, 29, 'mikgeek-system', 'ebf35af3cd1a43b023c661980ee131d8', '',
        '{\"app\":\"mikgeek-system\",\"revision\":\"ebf35af3cd1a43b023c661980ee131d8\",\"services\":{\"com.mikgeek.resource.api.RemoteDictService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteDictService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteDictService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDataScopeService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDeptService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDeptService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDeptService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteUserService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteUserService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteUserService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteLogService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteLogService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteLogService\",\"port\":20881,\"protocol\":\"dubbo\"}}}',
        'bcf5e583aa3caf69d8d8151b19cef3a0', '2024-03-18 18:05:48', '2024-03-18 10:05:48', NULL, '192.168.1.7', 'I',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (11, 30, 'mikgeek-xxl-job-admin.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 18:08:45', '2024-03-18 10:08:46', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (8, 31, 'mikgeek-job.yml', 'DEFAULT_GROUP', '',
        'spring:\n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为 master\n      primary: master\n      datasource:\n        # 主库数据源\n        master:\n          type: ${spring.datasource.type}\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: ${datasource.job.url}\n          username: ${datasource.job.username}\n          password: ${datasource.job.password}\n\nxxl:\n  job:\n    # 执行器开关\n    enabled: true\n    # 调度中心地址：如调度中心集群部署存在多个地址则用逗号分隔。\n    # admin-addresses: http://localhost:9900\n    # 调度中心应用名 通过服务名连接调度中心(启用admin-appname会导致admin-addresses不生效)\n    admin-appname: mikgeek-xxl-job-admin\n    # 执行器通讯TOKEN：非空时启用\n    access-token: xxl-job\n    # 执行器配置\n    executor:\n      # 执行器AppName：执行器心跳注册分组依据；为空则关闭自动注册\n      appname: ${spring.application.name}-executor\n      # 29203 端口 随着主应用端口飘逸 避免集群冲突\n      port: 2${server.port}\n      # 执行器注册：默认IP:PORT\n      address:\n      # 执行器IP：默认自动获取IP\n      ip:\n      # 执行器运行日志文件存储磁盘路径\n      logpath: ./logs/${spring.application.name}/xxl-job\n      # 执行器日志文件保存天数：大于3生效\n      logretentiondays: 30\n',
        '26b053a2fb840f184ea2f13a9d87eaca', '2024-03-18 18:08:59', '2024-03-18 10:09:00', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (13, 32, 'mikgeek-sentinel-dashboard.yml', 'DEFAULT_GROUP', '', '# 将项目路径：config/下对应文件中内容复制到此处',
        '2944a25cb97926efcaa43b3ad7a64cf0', '2024-03-18 18:10:31', '2024-03-18 10:10:31', 'nacos', '127.0.0.1', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (125, 33, 'com.mikgeek.resource.api.RemoteFileService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteFileService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"upload\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"byte[]\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"annotations\":[],\"name\":\"selectUrlByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341114\"},\"types\":[{\"enums\":[],\"items\":[\"byte\"],\"properties\":{},\"type\":\"byte[]\"},{\"enums\":[],\"items\":[],\"properties\":{\"ossId\":\"java.lang.Long\",\"name\":\"java.lang.String\",\"url\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"byte\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteFileService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'ac87615768d5dcf7f52724dff8d7d682', '2024-03-18 18:11:56', '2024-03-18 10:11:57', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (126, 34, 'com.mikgeek.resource.api.RemoteMailService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteMailService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\"],\"parameters\":[],\"returnType\":\"void\"},{\"annotations\":[],\"name\":\"sendWithAttachment\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"java.util.List<java.io.File>\"],\"parameters\":[],\"returnType\":\"void\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341694\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"void\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"path\":\"java.lang.String\"},\"type\":\"java.io.File\"},{\"enums\":[],\"items\":[\"java.io.File\"],\"properties\":{},\"type\":\"java.util.List<java.io.File>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteMailService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'd306676bbc8cce12458506fb1dd07bf1', '2024-03-18 18:11:56', '2024-03-18 10:11:57', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (128, 35, 'com.mikgeek.resource.api.RemoteSmsService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteSmsService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysSms\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"application\":\"mikgeek-resource\",\"metadata-type\":\"remote\",\"side\":\"provider\",\"release\":\"3.1.11\",\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31264\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756341748\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"response\":\"java.lang.String\",\"message\":\"java.lang.String\",\"isSuccess\":\"java.lang.Boolean\"},\"type\":\"com.mikgeek.resource.api.domain.SysSms\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteSmsService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'e17e3ece84abea801e66df837b85b3b9', '2024-03-18 18:11:56', '2024-03-18 10:11:57', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (130, 36, 'mikgeek-resource', '9cd8f2e7653efce580709995bb1507c2', '',
        '{\"app\":\"mikgeek-resource\",\"revision\":\"9cd8f2e7653efce580709995bb1507c2\",\"services\":{\"com.mikgeek.resource.api.RemoteSmsService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteSmsService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteSmsService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteMailService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteMailService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteMailService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteFileService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteFileService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteFileService\",\"port\":20880,\"protocol\":\"dubbo\"}}}',
        'f4c0228879fc5a9cdd8c5b5a300b5a7f', '2024-03-18 18:11:57', '2024-03-18 10:11:57', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (132, 37, 'com.mikgeek.resource.api.RemoteDictService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteDictService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDictDataByType\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347408\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"com.mikgeek.resource.api.domain.SysDictData\"],\"properties\":{},\"type\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"},{\"enums\":[],\"items\":[],\"properties\":{\"dictValue\":\"java.lang.String\",\"listClass\":\"java.lang.String\",\"dictSort\":\"java.lang.Integer\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"dictType\":\"java.lang.String\",\"dictLabel\":\"java.lang.String\",\"isDefault\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"cssClass\":\"java.lang.String\",\"dictCode\":\"java.lang.Long\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysDictData\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteDictService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '42cd7acca07b419a973b8d12962e1664', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (133, 38, 'com.mikgeek.member.api.RemoteDataScopeService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getRoleCustom\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getDeptAndChild\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347775\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDataScopeService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        'adc610954a8e24788b54d0f984992f43', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (135, 39, 'com.mikgeek.member.api.RemoteDeptService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDeptService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDeptNameByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347799\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDeptService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '4fc6355acc1d668a0902e142fa4edf7e', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (137, 40, 'com.mikgeek.member.api.RemoteLogService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteLogService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"saveLogininfor\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysLogininfor\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"saveLog\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysOperLog\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347818\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"msg\":\"java.lang.String\",\"infoId\":\"java.lang.Long\",\"loginTime\":\"java.util.Date\",\"os\":\"java.lang.String\",\"browser\":\"java.lang.String\",\"userName\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysLogininfor\"},{\"enums\":[],\"items\":[\"java.lang.Integer\"],\"properties\":{},\"type\":\"java.lang.Integer[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"method\":\"java.lang.String\",\"requestMethod\":\"java.lang.String\",\"operId\":\"java.lang.Long\",\"title\":\"java.lang.String\",\"businessTypes\":\"java.lang.Integer[]\",\"jsonResult\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"errorMsg\":\"java.lang.String\",\"operLocation\":\"java.lang.String\",\"operIp\":\"java.lang.String\",\"operUrl\":\"java.lang.String\",\"operName\":\"java.lang.String\",\"operatorType\":\"java.lang.Integer\",\"businessType\":\"java.lang.Integer\",\"operParam\":\"java.lang.String\",\"status\":\"java.lang.Integer\",\"operTime\":\"java.util.Date\"},\"type\":\"domain.com.mikgeek.member.api.SysOperLog\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteLogService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '28937fc5b0a4d4fd7f25efa12f8b7e83', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (140, 41, 'com.mikgeek.member.api.RemoteUserService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteUserService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getUserInfoByPhonenumber\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByEmail\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByOpenid\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.XcxLoginUser\"},{\"annotations\":[],\"name\":\"registerUserInfo\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysUser\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"selectUserNameById\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getUserInfo\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"}],\"parameters\":{\"anyhost\":\"true\",\"dubbo\":\"2.0.2\",\"pid\":\"31289\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756347846\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.List<T>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[],\"properties\":{\"flag\":\"boolean\",\"roleId\":\"java.lang.Long\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"dataScope\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"roleSort\":\"java.lang.Integer\",\"deptCheckStrictly\":\"java.lang.Boolean\",\"createBy\":\"java.lang.String\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"menuCheckStrictly\":\"java.lang.Boolean\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"deptIds\":\"java.lang.Long[]\",\"menuIds\":\"java.lang.Long[]\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysRole\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"leader\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"orderNum\":\"java.lang.Integer\",\"updateTime\":\"java.util.Date\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"parentId\":\"java.lang.Long\",\"parentName\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"phone\":\"java.lang.String\",\"children\":\"java.util.List<T>\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"ancestors\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"email\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysDept\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.Set<java.lang.String>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"},{\"enums\":[],\"items\":[\"java.lang.Long\"],\"properties\":{},\"type\":\"java.lang.Long[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roleId\":\"java.lang.Long\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"dataScope\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.RoleDTO\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[\"model.com.mikgeek.member.api.RoleDTO\"],\"properties\":{},\"type\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\"},{\"enums\":[],\"items\":[\"domain.com.mikgeek.member.api.SysRole\"],\"properties\":{},\"type\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.LoginUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roles\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\",\"phonenumber\":\"java.lang.String\",\"loginDate\":\"java.util.Date\",\"remark\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"password\":\"java.lang.String\",\"updateBy\":\"java.lang.String\",\"postIds\":\"java.lang.Long[]\",\"loginIp\":\"java.lang.String\",\"email\":\"java.lang.String\",\"nickName\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"sex\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"updateTime\":\"java.util.Date\",\"avatar\":\"java.lang.String\",\"dept\":\"domain.com.mikgeek.member.api.SysDept\",\"userName\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"userId\":\"java.lang.Long\",\"createBy\":\"java.lang.String\",\"roleIds\":\"java.lang.Long[]\",\"createTime\":\"java.util.Date\",\"userType\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"openid\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.XcxLoginUser\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteUserService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '465a381279c18a5f1bf4f06e29d135e4', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (141, 42, 'mikgeek-system', 'ebf35af3cd1a43b023c661980ee131d8', '',
        '{\"app\":\"mikgeek-system\",\"revision\":\"ebf35af3cd1a43b023c661980ee131d8\",\"services\":{\"com.mikgeek.resource.api.RemoteDictService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteDictService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteDictService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDataScopeService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDeptService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDeptService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDeptService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteUserService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteUserService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteUserService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteLogService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteLogService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteLogService\",\"port\":20881,\"protocol\":\"dubbo\"}}}',
        'bcf5e583aa3caf69d8d8151b19cef3a0', '2024-03-18 18:14:08', '2024-03-18 10:14:08', NULL, '192.168.1.7', 'U',
        'dev', '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (125, 43, 'com.mikgeek.resource.api.RemoteFileService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteFileService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"upload\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"byte[]\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"annotations\":[],\"name\":\"selectUrlByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"anyhost\":\"true\",\"release\":\"3.1.11\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"dubbo\":\"2.0.2\",\"side\":\"provider\",\"pid\":\"31701\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756716150\"},\"types\":[{\"enums\":[],\"items\":[\"byte\"],\"properties\":{},\"type\":\"byte[]\"},{\"enums\":[],\"items\":[],\"properties\":{\"ossId\":\"java.lang.Long\",\"name\":\"java.lang.String\",\"url\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysFile\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"byte\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteFileService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        '465b08c7636d24a47b29d3ffde51acc9', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (126, 44, 'com.mikgeek.resource.api.RemoteMailService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteMailService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\"],\"parameters\":[],\"returnType\":\"void\"},{\"annotations\":[],\"name\":\"sendWithAttachment\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.lang.String\",\"java.util.List<java.io.File>\"],\"parameters\":[],\"returnType\":\"void\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"anyhost\":\"true\",\"release\":\"3.1.11\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"dubbo\":\"2.0.2\",\"side\":\"provider\",\"pid\":\"31701\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756716512\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"void\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"path\":\"java.lang.String\"},\"type\":\"java.io.File\"},{\"enums\":[],\"items\":[\"java.io.File\"],\"properties\":{},\"type\":\"java.util.List<java.io.File>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteMailService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'b4413f4fc1693ae4a7a4e69daf3c3bd4', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (128, 45, 'com.mikgeek.resource.api.RemoteSmsService:::provider:mikgeek-resource', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteSmsService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"send\",\"parameterTypes\":[\"java.lang.String\",\"java.lang.String\",\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"],\"parameters\":[],\"returnType\":\"com.mikgeek.resource.api.domain.SysSms\"}],\"parameters\":{\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"anyhost\":\"true\",\"release\":\"3.1.11\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"dubbo\":\"2.0.2\",\"side\":\"provider\",\"pid\":\"31701\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20880\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756716537\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"response\":\"java.lang.String\",\"message\":\"java.lang.String\",\"isSuccess\":\"java.lang.Boolean\"},\"type\":\"com.mikgeek.resource.api.domain.SysSms\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.LinkedHashMap<java.lang.String,java.lang.String>\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteSmsService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-resource/target/classes/\"}',
        'f031b053ca448f6c3125921a307c9188', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (132, 46, 'com.mikgeek.resource.api.RemoteDictService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.resource.api.RemoteDictService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDictDataByType\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"}],\"parameters\":{\"anyhost\":\"true\",\"release\":\"3.1.11\",\"side\":\"provider\",\"application\":\"mikgeek-system\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"metadata-type\":\"remote\",\"dubbo\":\"2.0.2\",\"pid\":\"31880\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756847646\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[\"com.mikgeek.resource.api.domain.SysDictData\"],\"properties\":{},\"type\":\"java.util.List<com.mikgeek.resource.api.domain.SysDictData>\"},{\"enums\":[],\"items\":[],\"properties\":{\"dictValue\":\"java.lang.String\",\"listClass\":\"java.lang.String\",\"dictSort\":\"java.lang.Integer\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"dictType\":\"java.lang.String\",\"dictLabel\":\"java.lang.String\",\"isDefault\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"cssClass\":\"java.lang.String\",\"dictCode\":\"java.lang.Long\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"com.mikgeek.resource.api.domain.SysDictData\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.resource.api.RemoteDictService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        'ca8118992c684d36784a88d495d8cc34', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (133, 47, 'com.mikgeek.member.api.RemoteDataScopeService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getRoleCustom\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getDeptAndChild\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"release\":\"3.1.11\",\"side\":\"provider\",\"application\":\"mikgeek-system\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"metadata-type\":\"remote\",\"dubbo\":\"2.0.2\",\"pid\":\"31880\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756848045\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDataScopeService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '3f87192e44ba3afea0a987f9c2bae5bb', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (135, 48, 'com.mikgeek.member.api.RemoteDeptService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteDeptService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"selectDeptNameByIds\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"java.lang.String\"}],\"parameters\":{\"anyhost\":\"true\",\"release\":\"3.1.11\",\"side\":\"provider\",\"application\":\"mikgeek-system\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"metadata-type\":\"remote\",\"dubbo\":\"2.0.2\",\"pid\":\"31880\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756848070\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteDeptService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '87b0677d15b347995c410664def9f3e0', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (137, 49, 'com.mikgeek.member.api.RemoteLogService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteLogService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"saveLog\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysOperLog\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"saveLogininfor\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysLogininfor\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"}],\"parameters\":{\"anyhost\":\"true\",\"release\":\"3.1.11\",\"side\":\"provider\",\"application\":\"mikgeek-system\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"metadata-type\":\"remote\",\"dubbo\":\"2.0.2\",\"pid\":\"31880\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756848085\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{\"msg\":\"java.lang.String\",\"infoId\":\"java.lang.Long\",\"loginTime\":\"java.util.Date\",\"os\":\"java.lang.String\",\"browser\":\"java.lang.String\",\"userName\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysLogininfor\"},{\"enums\":[],\"items\":[\"java.lang.Integer\"],\"properties\":{},\"type\":\"java.lang.Integer[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"method\":\"java.lang.String\",\"requestMethod\":\"java.lang.String\",\"operId\":\"java.lang.Long\",\"title\":\"java.lang.String\",\"businessTypes\":\"java.lang.Integer[]\",\"jsonResult\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"errorMsg\":\"java.lang.String\",\"operLocation\":\"java.lang.String\",\"operIp\":\"java.lang.String\",\"operUrl\":\"java.lang.String\",\"operName\":\"java.lang.String\",\"operatorType\":\"java.lang.Integer\",\"businessType\":\"java.lang.Integer\",\"operParam\":\"java.lang.String\",\"status\":\"java.lang.Integer\",\"operTime\":\"java.util.Date\"},\"type\":\"domain.com.mikgeek.member.api.SysOperLog\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteLogService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        '9241fe7ad970bf83f006572345a62321', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (140, 50, 'com.mikgeek.member.api.RemoteUserService:::provider:mikgeek-system', 'DUBBO_GROUP', '',
        '{\"annotations\":[],\"canonicalName\":\"com.mikgeek.member.api.RemoteUserService\",\"codeSource\":\"file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\",\"methods\":[{\"annotations\":[],\"name\":\"getUserInfoByPhonenumber\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByEmail\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"},{\"annotations\":[],\"name\":\"getUserInfoByOpenid\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.XcxLoginUser\"},{\"annotations\":[],\"name\":\"registerUserInfo\",\"parameterTypes\":[\"domain.com.mikgeek.member.api.SysUser\"],\"parameters\":[],\"returnType\":\"java.lang.Boolean\"},{\"annotations\":[],\"name\":\"selectUserNameById\",\"parameterTypes\":[\"java.lang.Long\"],\"parameters\":[],\"returnType\":\"java.lang.String\"},{\"annotations\":[],\"name\":\"getUserInfo\",\"parameterTypes\":[\"java.lang.String\"],\"parameters\":[],\"returnType\":\"model.com.mikgeek.member.api.LoginUser\"}],\"parameters\":{\"anyhost\":\"true\",\"release\":\"3.1.11\",\"side\":\"provider\",\"application\":\"mikgeek-system\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"metadata-type\":\"remote\",\"dubbo\":\"2.0.2\",\"pid\":\"31880\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"qos.enable\":\"false\",\"generic\":\"false\",\"bind.port\":\"20881\",\"bind.ip\":\"192.168.1.7\",\"background\":\"false\",\"ipv6\":\"240e:325:38:f300:98b3:ef73:ef1a:4\",\"dynamic\":\"true\",\"timestamp\":\"1710756848109\"},\"types\":[{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.List<T>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.util.Date\"},{\"enums\":[],\"items\":[],\"properties\":{\"flag\":\"boolean\",\"roleId\":\"java.lang.Long\",\"remark\":\"java.lang.String\",\"updateTime\":\"java.util.Date\",\"dataScope\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"roleSort\":\"java.lang.Integer\",\"deptCheckStrictly\":\"java.lang.Boolean\",\"createBy\":\"java.lang.String\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"menuCheckStrictly\":\"java.lang.Boolean\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"deptIds\":\"java.lang.Long[]\",\"menuIds\":\"java.lang.Long[]\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysRole\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"leader\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"orderNum\":\"java.lang.Integer\",\"updateTime\":\"java.util.Date\",\"delFlag\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"parentId\":\"java.lang.Long\",\"parentName\":\"java.lang.String\",\"createBy\":\"java.lang.String\",\"phone\":\"java.lang.String\",\"children\":\"java.util.List<T>\",\"createTime\":\"java.util.Date\",\"updateBy\":\"java.lang.String\",\"ancestors\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"email\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysDept\"},{\"enums\":[],\"items\":[\"java.lang.String\",\"java.lang.Object\"],\"properties\":{},\"type\":\"java.util.Map<java.lang.String,java.lang.Object>\"},{\"enums\":[],\"items\":[\"java.lang.String\"],\"properties\":{},\"type\":\"java.util.Set<java.lang.String>\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Integer\"},{\"enums\":[],\"items\":[\"java.lang.Long\"],\"properties\":{},\"type\":\"java.lang.Long[]\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roleId\":\"java.lang.Long\",\"roleName\":\"java.lang.String\",\"roleKey\":\"java.lang.String\",\"dataScope\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.RoleDTO\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Long\"},{\"enums\":[],\"items\":[\"model.com.mikgeek.member.api.RoleDTO\"],\"properties\":{},\"type\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\"},{\"enums\":[],\"items\":[\"domain.com.mikgeek.member.api.SysRole\"],\"properties\":{},\"type\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.LoginUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Boolean\"},{\"enums\":[],\"items\":[],\"properties\":{\"roles\":\"java.util.List<domain.com.mikgeek.member.api.SysRole>\",\"phonenumber\":\"java.lang.String\",\"loginDate\":\"java.util.Date\",\"remark\":\"java.lang.String\",\"delFlag\":\"java.lang.String\",\"password\":\"java.lang.String\",\"updateBy\":\"java.lang.String\",\"postIds\":\"java.lang.Long[]\",\"loginIp\":\"java.lang.String\",\"email\":\"java.lang.String\",\"nickName\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"sex\":\"java.lang.String\",\"deptId\":\"java.lang.Long\",\"updateTime\":\"java.util.Date\",\"avatar\":\"java.lang.String\",\"dept\":\"domain.com.mikgeek.member.api.SysDept\",\"userName\":\"java.lang.String\",\"params\":\"java.util.Map<java.lang.String,java.lang.Object>\",\"userId\":\"java.lang.Long\",\"createBy\":\"java.lang.String\",\"roleIds\":\"java.lang.Long[]\",\"createTime\":\"java.util.Date\",\"userType\":\"java.lang.String\",\"searchValue\":\"java.lang.String\",\"status\":\"java.lang.String\"},\"type\":\"domain.com.mikgeek.member.api.SysUser\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.Object\"},{\"enums\":[],\"items\":[],\"properties\":{},\"type\":\"java.lang.String\"},{\"enums\":[],\"items\":[],\"properties\":{\"deptName\":\"java.lang.String\",\"os\":\"java.lang.String\",\"openid\":\"java.lang.String\",\"roleId\":\"java.lang.Long\",\"roles\":\"java.util.List<model.com.mikgeek.member.api.RoleDTO>\",\"deptId\":\"java.lang.Long\",\"userId\":\"java.lang.Long\",\"token\":\"java.lang.String\",\"rolePermission\":\"java.util.Set<java.lang.String>\",\"password\":\"java.lang.String\",\"loginTime\":\"java.lang.Long\",\"expireTime\":\"java.lang.Long\",\"browser\":\"java.lang.String\",\"userType\":\"java.lang.String\",\"ipaddr\":\"java.lang.String\",\"loginLocation\":\"java.lang.String\",\"menuPermission\":\"java.util.Set<java.lang.String>\",\"username\":\"java.lang.String\"},\"type\":\"model.com.mikgeek.member.api.XcxLoginUser\"}],\"uniqueId\":\"com.mikgeek.member.api.RemoteUserService@file:/Users/chenkun/code/mikgeek/mikgeek/mikgeek-api/mikgeek-api-system/target/classes/\"}',
        'cfb6c27accfaa4b797523b71e65ea8cd', '2024-03-18 18:15:11', '2024-03-18 10:15:12', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (124, 51, 'com.mikgeek.resource.api.RemoteFileService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (127, 52, 'com.mikgeek.resource.api.RemoteMailService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (129, 53, 'com.mikgeek.resource.api.RemoteSmsService', 'mapping', '', 'mikgeek-resource',
        'e0e2f476cd304761b2787519804f7132', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (131, 54, 'com.mikgeek.resource.api.RemoteDictService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (134, 55, 'com.mikgeek.member.api.RemoteDataScopeService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (136, 56, 'com.mikgeek.member.api.RemoteDeptService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (138, 57, 'com.mikgeek.member.api.RemoteLogService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (139, 58, 'com.mikgeek.member.api.RemoteUserService', 'mapping', '', 'mikgeek-system',
        '413fa8a2090f0225526446518c3ac115', '2024-03-18 18:15:23', '2024-03-18 10:15:24', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (130, 59, 'mikgeek-resource', '9cd8f2e7653efce580709995bb1507c2', '',
        '{\"app\":\"mikgeek-resource\",\"revision\":\"9cd8f2e7653efce580709995bb1507c2\",\"services\":{\"com.mikgeek.resource.api.RemoteSmsService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteSmsService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteSmsService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteSmsService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteMailService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteMailService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"send,sendWithAttachment\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteMailService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteMailService\",\"port\":20880,\"protocol\":\"dubbo\"},\"com.mikgeek.resource.api.RemoteFileService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteFileService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectUrlByIds,upload\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteFileService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-resource\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteFileService\",\"port\":20880,\"protocol\":\"dubbo\"}}}',
        'f4c0228879fc5a9cdd8c5b5a300b5a7f', '2024-03-18 18:15:31', '2024-03-18 10:15:32', NULL, '127.0.0.1', 'D', 'dev',
        '');
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`,
                               `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`)
VALUES (141, 60, 'mikgeek-system', 'ebf35af3cd1a43b023c661980ee131d8', '',
        '{\"app\":\"mikgeek-system\",\"revision\":\"ebf35af3cd1a43b023c661980ee131d8\",\"services\":{\"com.mikgeek.resource.api.RemoteDictService:dubbo\":{\"name\":\"com.mikgeek.resource.api.RemoteDictService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDictDataByType\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.resource.api.RemoteDictService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.resource.api.RemoteDictService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDataScopeService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getDeptAndChild,getRoleCustom\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDataScopeService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteDeptService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteDeptService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"selectDeptNameByIds\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteDeptService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteDeptService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteUserService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteUserService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"getUserInfo,getUserInfoByEmail,getUserInfoByOpenid,getUserInfoByPhonenumber,registerUserInfo,selectUserNameById\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteUserService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteUserService\",\"port\":20881,\"protocol\":\"dubbo\"},\"com.mikgeek.member.api.RemoteLogService:dubbo\":{\"name\":\"com.mikgeek.member.api.RemoteLogService\",\"params\":{\"side\":\"provider\",\"release\":\"3.1.11\",\"methods\":\"saveLog,saveLogininfor\",\"logger\":\"slf4j\",\"deprecated\":\"false\",\"dubbo\":\"2.0.2\",\"interface\":\"com.mikgeek.member.api.RemoteLogService\",\"service-name-mapping\":\"true\",\"register-mode\":\"instance\",\"generic\":\"false\",\"metadata-type\":\"remote\",\"application\":\"mikgeek-system\",\"background\":\"false\",\"dynamic\":\"true\",\"anyhost\":\"true\"},\"path\":\"com.mikgeek.member.api.RemoteLogService\",\"port\":20881,\"protocol\":\"dubbo\"}}}',
        'bcf5e583aa3caf69d8d8151b19cef3a0', '2024-03-18 18:15:31', '2024-03-18 10:15:32', NULL, '127.0.0.1', 'D', 'dev',
        '');
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`
(
    `role`     varchar(50)  NOT NULL,
    `resource` varchar(255) NOT NULL,
    `action`   varchar(8)   NOT NULL,
    UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`
(
    `username` varchar(50) NOT NULL,
    `role`     varchar(50) NOT NULL,
    UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`username`, `role`)
VALUES ('nacos', 'ROLE_ADMIN');
COMMIT;

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`
(
    `id`                bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `tenant_id`         varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
    `quota`             int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage`             int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size`          int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    `max_aggr_count`    int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
    `max_aggr_size`     int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    `gmt_create`        datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`      datetime                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='租户容量信息表';

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`
(
    `id`            bigint                           NOT NULL AUTO_INCREMENT COMMENT 'id',
    `kp`            varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
    `tenant_id`     varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
    `tenant_name`   varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_name',
    `tenant_desc`   varchar(256) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tenant_desc',
    `create_source` varchar(32) COLLATE utf8mb3_bin  DEFAULT NULL COMMENT 'create_source',
    `gmt_create`    bigint                           NOT NULL COMMENT '创建时间',
    `gmt_modified`  bigint                           NOT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
    KEY             `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='tenant_info';

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
BEGIN;
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`,
                           `gmt_modified`)
VALUES (1, '1', 'dev', 'dev', '开发环境', NULL, 1641741261189, 1641741261189);
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`,
                           `gmt_modified`)
VALUES (2, '1', 'prod', 'prod', '生产环境', NULL, 1641741270448, 1641741287236);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`
(
    `username` varchar(50)  NOT NULL,
    `password` varchar(500) NOT NULL,
    `enabled`  tinyint(1) NOT NULL,
    PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`username`, `password`, `enabled`)
VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);
COMMIT;

SET
FOREIGN_KEY_CHECKS = 1;
