package com.jam.models

import java.util.List
import java.util.Optional
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Service

@Entity
@Table(name="topic")
@Accessors
class Topic {
    @Id @GeneratedValue(strategy=AUTO)
    var long id;
    var String name
    new (String name){
      this.name = name  
    }
    new() { }
}

@Accessors
class TopicDTO{
    var Long id
    var String name
}
class TopicExtensions{
    def static TopicDTO toDTO(Topic entity) {
        new TopicDTO => [
            id = entity.id
            name = entity.name
        ]
    }
}
interface TopicRepository extends CrudRepository<Topic, Long>{
    def List<Topic> findByName(Topic topic)
}
@Service
class TopicService implements BaseService<TopicDTO,Topic>{
    @Autowired TopicRepository topicRepo
    override create(TopicDTO tdto) {
        topicRepo.save(new Topic(tdto.name))
    }
    override delete(Long id) {
        var toDelete = topicRepo.findOne(id)
        topicRepo.delete(id)
        toDelete
    }
    override findAll() {
        topicRepo.findAll().toList
    }
    override findById(Long id) {
       Optional.ofNullable(topicRepo.findOne(id))
    }
    override update(TopicDTO tdto) {
        var persisted = findById(tdto.id).orElseThrow
            [new TopicNotFoundException(tdto.id)]
        persisted.name = tdto.name
        return persisted
      
    }  
}
class TopicNotFoundException extends Exception{
    new(Long id) {
        super("Topic id " + id + " not found.")
    }
}
