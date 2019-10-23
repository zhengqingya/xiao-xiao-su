package com.zhengqing;

import com.zhengqing.config.Constants;
import com.zhengqing.modules.system.entity.User;
import com.zhengqing.modules.system.mapper.UserMapper;
import com.zhengqing.utils.PasswordUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ApplicationTests {

    @Autowired
    UserMapper userMapper;

    @Test
    public void contextLoads() {
    }

    /**
     * 对密码加密
     *
     * @param :
     * @return: void
     */
    @Test
    public void test() throws Exception{
        List<User> users = userMapper.selectList(null);
        users.forEach( e -> {
            e.setPassword(PasswordUtils.encodePassword(e.getPassword(), Constants.SALT));
            e.setSalt(Constants.SALT);
            userMapper.updateById(e);
        });
    }

}
