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
import com.jam.models.security.User

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name="person_type", discriminatorType=DiscriminatorType.STRING)
@Table(name ="person")
@ToString
@Accessors
class Person implements Serializable {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private long id
    private String firstName
    private String lastName
    private String email
    @OneToOne(cascade = CascadeType.ALL) 
    @JoinColumn(name="USER_ID") 
    private User userCredentials
    @OneToOne(cascade = CascadeType.ALL) 
    @JoinColumn(name="ADDRESS_ID") 
    private Address address;
    new(){}
    new(String firstName, String lastName) {
        this.firstName = firstName
        this.lastName = lastName
    }
}
@Accessors
class PersonDTO{
    var long id                    
    var String firstName           
    var String lastName            
    var String email                  
    var AddressDTO address
    new(){}
}
interface PersonRepository extends CrudRepository<Person, Long> {
    def List<Person> findByLastName(String lastName)
    def List<Person> findByUserCredentialsUsername(String username)
}
@Service
class PersonService implements BaseService<PersonDTO, Person, Long>{
    
    @Autowired PersonRepository personRepo
    override create(PersonDTO persondata) {
        personRepo.save(new Person() =>[
        	firstName = persondata.firstName
        	lastName = persondata.lastName
        	email = persondata.email
        	address = persondata.address.toEntity?:address
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
    def findByUsername(String username) {
       Optional.ofNullable(personRepo.findByUserCredentialsUsername(username))
    }
    override update(PersonDTO person) {
        var persisted = findById(person.id).orElseThrow
            [new PersonNotFoundException(person.id)]
        
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