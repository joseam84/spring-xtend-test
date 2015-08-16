package com.jam.models
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable
import javax.persistence.Table

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorColumn
import java.util.List
import org.springframework.data.repository.CrudRepository

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name="person_type", discriminatorType=DiscriminatorType.STRING)
@Table(name ="person")
class Person implements Serializable {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Accessors private long id;
    @Accessors private String firstName;
    @Accessors private String lastName;
    @Accessors private String email;
    new(){}
    new(String firstName, String lastName){
        this.firstName = firstName
        this.lastName = lastName
    }
    override String toString() {
        String.format("Person[id=%d, firstName='%s', lastName='%s']",
                id, firstName, lastName)
    }
}

interface PersonRepository extends CrudRepository<Person, Long> {
    def List<Person> findByLastName(String lastName)
}