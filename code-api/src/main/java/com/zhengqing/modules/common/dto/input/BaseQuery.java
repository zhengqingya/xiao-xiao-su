package com.zhengqing.modules.common.dto.input;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 *  <p> 基类查询参数 </p>
 *
 * @description:
 * @author: zhengqing
 * @date: 2019/9/13 0013 1:57
 */
@ApiModel(description = "基类查询参数")
@Data
public class BaseQuery extends BasePageQuery{
    @ApiModelProperty(value = "用户ID")
    private Integer userId;
}
