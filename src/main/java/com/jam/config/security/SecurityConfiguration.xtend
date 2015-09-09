package com.jam.config.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.core.annotation.Order
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity

@EnableWebSecurity
class SecurityConfiguration {
    @Autowired
    private AppUserDetailService userService;
    @Autowired
    def void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService)
    }
    @Configuration
    @Order(2)
    static class ViewsSecurityConfiguration extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests
                    .antMatchers("/", "/home","/webjars/**", "/h2-console/**").permitAll
                    .anyRequest.authenticated
                    .and
                .formLogin
                    .loginPage("/login").permitAll
                    .and
                .logout.permitAll
            http.csrf.disable
            http.headers.frameOptions.disable
        }
    } 
    @Configuration
    @Order(1)
    static class ApiWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http.csrf.disable
                .antMatcher("/api/**")
                .authorizeRequests()
                    .anyRequest().hasAnyRole("ADMIN", "API")
                    .and()
                .httpBasic();
        }
    }
    
// This configuration was problematic because the csrf protection is overshadowed by higher priority configurations.    
//    @Configuration
//    @Order(3)
//    /**
//     * The H2 configuration need to disable the frames and the csrf.
//     */
//    static class H2ConsoleSecurityConfiguration extends WebSecurityConfigurerAdapter {
//        override void configure(HttpSecurity http) throws Exception {
//            http.authorizeRequests.antMatchers("/h2-console/**").permitAll
//            http.csrf.disable
//            http.headers.frameOptions.disable
//                
//        }
//    }
    
}

