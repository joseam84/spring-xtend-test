package com.jam.models.security

import javax.persistence.Entity
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.security.core.GrantedAuthority
import javax.validation.constraints.NotNull
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.ManyToOne

@Entity
@Table(name="authorities")
@Accessors          
class Authority implements GrantedAuthority {
    @Id @GeneratedValue var Long id
    /**
     * This authority is essetially the role Spring Security will use to authorize the user.
     * It must conform the <em> ROLE_*prefix*</em> nomenclature.
     */
    @NotNull var String authority 
    @ManyToOne(cascade=ALL) var User user
       
}