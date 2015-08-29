package com.jam.config.security

import com.jam.models.security.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service
/**
 * This service will fetch the correct user for Spring in order to get the credentials for it.
 */
@Service
class AppUserDetailService implements UserDetailsService {
    @Autowired UserRepository userRepo
    override loadUserByUsername(String username)  {
        userRepo.findByUsername(username)
    }
    
}