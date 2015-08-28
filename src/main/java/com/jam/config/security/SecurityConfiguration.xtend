package com.jam.config.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.core.annotation.Order
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter

@Configuration
class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    
    @Autowired
    def void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth
            .inMemoryAuthentication()
                .withUser("user").password("password").roles("","ADMIN","API");
    }
    @Configuration
    @Order(1)
    static class ApiWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http
                .csrf.disable
                .antMatcher("/api/**")
                .authorizeRequests()
                    .anyRequest().hasAnyRole("ADMIN", "API")
                    .and()
                .httpBasic();
        }
    }
    @Configuration
    @Order(2)
    /**
     * The H2 configuration need to disable the frames and the csrf.
     */
    static class H2ConsoleSecurityConfiguration extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http
                .csrf.disable
                .authorizeRequests
                .antMatchers("/h2-console/**").permitAll
                .and
                .headers.frameOptions.disable   
        }
    }
    @Configuration
    @Order(3)
    static class ViewsSecurityConfiguration extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests
                    .antMatchers("/", "/home").permitAll
                    .anyRequest.authenticated
                    .and
                .formLogin
                    .loginPage("/login").permitAll
                    .and
                .logout.permitAll    
        }
    }
}

