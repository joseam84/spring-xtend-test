package com.jam.models;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "person")
@SuppressWarnings("all")
public class Person implements Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long id;
  
  private String firstName;
  
  private String lastName;
  
  protected Person() {
  }
  
  public Person(final String firstName, final String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
  
  @Override
  public String toString() {
    return String.format(
      "Customer[id=%d, firstName=\'%s\', lastName=\'%s\']", 
      Long.valueOf(this.id), this.firstName, this.lastName);
  }
}
