# mikgeek-member

1. 全局用户保存在此模块中，接口需要鉴权的在接口上使用`@SaCheckPermission`
2. 后台管理的接口需要全部使用`@SaCheckPermission`
3. controller 中分 admin 和 api 两个包， admin为管理系统使用， api 为对外接口使用， admin中必须全部使用`@SaCheckPermission`
   标识