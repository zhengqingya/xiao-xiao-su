package com.zhengqing.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zhengqing.modules.common.dto.output.ApiResult;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *  <p> 使用response输出JSON </p>
 *
 * @description :
 * @author : zhengqing
 * @date : 2019/10/11 17:27
 */
@Slf4j
public class ResponseUtils {

    /**
     * 使用response输出JSON
     *
     * @param response
     * @param result
     */
    public static void out(ServletResponse response, ApiResult result) {
        PrintWriter out = null;
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            out = response.getWriter();
            out.println(JSON.toJSONString(result));
        } catch (Exception e) {
            log.error(e + "输出JSON出错");
        } finally {
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }

    /**
     * 响应内容
     * @param httpServletResponse
     * @param msg
     * @param status
     */
    public static void getResponse(HttpServletResponse httpServletResponse, String msg, Integer status){
        PrintWriter writer = null;
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setContentType("application/json; charset=utf-8");
        try {
            writer = httpServletResponse.getWriter();
            writer.print(JSONObject.toJSONString(new ApiResult(status,msg,null)));
        } catch (IOException e) {
            log.error("响应报错", e.getMessage());
        } finally {
            if (writer != null){
                writer.close();
            }
        }
    }

}
