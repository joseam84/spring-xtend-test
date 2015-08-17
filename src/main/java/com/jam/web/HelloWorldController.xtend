package com.jam.web

import java.util.concurrent.atomic.AtomicLong
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import com.jam.models.Greeting
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.ResponseBody

@Controller
@RequestMapping("/hello-world")
class HelloWorldController {
	val static String template = "Hello, %s!"
    val AtomicLong counter = new AtomicLong()

    @RequestMapping(method=RequestMethod.GET)
    @ResponseBody
    def Greeting sayHello(@RequestParam(value="name", required=false, defaultValue="Stranger") String name) {
        new Greeting(counter.incrementAndGet(), String.format(template, name))
    }
}