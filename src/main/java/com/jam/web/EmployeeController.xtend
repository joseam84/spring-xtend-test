package com.jam.web

import com.jam.models.EmployeeDTO
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.RequestMethod
import static extension com.jam.models.EmployeeExtension.*
import java.util.List
import com.jam.models.EmployeeNotFoundException
import javax.validation.Valid
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.beans.factory.annotation.Autowired
import com.jam.models.EmployeeService

@RestController
@RequestMapping("/api/employees")
class EmployeeController {
    @Autowired private EmployeeService service
    
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    def EmployeeDTO create(@RequestBody @Valid EmployeeDTO EmployeeDTO){
o        service.create(EmployeeDTO).toDTO           
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    def EmployeeDTO delete(@PathVariable("id") Long id) {
        service.delete(id).toDTO
    }
 
    @RequestMapping(method = RequestMethod.GET)
    def List<EmployeeDTO> findAll() {
        service.findAll().map[toDTO]
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    def EmployeeDTO findById(@PathVariable("id") Long id) {
        service.findById(id).orElseThrow[new EmployeeNotFoundException(id)].toDTO
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    def EmployeeDTO update(@RequestBody @Valid EmployeeDTO todoEntry) {
        return service.update(todoEntry).toDTO;
    }
 
    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    def public void handleTodoNotFound(EmployeeNotFoundException ex) {
    }
}