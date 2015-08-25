package com.jam.web

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.ui.Model

@Controller
class TemplateController {
    @RequestMapping("/")      
    def index(){ "home" }
    @RequestMapping("/home")  
    def home(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model){
        model.addAttribute("name", name) 
        return "home" 
    }
    @RequestMapping(path = "/hello", method=GET) 
    def hello(){ "hello"}
    @RequestMapping("/login") def login(){ "login" }
}