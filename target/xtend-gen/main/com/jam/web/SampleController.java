package com.jam.web;

import com.jam.models.Person;
import com.jam.models.PersonRepository;
import com.jam.templates.HelloFonta;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Transactional
@SuppressWarnings("all")
public class SampleController {
  @Autowired
  private PersonRepository personRepo;
  
  @RequestMapping("/")
  @ResponseBody
  public String home() {
    HelloFonta _helloFonta = new HelloFonta();
    return _helloFonta.content();
  }
  
  @RequestMapping("/persons")
  @Transactional
  public String testPersons() {
    String _xblockexpression = null;
    {
      Person _person = new Person("Angel", "Fonta");
      this.personRepo.<Person>save(_person);
      List<Person> _findByLastName = this.personRepo.findByLastName("Fonta");
      _xblockexpression = _findByLastName.toString();
    }
    return _xblockexpression;
  }
}
