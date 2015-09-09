package com.jam.config.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.autoconfigure.security.SecurityProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.Ordered
import org.springframework.core.annotation.Order
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter

@Configuration
class SecurityConfiguration {

    @Bean
    def WebSecurityConfigurerAdapter apiWebSecurityConfiguration() {
        return new ApiWebSecurityConfiguration()
    }

    @Bean
    def WebSecurityConfigurerAdapter viewsSecurityConfiguration() {
        return new ViewsSecurityConfiguration()
    }
    
    @Configuration
    @Order(Ordered.HIGHEST_PRECEDENCE)
    protected static class AuthenticationManagerConfig extends
            GlobalAuthenticationConfigurerAdapter {

        @Autowired
        private AppUserDetailService userService;

        def override init(AuthenticationManagerBuilder auth) throws Exception {
            auth.userDetailsService(userService);
        }
    }

    @Order(SecurityProperties.ACCESS_OVERRIDE_ORDER - 1)
    private static class ApiWebSecurityConfiguration extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            val api = http.antMatcher("/api/**")
            api.csrf.disable
            api.httpBasic
            http.authorizeRequests().anyRequest().hasAnyRole("ADMIN", "API")

        }
    }

    @Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
    private static class ViewsSecurityConfiguration extends WebSecurityConfigurerAdapter {
        override void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests
                    .antMatchers("/", "/home","/webjars/**").permitAll
                    .anyRequest.authenticated
                    .and
                .formLogin
                    .loginPage("/login").permitAll
                    .and
                .logout.permitAll
        }
    } 
}
	