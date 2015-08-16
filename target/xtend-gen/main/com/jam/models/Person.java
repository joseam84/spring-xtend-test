package com.jam.models;

import java.io.Serializable;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "person_type", discriminatorType = DiscriminatorType.STRING)
@Table(name = "person")
@SuppressWarnings("all")
public class Person implements Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Accessors
  private long id;
  
  @Accessors
  private String firstName;
  
  @Accessors
  private String lastName;
  
  @Accessors
  private String email;
  
  public Person() {
  }
  
  public Person(final String firstName, final String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
  
  @Override
  public String toString() {
    return String.format("Person[id=%d, firstName=\'%s\', lastName=\'%s\']", 
      Long.valueOf(this.id), this.firstName, this.lastName);
  }
  
  @Pure
  public long getId() {
    return this.id;
  }
  
  public void setId(final long id) {
    this.id = id;
  }
  
  @Pure
  public String getFirstName() {
    return this.firstName;
  }
  
  public void setFirstName(final String firstName) {
    this.firstName = firstName;
  }
  
  @Pure
  public String getLastName() {
    return this.lastName;
  }
  
  public void setLastName(final String lastName) {
    this.lastName = lastName;
  }
  
  @Pure
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(final String email) {
    this.email = email;
  }
}
