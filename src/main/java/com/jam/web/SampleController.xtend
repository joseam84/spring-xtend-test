package com.jam.web

import com.jam.models.Address
import com.jam.models.AddressRepository
import com.jam.models.Employee
import com.jam.models.EmployeeRepository
import com.jam.models.Person
import com.jam.models.PersonRepository
import com.jam.templates.HelloFonta
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import java.util.List

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
		employeeRepo.save(new Employee() => [
			firstName = "Jose"
			lastName = "Matos"
			email = "j@gmail.com"
			employeeNumber = "12345"
			address = new Address() => [
				addressLine1 = "456 Main St."
				addressLine2 = "Urb Mirador Bairoa"
				city = "Caguas"
				zipCode = "00727"
				state = "PR"
				country = "US"
			]
		])
		employeeRepo.findByLastName("Matos").toString
	}	
	@RequestMapping("/addresses")
    @Transactional
    def String testAddresses(){
        addressRepo.save(new Address("123 Main St.","","Caguas","PR","00727","US"))
        addressRepo.findByZipCode("00727").toString
    }
    @RequestMapping(path="/persons-api",method=RequestMethod.POST)
    @ResponseBody
    def List<Person> personsByLastName(@RequestParam(value="lastName") String lastName) {
        personRepo.findByLastName(lastName)
    }
    
}