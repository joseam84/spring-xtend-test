package com.jam.models

import java.io.Serializable
import java.util.List
import java.util.Optional
import javax.persistence.CascadeType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.JoinColumn
import javax.persistence.OneToOne
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.ToString
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Service

import static extension com.jam.models.AddressExtensions.*

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name="person_type", discriminatorType=DiscriminatorType.STRING)
@Table(name ="person")
@ToString
class Person implements Serializable {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Accessors private long id;
    @Accessors private String firstName;
    @Accessors private String lastName;
    @Accessors private String email;
    @OneToOne(cascade = CascadeType.ALL) 
    @JoinColumn(name="ADDRESS_ID") 
    @Accessors private Address address;
    new(){}
    new(String firstName, String lastName) {
        this.firstName = firstName
        this.lastName = lastName
    }
}

class PersonDTO{
   @Accessors var long id                    
   @Accessors var String firstName           
   @Accessors var String lastName            
   @Accessors var String email                  
   @Accessors var AddressDTO address
   new(){}
}
interface PersonRepository extends CrudRepository<Person, Long> {
    def List<Person> findByLastName(String lastName)
}
@Service
class PersonService implements BaseService<PersonDTO,Person>{
    
    @Autowired PersonRepository personRepo
    override create(PersonDTO persondata) {
        personRepo.save(new Person() =>[
        	firstName = persondata.firstName
        	lastName = persondata.lastName
        	email = persondata.email
        	address = persondata.address.toEntity
        ])
    }
    override delete(Long id) {
        var toDelete = personRepo.findOne(id)
        personRepo.delete(id)
        toDelete
    }
    override findAll() {
        personRepo.findAll().toList
    }
    override findById(Long id) {
       Optional.ofNullable(personRepo.findOne(id))
    }
    override update(PersonDTO person) {
        var persisted = findById(person.id).orElseThrow
            [new Exception("Person id "+person.id + "not found")]
        
        persisted.firstName = person.firstName
        persisted.lastName = person.lastName
        persisted.email = person.email
        persisted.address = person.address.toEntity
        return persisted
    }
}

class PersonExtension{
    def static Person toEntity(PersonDTO person){
        new Person() => [id = person.id
        	             firstName = person.firstName 
        	             lastName = person.lastName
        	             email = person.email
        	             address = person.address.toEntity]
    }
    def static PersonDTO toDTO(Person person){
    	new PersonDTO => [id = person.id
    		              firstName = person.firstName lastName = person.lastName 
    		              email = person.email
    		              address =	person.address.toDTO]
    }   
}    

class PersonNotFoundException extends Exception{
    new(Long id) {
        super("Person id " + id + " not found.")
    }
}