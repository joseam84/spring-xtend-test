package com.jam.web;

import com.jam.models.Address;
import com.jam.models.AddressRepository;
import com.jam.models.Employee;
import com.jam.models.EmployeeRepository;
import com.jam.models.Person;
import com.jam.models.PersonRepository;
import java.util.List;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
      Employee _employee = new Employee();
      final Procedure1<Employee> _function = (Employee it) -> {
        it.setFirstName("Jose");
        it.setLastName("Matos");
        it.setEmail("j@gmail.com");
        it.setEmployeeNumber("12345");
        Address _address = new Address();
        final Procedure1<Address> _function_1 = (Address it_1) -> {
          it_1.setAddressLine1("456 Main St.");
          it_1.setAddressLine2("Urb Mirador Bairoa");
          it_1.setCity("Caguas");
          it_1.setZipCode("00727");
          it_1.setState("PR");
          it_1.setCountry("US");
        };
        Address _doubleArrow = ObjectExtensions.<Address>operator_doubleArrow(_address, _function_1);
        it.setAddress(_doubleArrow);
      };
      Employee _doubleArrow = ObjectExtensions.<Employee>operator_doubleArrow(_employee, _function);
      this.employeeRepo.<Employee>save(_doubleArrow);
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
  
  @RequestMapping(path = "/persons-api", method = RequestMethod.POST)
  @ResponseBody
  public List<Person> personsByLastName(@RequestParam(value = "lastName") final String lastName) {
    return this.personRepo.findByLastName(lastName);
  }
}
