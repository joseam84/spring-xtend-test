package com.jam.web;

import com.jam.models.Address;
import com.jam.models.AddressRepository;
import com.jam.models.Employee;
import com.jam.models.EmployeeRepository;
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
  
  @Autowired
  private EmployeeRepository employeeRepo;
  
  @Autowired
  private AddressRepository addressRepo;
  
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
      final Person angel = new Person("Angel", "Fonta");
      Address _address = new Address("456 E Main St.", "", "Cacolina", "PR", "00929", "US");
      angel.setAddress(_address);
      this.personRepo.<Person>save(angel);
      List<Person> _findByLastName = this.personRepo.findByLastName("Fonta");
      _xblockexpression = _findByLastName.toString();
    }
    return _xblockexpression;
  }
  
  @RequestMapping("/employees")
  @Transactional
  public String testEmployees() {
    String _xblockexpression = null;
    {
      Employee _employee = new Employee("Jose", "Matos");
      this.employeeRepo.<Employee>save(_employee);
      List<Employee> _findByLastName = this.employeeRepo.findByLastName("Matos");
      _xblockexpression = _findByLastName.toString();
    }
    return _xblockexpression;
  }
  
  @RequestMapping("/addresses")
  @Transactional
  public String testAddresses() {
    String _xblockexpression = null;
    {
      Address _address = new Address("123 Main St.", "", "Caguas", "PR", "00727", "US");
      this.addressRepo.<Address>save(_address);
      List<Person> _findByZipCode = this.addressRepo.findByZipCode("00727");
      _xblockexpression = _findByZipCode.toString();
    }
    return _xblockexpression;
  }
}
