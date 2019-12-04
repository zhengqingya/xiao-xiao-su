package com.zhengqing;

import com.zhengqing.config.MyProperties;
import com.zhengqing.utils.ApplicationContextUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableConfigurationProperties({MyProperties.class})
@EnableTransactionManagement
@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        ApplicationContext app = SpringApplication.run(Application.class, args);
        ApplicationContextUtil.setApplicationContext(app);
    }

}
