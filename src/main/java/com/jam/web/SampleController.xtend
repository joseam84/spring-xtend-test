package com.jam.web

import com.jam.models.Person
import com.jam.models.PersonRepository
import com.jam.templates.HelloFonta
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.transaction.annotation.Transactional
import com.jam.models.Employee
import com.jam.models.EmployeeRepository
import com.jam.models.Address
import com.jam.models.AddressRepository

@RestController
@Transactional
class SampleController {
	@Autowired PersonRepository personRepo
	@Autowired EmployeeRepository employeeRepo
	@Autowired AddressRepository addressRepo
	@RequestMapping("/")
	@ResponseBody
	def String home(){
		new HelloFonta().content
	}
	@RequestMapping("/persons")
	@Transactional
	def String testPersons(){
	    val angel = new Person("Angel","Fonta")
		angel.address = new Address("456 E Main St.","","Cacolina","PR","00929","US")
		personRepo.save(angel)
		personRepo.findByLastName("Fonta").toString
	}	
	@RequestMapping("/employees")
	@Transactional
	def String testEmployees(){
		employeeRepo.save(new Employee("Jose","Matos"))
		employeeRepo.findByLastName("Matos").toString
	}	
	@RequestMapping("/addresses")
    @Transactional
    def String testAddresses(){
        addressRepo.save(new Address("123 Main St.","","Caguas","PR","00727","US"))
        addressRepo.findByZipCode("00727").toString
    }
}