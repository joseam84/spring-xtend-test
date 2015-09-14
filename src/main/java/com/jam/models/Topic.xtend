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
import javax.persistence.ManyToOne

@Entity
@Table(name="topic")
@Accessors
class Topic {
    @Id @GeneratedValue(strategy=AUTO)
    var long id;
    var String name
    var String description
    @ManyToOne
    var TopicGroup group
    new (String name){
      this.name = name  
    }
    new() { }
}

@Accessors
class TopicDTO{
    var Long id
    var Long topicGroupId
    var String name
    var String description
    new() { }
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
    def List<Topic> findByName(String name)
    def List<Topic> findByGroup(TopicGroup group)
}
@Service
class TopicService implements BaseService<TopicDTO, Topic, Long>{
    @Autowired TopicRepository topicRepo
    @Autowired TopicGroupRepository topicGroupRepo
    override create(TopicDTO tdto) {
        topicRepo.save(new Topic(tdto.name))
    }
    override delete(Long id) {
        var toDelete = topicRepo.findOne(id)
        topicRepo.delete(id)
        toDelete
    }
    
    def addToTopicGroup(TopicDTO topic){
        val topicGroup = topicGroupRepo.findOne(topic.topicGroupId)
        val topicToAdd = new Topic() => 
            [name = topic.name 
             group = topicGroup
             description = topic.description]
        topicRepo.save(topicToAdd)
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
