package com.jam.web

import com.jam.models.EmployeeNotFoundException
import com.jam.models.EmployeeService
import java.security.Principal
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam

@Controller
class TemplateController {
    @Autowired EmployeeService employeeService
    @RequestMapping("/")      
    def index(){ "home" }
    @RequestMapping("/home")  
    def home(@RequestParam(value="name", required=false, defaultValue="World") 
        String name, Model model, Principal principal){
        var auth = principal
        println(auth)   
        model.addAttribute("name", name) 
        "home" 
    }
    @RequestMapping(path = "/hello", method=GET) 
    def hello(){"hello"}
    @RequestMapping("/login") def login(){ "login" }
    
    
    @RequestMapping(path = "/subordinates") 
    def subordinate(Model model, Principal principal){ 
        var currentEmployee = employeeService.findByUsername(principal.name)
                                .orElseThrow[new EmployeeNotFoundException(principal.name)] 
        model.addAttribute("subordinates", currentEmployee.subordinates)
        "subordinates"
    }
    @RequestMapping(path = "/employees") 
    def employees(Model model){ 
        model.addAttribute("employees", employeeService.findAll)
        "employees"
    }
    
    @RequestMapping(path = "/employee/{username}") 
    def employee(@PathVariable("username") String username, Model model){ 
        var employee = employeeService.findByUsername(username)
                      .orElseThrow[new EmployeeNotFoundException(username)]
        model.addAttribute("employee", employee)
        "employee"
    }
}