package com.jam.web

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping

@Controller
class TemplateController {
    @RequestMapping("/")      def index(){ "home" }
    @RequestMapping("/home")  def home() { "home" }
    @RequestMapping("/hello") def hello(){ "hello" }
    @RequestMapping("/login") def login(){ "login" }
}