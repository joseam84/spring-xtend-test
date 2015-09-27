package com.jam.config.auditing;

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.domain.AuditorAware
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import org.springframework.data.jpa.repository.config.EnableJpaAuditing
import org.springframework.security.core.context.SecurityContextHolder

@EnableJpaAuditing
@Configuration
public class AuditingConfig {

    @Bean
    def AuditorAware<String> createAuditorProvider() {
        new SecurityAuditor()
    }

    @Bean
    def AuditingEntityListener createAuditingListener() {
        new AuditingEntityListener()
    }

    static class SecurityAuditor implements AuditorAware<String> {
        override String getCurrentAuditor() {
            var auth = SecurityContextHolder.getContext().getAuthentication()
            return auth.name
        }
        
        
    }
}