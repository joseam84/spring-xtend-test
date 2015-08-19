package com.jam.models

import com.jam.models.Person
import org.springframework.data.repository.CrudRepository
import java.util.List
import javax.persistence.Entity
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.DiscriminatorValue
import org.eclipse.xtend.lib.annotations.ToString
import static extension com.jam.models.AddressExtensions.*
import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Autowired
import java.util.Optional

@Entity
@Table(name ="employee")
@DiscriminatorValue("employee")
@ToString
class Employee extends Person {
    @Accessors private String employeeNumber
    new(){}
    new(String firstName, String lastName) {
        super(firstName, lastName)
    }
}

class EmployeeDTO extends PersonDTO{
    @Accessors var String employeeNumber
    new(){}
}

class EmployeeExtension{
    def static Employee toEntity(EmployeeDTO employee){
        new Employee => [id = employee.id
                         firstName = employee.firstName 
                         lastName = employee.lastName
                         email = employee.email
                         employeeNumber = employee.employeeNumber
                         address = employee.address.toEntity]
    }
    def static EmployeeDTO toDTO(Employee person){
        new EmployeeDTO => [id = person.id
                          firstName = person.firstName
                          lastName = person.lastName 
                          email = person.email
                          address = person.address.toDTO]
    }   
} 
interface EmployeeRepository extends CrudRepository<Employee, Long> {
    def List<Employee> findByLastName(String lastName)
}

@Service
class EmployeeService implements BaseService<EmployeeDTO, Employee>{
    
    @Autowired EmployeeRepository employeeRepo
    override create(EmployeeDTO employeeData) {
        employeeRepo.save(new Employee() =>[
            firstName = employeeData.firstName
            lastName = employeeData.lastName
            email = employeeData.email
            address = employeeData.address.toEntity
        ])
    }
    override delete(Long id) {
        var toDelete = employeeRepo.findOne(id)
        employeeRepo.delete(id)
        toDelete
    }
    override findAll() {
        employeeRepo.findAll().toList
    }
    override findById(Long id) {
       Optional.ofNullable(employeeRepo.findOne(id))
    }
    override update(EmployeeDTO person) {
        var persisted = findById(person.id).orElseThrow
            [new Exception("Person id "+person.id + "not found")]
        
        persisted.firstName = person.firstName
        persisted.lastName = person.lastName
        persisted.email = person.email
        persisted.address = person.address.toEntity
        return persisted
    }
}
class EmployeeNotFoundException extends Exception{
    new(Long id) {
        super("Employee id " + id + " not found.")
    }
}