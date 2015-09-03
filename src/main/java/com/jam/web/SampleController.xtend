package com.jam.web

import com.jam.models.Address
import com.jam.models.AddressRepository
import com.jam.models.Person
import com.jam.models.PersonRepository
import java.util.List
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController

@RestController
@Transactional
class SampleController {
	@Autowired PersonRepository personRepo
	@Autowired AddressRepository addressRepo
	
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