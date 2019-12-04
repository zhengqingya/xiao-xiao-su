package com.zhengqing.modules.system.dto.output;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 *  <p>  websocket消息内容 </p>
 *
 * @author：  zhengqing <br/>
 * @date：  2019/12/4$ 10:27$ <br/>
 * @version：  <br/>
 */
@Data
@ApiModel(description = "websocket消息内容")
public class MsgVO {

    @ApiModelProperty(value = "用户id")
    private Integer userId;

    @ApiModelProperty(value = "用户名")
    private String username;

    @ApiModelProperty(value = "用户头像")
    private String avatar;

    @ApiModelProperty(value = "消息")
    private String msg;

    @ApiModelProperty(value = "在线人数")
    private int count;

}
