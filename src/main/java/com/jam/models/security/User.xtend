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

interface UserRepository extends CrudRepository<User, String>{
    def User findByUsername(String username)
}