package com.jam.models

import com.jam.models.Person
import org.springframework.data.repository.CrudRepository
import java.util.List
import javax.persistence.Entity
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.DiscriminatorValue

@Entity
@Table(name ="employee")
@DiscriminatorValue("employee")
class Employee extends Person {
    @Accessors private String employeeNumber
    new(){}
    new(String firstName, String lastName) {
        super(firstName, lastName)
    }
    override String toString(){
        String.format("Person[id=%d, firstName='%s', lastName='%s']",
                id, firstName, lastName)
    }
}

interface EmployeeRepository extends CrudRepository<Employee, Long> {
    def List<Employee> findByLastName(String lastName)
}