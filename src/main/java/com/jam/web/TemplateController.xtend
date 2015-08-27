package com.jam.web

import com.jam.models.EmployeeRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.PathVariable

@Controller
class TemplateController {
    @Autowired EmployeeRepository employeeRepo
    @RequestMapping("/")      
    def index(){ "home" }
    @RequestMapping("/home")  
    def home(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model){
        model.addAttribute("name", name) 
        "home" 
    }
    @RequestMapping(path = "/hello", method=GET) 
    def hello(){ "hello"}
    @RequestMapping("/login") def login(){ "login" }
    
    @RequestMapping(path = "/employees") 
    def employees(Model model){ 
        model.addAttribute("employees", employeeRepo.findAll)
        "employees"
    }
    @RequestMapping(path = "/employee/{id}") 
    def employee(@PathVariable("id") Long id, Model model){ 
        var employee = employeeRepo.findOne(id)
        model.addAttribute("employee", employee)
        "employee"
    }
}