package com.jam.models;

import com.jam.models.Person;
import java.util.List;
import org.springframework.data.repository.CrudRepository;

@SuppressWarnings("all")
public interface PersonRepository extends CrudRepository<Person, Long> {
  public abstract List<Person> findByLastName(final String lastName);
}
