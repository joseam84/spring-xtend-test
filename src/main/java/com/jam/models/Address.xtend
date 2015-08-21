package com.jam.models

import java.util.List
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.ToString
import org.springframework.data.repository.CrudRepository

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

class AddressDTO{
   @Accessors String id
   @Accessors String addressLine1
   @Accessors String addressLine2
   @Accessors String city
   @Accessors String state
   @Accessors String zipCode
   @Accessors String country 
   new(){}
    
}
/**
 * Extension classes for address
 */
class AddressExtensions{
    def static Address toEntity(AddressDTO aDto){
        new Address() => [
            id = aDto.id
            addressLine1 = aDto.addressLine1
            addressLine2 = aDto.addressLine2
            city = aDto.city
            state = aDto.state
            zipCode = aDto.zipCode
            country = aDto.country
        ]
    }
    def static AddressDTO toDTO(Address address){
        new AddressDTO => [id = address.id 
                           addressLine1 = address.addressLine1 
                           addressLine2 = address.addressLine2
                           city = address.city
                           state = address.state
                           zipCode = address.zipCode
                           country = address.country]
    }
}

interface AddressRepository extends CrudRepository<Address,Long>{
    def List<Person> findByZipCode(String zipCode)
}