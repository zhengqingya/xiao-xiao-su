package com.zhengqing.modules.system.api.websocket;

import com.alibaba.fastjson.JSONObject;
import com.zhengqing.modules.system.dto.output.MsgVO;
import com.zhengqing.modules.system.entity.User;
import com.zhengqing.modules.system.mapper.UserMapper;
import com.zhengqing.utils.ApplicationContextUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * <p> websocket处理类Controller - 群聊 </p>
 *
 * @author : zhengqing
 * @description :
 * @date : 2019/12/4 9:20
 */
@Slf4j
@Component
@ServerEndpoint("/groupChat/{sid}/{userId}")
public class WebSocketServerController {

    /**
     * 房间号 -> 组成员信息
     */
    private static ConcurrentHashMap<String, List<Session>> groupMemberInfoMap = new ConcurrentHashMap<>();
    /**
     * 房间号 -> 在线人数
     */
    private static ConcurrentHashMap<String, Set<Integer>> onlineUserMap = new ConcurrentHashMap<>();

    /**
     * 收到消息调用的方法，群成员发送消息
     *
     * @param sid:房间号
     * @param userId：用户id
     * @param message：发送消息
     */
    @OnMessage
    public void onMessage(@PathParam("sid") String sid, @PathParam("userId") Integer userId, String message) {
        List<Session> sessionList = groupMemberInfoMap.get(sid);
        Set<Integer> onlineUserList = onlineUserMap.get(sid);
        // 先一个群组内的成员发送消息
        sessionList.forEach(item -> {
            try {
                // json字符串转对象
                MsgVO msg = JSONObject.parseObject(message, MsgVO.class);
                msg.setCount(onlineUserList.size());
                // json对象转字符串
                String text = JSONObject.toJSONString(msg);
                item.getBasicRemote().sendText(text);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

    /**
     * 建立连接调用的方法，群成员加入
     *
     * @param session
     * @param sid
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("sid") String sid, @PathParam("userId") Integer userId) {
        List<Session> sessionList = groupMemberInfoMap.computeIfAbsent(sid, k -> new ArrayList<>());
        Set<Integer> onlineUserList = onlineUserMap.computeIfAbsent(sid, k -> new HashSet<>());
        onlineUserList.add(userId);
        sessionList.add(session);

        // 发送上线通知
        sendInfo(sid, userId, onlineUserList.size(), "上线了~");

        log.info("Connection connected");
        log.info("sid: {}, sessionList size: {}", sid, sessionList.size());
    }


    public void sendInfo(String sid, Integer userId, Integer onlineSum, String info) {
        // 获取该连接用户信息
        User currentUser = ApplicationContextUtil.getApplicationContext().getBean(UserMapper.class).selectById(userId);
        // 发送通知
        MsgVO msg = new MsgVO();
        msg.setCount(onlineSum);
        msg.setUserId(userId);
        msg.setAvatar(currentUser.getAvatar());
        msg.setMsg(currentUser.getNickName() + info);
        // json对象转字符串
        String text = JSONObject.toJSONString(msg);
        onMessage(sid, userId, text);
    }

    /**
     * 关闭连接调用的方法，群成员退出
     *
     * @param session
     * @param sid
     */
    @OnClose
    public void onClose(Session session, @PathParam("sid") String sid, @PathParam("userId") Integer userId) {
        List<Session> sessionList = groupMemberInfoMap.get(sid);
        sessionList.remove(session);
        Set<Integer> onlineUserList = onlineUserMap.get(sid);
        onlineUserList.remove(userId);

        // 发送离线通知
        sendInfo(sid, userId, onlineUserList.size(), "下线了~");

        log.info("Connection closed");
        log.info("sid: {}, sessionList size: {}", sid, sessionList.size());
    }

    /**
     * 传输消息错误调用的方法
     *
     * @param error
     */
    @OnError
    public void OnError(Throwable error) {
        log.info("Connection error");
    }
}
