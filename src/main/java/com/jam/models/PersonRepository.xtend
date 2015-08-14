package com.jam.models

import org.springframework.data.repository.CrudRepository
import java.util.List

interface PersonRepository extends CrudRepository<Person, Long> {
	def List<Person> findByLastName(String lastName)
}