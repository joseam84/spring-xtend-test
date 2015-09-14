package com.jam.web;

import com.jam.models.EmployeeNotFoundException
import com.jam.models.EmployeeService
import com.jam.models.TopicDTO
import com.jam.models.TopicGroupNotFoundException
import com.jam.models.TopicGroupService
import com.jam.models.TopicService
import java.security.Principal
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.ModelAttribute
import org.springframework.web.bind.annotation.RequestMapping

@Controller
public class TopicViewController {
    
    @Autowired EmployeeService employeeService
    @Autowired TopicGroupService topicGroupService
    @Autowired TopicService topicService
    
    @RequestMapping(path = "/topics") 
    def topics(Model model, Principal principal){
        val creator  = employeeService.findByUsername(principal.name) // Current user as Employee
                        .orElseThrow[new EmployeeNotFoundException(principal.name)]
        val topicGroups =  topicGroupService.findByCreator(creator)
                        .orElseThrow[new TopicGroupNotFoundException(creator.username + " group")]
        model.addAttribute("topicgroups", topicGroups)
        model.addAttribute("newTopic", new TopicDTO())
        "topics"
    }
    
    @RequestMapping(path = "/newtopic", method=POST) 
    def topicSubmit(@ModelAttribute TopicDTO newTopic, Model model){
        topicService.addToTopicGroup(newTopic)
        "redirect:topics"
    }
    
    @RequestMapping(path = "/remove-topic", method=POST) 
    def topicRemove(@ModelAttribute TopicDTO topicToRemove){
        topicService.delete(topicToRemove.id)
        "redirect:topics"
    }
}
