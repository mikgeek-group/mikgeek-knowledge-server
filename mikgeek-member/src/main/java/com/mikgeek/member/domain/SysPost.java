package com.mikgeek.member.domain;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.mikgeek.common.core.web.domain.BaseEntity;
import com.mikgeek.common.excel.annotation.ExcelDictFormat;
import com.mikgeek.common.excel.convert.ExcelDictConvert;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * 岗位表 sys_post
 *
 * @author Lion Li
 */

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@TableName("sys_post")
@ExcelIgnoreUnannotated
public class SysPost extends BaseEntity {


    /**
     * 岗位编码
     */
    @ExcelProperty(value = "岗位编码")
    @NotBlank(message = "岗位编码不能为空")
    @Size(min = 0, max = 64, message = "岗位编码长度不能超过64个字符")
    private String code;

    /**
     * 岗位名称
     */
    @ExcelProperty(value = "岗位名称")
    @NotBlank(message = "岗位名称不能为空")
    @Size(min = 0, max = 50, message = "岗位名称长度不能超过50个字符")
    private String name;

    /**
     * 岗位排序
     */
    @ExcelProperty(value = "岗位排序")
    @NotNull(message = "显示顺序不能为空")
    private Integer sort;

    /**
     * 状态（0正常 1停用）
     */
    @ExcelProperty(value = "状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "sys_normal_disable")
    private String status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 用户是否存在此岗位标识 默认不存在
     */
    @TableField(exist = false)
    private boolean flag = false;

}
