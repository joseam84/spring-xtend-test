package com.jam.models
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable
import javax.persistence.Table

@Entity
@Table(name ="person")
class Person implements Serializable {
	@Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private long id;
    private String firstName;
    private String lastName;

    protected new() {}

    new(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    override String toString() {
        return String.format(
                "Customer[id=%d, firstName='%s', lastName='%s']",
                id, firstName, lastName);
    }
	
}