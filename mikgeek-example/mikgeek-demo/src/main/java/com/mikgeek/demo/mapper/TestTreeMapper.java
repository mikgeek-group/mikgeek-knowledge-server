package com.mikgeek.demo.mapper;

import com.mikgeek.common.mybatis.annotation.DataColumn;
import com.mikgeek.common.mybatis.annotation.DataPermission;
import com.mikgeek.common.mybatis.core.mapper.BaseMapperPlus;
import com.mikgeek.demo.domain.TestTree;
import com.mikgeek.demo.domain.vo.TestTreeVo;

/**
 * 测试树表Mapper接口
 *
 * @author Lion Li
 * @date 2021-07-26
 */
@DataPermission({
    @DataColumn(key = "deptName", value = "dept_id"),
    @DataColumn(key = "userName", value = "user_id")
})
public interface TestTreeMapper extends BaseMapperPlus<TestTreeMapper, TestTree, TestTreeVo> {

}
