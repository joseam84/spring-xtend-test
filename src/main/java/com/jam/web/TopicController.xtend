package com.jam.web

import com.jam.models.TopicDTO
import com.jam.models.TopicService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.RequestMethod
import static extension com.jam.models.TopicExtensions.*
import java.util.List
import com.jam.models.TopicNotFoundException
import javax.validation.Valid
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/topics")
class TopicController {
    @Autowired private TopicService service
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    def TopicDTO create(@RequestBody @Valid TopicDTO topicDto){
        service.create(topicDto).toDTO           
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    def TopicDTO delete(@PathVariable("id") Long id) {
        service.delete(id).toDTO
    }
 
    @RequestMapping(method = RequestMethod.GET)
    def List<TopicDTO> findAll() {
        service.findAll().map[toDTO]
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    def TopicDTO findById(@PathVariable("id") Long id) {
        service.findById(id).orElseThrow[new TopicNotFoundException(id)].toDTO
    }
 
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    def TopicDTO update(@RequestBody @Valid TopicDTO todoEntry) {
        return service.update(todoEntry).toDTO;
    }
 
    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    def public void handleTodoNotFound(TopicNotFoundException ex) {
    }
}