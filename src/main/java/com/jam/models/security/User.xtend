package com.jam.models.security

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table
import javax.validation.constraints.NotNull
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.data.repository.CrudRepository
import javax.persistence.OneToMany
import java.util.List
import com.jam.models.BaseService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.userdetails.UsernameNotFoundException
import java.util.Optional
import org.springframework.stereotype.Service

/**
 * User contains the information necessary for Spring Security to determine credentials
 */
@Entity
@Table(name ="users")
@Accessors
class User implements UserDetails{
    @Id @NotNull @Column(unique=true) var String username
    @NotNull var String password
    @NotNull var boolean enabled
    @OneToMany(fetch = EAGER,targetEntity=Authority, cascade=ALL, mappedBy="user") var List<Authority> authorities
    new(){}
    new(String username, String password, boolean enabled) {
        this.username = username
        this.password = password
        this.enabled = enabled
    }
    
    override isAccountNonExpired() {
        true
    }
    
    override isAccountNonLocked() {
        true
    }
    
    override isCredentialsNonExpired() {
        true
    }
    
}

@Accessors
class UserDTO{
    var String username
    var String password
}

@Service
class UserService implements BaseService<UserDTO, User, String>{
    @Autowired UserRepository userRepo
    override create(UserDTO person) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub")
    }
    
    override delete(Long id) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub")
    }
    
    override findAll() {
        throw new UnsupportedOperationException("TODO: auto-generated method stub")
    }
    
    override findById(String username) {
         Optional.ofNullable(userRepo.findByUsername(username))
    }
    
    override update(UserDTO todo) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub")
    }
    
}

interface UserRepository extends CrudRepository<User, String>{
    def User findByUsername(String username)
}

class UserNotFoundException extends Exception{
    new(String id) {
        super("User with username " + id + " not found.")
    }
}