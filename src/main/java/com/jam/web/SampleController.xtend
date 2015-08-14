package com.jam.web

import com.jam.models.Person
import com.jam.models.PersonRepository
import com.jam.templates.HelloFonta
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.transaction.annotation.Transactional

@RestController
@Transactional
class SampleController {
	@Autowired
	PersonRepository personRepo
	@RequestMapping("/")
	@ResponseBody
	def String home(){
		new HelloFonta().content
	}
	@RequestMapping("/persons")
	@Transactional
	def String testPersons(){
		personRepo.save(new Person("Angel","Fonta"))
		personRepo.findByLastName("Fonta").toString
	}	
}