package com.jam.web

import com.jam.models.TaskDTO
import com.jam.models.TaskService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.RequestMethod
import static extension com.jam.models.TaskExtensions.*
import java.util.List
import com.jam.models.TaskNotFoundException
import javax.validation.Valid
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/tasks")
class TaskController {
    @Autowired private TaskService service
    
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    def TaskDTO create(@RequestBody @Valid TaskDTO TaskDto){
        service.create(TaskDto).toDTO           
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    def TaskDTO delete(@PathVariable("id") Long id) {
        service.delete(id).toDTO
    }
 
    @RequestMapping(method = RequestMethod.GET)
    def List<TaskDTO> findAll() {
        service.findAll().map[toDTO]
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    def TaskDTO findById(@PathVariable("id") Long id) {
        service.findById(id).orElseThrow[new TaskNotFoundException(id.toString)].toDTO
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    def TaskDTO update(@RequestBody @Valid TaskDTO todoEntry) {
        return service.update(todoEntry).toDTO;
    }
 
    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    def public void handleTodoNotFound(TaskNotFoundException ex) {
    }
}