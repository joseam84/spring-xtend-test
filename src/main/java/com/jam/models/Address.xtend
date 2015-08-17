package com.jam.models

import javax.persistence.Entity
import javax.persistence.Table
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import java.util.List
import org.springframework.data.repository.CrudRepository
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.ToString

@Entity
@Table(name ="address")
@ToString
class Address {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Accessors private String id
    @Accessors private String addressLine1
    @Accessors private String addressLine2
    @Accessors private String city
    @Accessors private String state
    @Accessors private String zipCode
    @Accessors private String country 
    new(){}
    new(String addressLine1,String  addressLine2, String city, 
        String state, String zipCode, String country){
        this.addressLine1 = addressLine1
        this.addressLine2 = addressLine2
        this.city = city
        this.state = state
        this.zipCode = zipCode
        this.country = country
    }
}

interface AddressRepository extends CrudRepository<Address,Long>{
    def List<Person> findByZipCode(String zipCode)
}