package com.jam.web;

import com.jam.models.EmployeeService
import com.jam.models.TaskDTO
import com.jam.models.TaskService
import com.jam.models.TopicDTO
import com.jam.models.TopicGroupDTO
import com.jam.models.TopicService
import java.security.Principal
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.ModelAttribute
import org.springframework.web.bind.annotation.RequestMapping

@Controller
public class TasksViewController {
    
    @Autowired EmployeeService employeeService
    @Autowired TopicService topicService
    @Autowired TaskService taskService
    
    @RequestMapping(path = "/tasks") 
    def topics(Model model, Principal principal){
        val currentUser  = employeeService.findByUsername(principal.name) // Current user as Employee
        val _tasks = taskService.findEmployeeTasks(currentUser) 
        //This tgDTO represent the view structure as a data structure                
        val topicInTasks = _tasks.groupBy[t | t.topic]
        var groupInTopic = topicInTasks.keySet.groupBy[tp | tp.group]
        var tgDTO = groupInTopic.keySet.map[group | 
           new TopicGroupDTO() => [
               id = group.id
               name = group.name
               description = group.description
               topics = group.topics.map[topic | 
                   new TopicDTO => [
                       id = topic.id
                       name = topic.name
                       description = topic.description
                       tasks = topicInTasks.get(topic)    
               ]]
        ]]
        model.addAttribute("topicgroups", tgDTO)
        model.addAttribute("newTask", new TaskDTO())
        "tasks"
    }
    
    @RequestMapping(path = "/new-task", method=POST) 
    def taskSubmit(@ModelAttribute TaskDTO newTask, Principal principal, Model model){
        val creator  = employeeService.findByUsername(principal.name)
        newTask.employee = creator
        taskService.addToTopic(newTask)
        "redirect:tasks"
    }
}
