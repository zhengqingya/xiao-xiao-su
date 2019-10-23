package com.zhengqing.utils;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.*;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * <p> 多次读写BODY用HTTP REQUEST - 解决流只能读一次问题 </p>
 *
 * @author : zhengqing
 * @description :
 * @date : 2019/10/12 15:42
 */
@Slf4j
public class MultiReadHttpServletRequest extends HttpServletRequestWrapper {

    private final byte[] body;

    public MultiReadHttpServletRequest(HttpServletRequest request) throws IOException {
        super(request);
        body = getBodyString(request).getBytes(Charset.forName("UTF-8"));
    }

    @Override
    public BufferedReader getReader() throws IOException {
        return new BufferedReader(new InputStreamReader(getInputStream()));
    }

    @Override
    public ServletInputStream getInputStream() throws IOException {

        final ByteArrayInputStream bais = new ByteArrayInputStream(body);

        return new ServletInputStream() {

            @Override
            public int read() throws IOException {
                return bais.read();
            }

            @Override
            public boolean isFinished() {
                return false;
            }

            @Override
            public boolean isReady() {
                return false;
            }

            @Override
            public void setReadListener(ReadListener readListener) {

            }
        };
    }

    /**
     * 获取请求Body
     *
     * @param request
     * @return
     */
    private String getBodyString(ServletRequest request) {
        StringBuilder sb = new StringBuilder();
        InputStream inputStream = null;
        BufferedReader reader = null;
        try {
            inputStream = request.getInputStream();
            reader = new BufferedReader(new InputStreamReader(inputStream, Charset.forName("UTF-8")));
            String line = "";
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }

    /**
     * 将前端请求的表单数据转换成json字符串 - 前后端一体的情况下使用
     * @param request:
     * @return: java.lang.String
     */
    public String getBodyJsonStrByForm(ServletRequest request){
        Map<String, Object> bodyMap = new HashMap<>(16);
        try {
            // 参数定义
            String paraName = null;
            // 获取请求参数并转换
            Enumeration<String> e = request.getParameterNames();
            while (e.hasMoreElements()) {
                paraName = e.nextElement();
                bodyMap.put(paraName, request.getParameter(paraName));
            }
        } catch(Exception e) {
            log.error("请求参数转换错误!",e);
        }
        // json对象转json字符串 转javabean
//        SecurityUser user = JSONObject.parseObject(JSONObject.toJSONString(bodyMap), SecurityUser.class);
        // json对象转json字符串
        return JSONObject.toJSONString(bodyMap);
    }

    /**
     * 将前端传递的json数据转换成json字符串 - 前后端分离的情况下使用
     * @param request:
     * @return: java.lang.String
     */
    public String getBodyJsonStrByJson(ServletRequest request){
//        StringBuilder requestStrBuilder = new StringBuilder();
//        try {
//            BufferedReader streamReader = new MultiReadHttpServletRequest(request).getReader();
//            String inputStr;
//            while ((inputStr = streamReader.readLine()) != null) {
//                requestStrBuilder.append(inputStr);
//            }
//            // 将json字符串转化为jsonbean对象
////            User user = JSON.parseObject(requestStrBuilder.toString(), User.class);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return requestStrBuilder.toString();
        StringBuffer json = new StringBuffer();
        String line = null;
        try {
            BufferedReader reader = request.getReader();
            while((line = reader.readLine()) != null) {
                json.append(line);
            }
        }
        catch(Exception e) {
            log.error("请求参数转换错误!",e);
        }
        return json.toString();
    }

}
