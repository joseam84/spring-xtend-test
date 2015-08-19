package com.jam.web

import com.jam.models.PersonDTO
import com.jam.models.PersonService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.RequestMethod
import static extension com.jam.models.PersonExtension.*
import java.util.List
import com.jam.models.PersonNotFoundException
import javax.validation.Valid
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/persons")
class PersonController {
    @Autowired private PersonService service
    
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    def PersonDTO create(@RequestBody @Valid PersonDTO personDto){
        service.create(personDto).toDTO           
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    def PersonDTO delete(@PathVariable("id") Long id) {
        service.delete(id).toDTO
    }
 
    @RequestMapping(method = RequestMethod.GET)
    def List<PersonDTO> findAll() {
        service.findAll().map[toDTO]
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    def PersonDTO findById(@PathVariable("id") Long id) {
        service.findById(id).orElseThrow[new PersonNotFoundException(id)].toDTO
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    def PersonDTO update(@RequestBody @Valid PersonDTO todoEntry) {
        return service.update(todoEntry).toDTO;
    }
 
    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    def public void handleTodoNotFound(PersonNotFoundException ex) {
    }
}