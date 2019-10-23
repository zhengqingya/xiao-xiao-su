package com.zhengqing.config.security;

import com.zhengqing.config.MyProperties;
import com.zhengqing.config.security.filter.AdminAuthenticationProcessingFilter;
import com.zhengqing.config.security.filter.MyAuthenticationFilter;
import com.zhengqing.config.security.login.AdminAuthenticationEntryPoint;
import com.zhengqing.config.security.url.UrlAccessDecisionManager;
import com.zhengqing.config.security.url.UrlAccessDeniedHandler;
import com.zhengqing.config.security.url.UrlFilterInvocationSecurityMetadataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

/**
 *  <p> Security 核心配置类 </p>
 *
 * @author：  zhengqing <br/>
 * @date：  2019/9/30$ 10:58$ <br/>
 * @version：  <br/>
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    MyProperties myProperties;

    /**
     * 访问鉴权 - 认证token、签名...
     */
    private final MyAuthenticationFilter myAuthenticationFilter;
    /**
     * 访问权限认证异常处理
     */
    private final AdminAuthenticationEntryPoint adminAuthenticationEntryPoint;
    /**
     * 用户密码校验过滤器
     */
    private final AdminAuthenticationProcessingFilter adminAuthenticationProcessingFilter;

    // 上面是登录认证相关  下面为url权限相关 - ========================================================================================

    /**
     * 获取访问url所需要的角色信息
     */
    private final UrlFilterInvocationSecurityMetadataSource urlFilterInvocationSecurityMetadataSource;
    /**
     * 认证权限处理 - 将上面所获得角色权限与当前登录用户的角色做对比，如果包含其中一个角色即可正常访问
     */
    private final UrlAccessDecisionManager urlAccessDecisionManager;
    /**
     * 自定义访问无权限接口时403响应内容
     */
    private final UrlAccessDeniedHandler urlAccessDeniedHandler;

    public SecurityConfig(MyAuthenticationFilter myAuthenticationFilter, AdminAuthenticationEntryPoint adminAuthenticationEntryPoint, AdminAuthenticationProcessingFilter adminAuthenticationProcessingFilter, UrlFilterInvocationSecurityMetadataSource urlFilterInvocationSecurityMetadataSource, UrlAccessDeniedHandler urlAccessDeniedHandler, UrlAccessDecisionManager urlAccessDecisionManager) {
        this.myAuthenticationFilter = myAuthenticationFilter;
        this.adminAuthenticationEntryPoint = adminAuthenticationEntryPoint;
        this.adminAuthenticationProcessingFilter = adminAuthenticationProcessingFilter;
        this.urlFilterInvocationSecurityMetadataSource = urlFilterInvocationSecurityMetadataSource;
        this.urlAccessDeniedHandler = urlAccessDeniedHandler;
        this.urlAccessDecisionManager = urlAccessDecisionManager;
    }


    /**
     * 权限配置
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry = http.antMatcher("/**").authorizeRequests();

        // 禁用CSRF 开启跨域
        http.csrf().disable().cors();

        // 未登录认证异常
        http.exceptionHandling().authenticationEntryPoint(adminAuthenticationEntryPoint);
        // 登录过后访问无权限的接口时自定义403响应内容
        http.exceptionHandling().accessDeniedHandler(urlAccessDeniedHandler);

        // url权限认证处理
        registry.withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
            @Override
            public <O extends FilterSecurityInterceptor> O postProcess(O o) {
                o.setSecurityMetadataSource(urlFilterInvocationSecurityMetadataSource);
                o.setAccessDecisionManager(urlAccessDecisionManager);
                return o;
            }
        });

        // 不创建会话 - 即通过前端传token到后台过滤器中验证是否存在访问权限
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        // 登录处理 - 前后端一体的情况下
//        registry.and().formLogin().loginPage("/login").defaultSuccessUrl("/").permitAll()
//                // 自定义登陆用户名和密码属性名，默认为 username和password
//                .usernameParameter("username").passwordParameter("password")
//                // 异常处理
//                .failureUrl("/login/error").permitAll()
//                // 退出登录
//                .and().logout().permitAll();

        // 标识访问 `/home` 这个接口，需要具备`ADMIN`角色
//        registry.antMatchers("/home").hasRole("ADMIN");
        // 标识只能在 服务器本地ip[127.0.0.1或localhost] 访问 `/home` 这个接口，其他ip地址无法访问
        registry.antMatchers("/home").hasIpAddress("127.0.0.1");

        // 允许匿名的url - 可理解为放行接口 - 除配置文件忽略url以外，其它所有请求都需经过认证和授权
        for (String url : myProperties.getAuth().getIgnoreUrls()) {
            registry.antMatchers(url).permitAll();
        }
//        registry.antMatchers("/**").access("hasAuthority('admin')");
        // OPTIONS(选项)：查找适用于一个特定网址资源的通讯选择。 在不需执行具体的涉及数据传输的动作情况下， 允许客户端来确定与资源相关的选项以及 / 或者要求， 或是一个服务器的性能
        registry.antMatchers(HttpMethod.OPTIONS, "/**").denyAll();
        // 自动登录 - cookie储存方式
        registry.and().rememberMe();
        // 其余所有请求都需要认证
        registry.anyRequest().authenticated();
        // 防止iframe 造成跨域
        registry.and().headers().frameOptions().disable();

        // 自定义过滤器在登录时认证用户名、密码
        http.addFilterAt(adminAuthenticationProcessingFilter, UsernamePasswordAuthenticationFilter.class)
            .addFilterBefore(myAuthenticationFilter, BasicAuthenticationFilter.class);
    }

    /**
     * 忽略拦截url或静态资源文件夹 - web.ignoring(): 会直接过滤该url - 将不会经过Spring Security过滤器链
     *                             http.permitAll(): 不会绕开springsecurity验证，相当于是允许该路径通过
     * @param web
     * @throws Exception
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers(HttpMethod.GET,
                "/favicon.ico",
                "/**/*.png",
                "/**/*.ttf",
                "/*.html",
                "/**/*.css",
                "/**/*.js");
    }

}

