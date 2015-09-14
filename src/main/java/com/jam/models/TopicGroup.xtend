package com.jam.models

import java.util.List
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.OneToMany
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Autowired
import java.util.Optional
import javax.persistence.ManyToOne

@Entity
@Table(name="topicgroup")
@Accessors
class TopicGroup {
    @Id @GeneratedValue(strategy=AUTO)
    var long id;
    var String name
    var String description
    @ManyToOne
    var Employee creator
    @OneToMany(targetEntity=Topic, mappedBy="group")
    var List<Topic> topics
    new(){}
}

@Accessors
class TopicGroupDTO{
    var Long id
    var String name
    var String description
}

interface TopicGroupRepository extends CrudRepository<TopicGroup, Long>{
    def List<TopicGroup> findByName(String name)
    def List<TopicGroup> findByCreator(Employee owner)
}

@Service
class TopicGroupService implements BaseService<TopicGroupDTO, TopicGroup, Long>{
    @Autowired TopicGroupRepository topicRepo
    override create(TopicGroupDTO tdto) {
        topicRepo.save(new TopicGroup() => [ name = tdto.name description=tdto.description ])
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
    
    def findByCreator(Employee creator){
        Optional.ofNullable(topicRepo.findByCreator(creator))
    }
    override update(TopicGroupDTO tdto) {
        var persisted = findById(tdto.id).orElseThrow[new TopicNotFoundException(tdto.id)]
        persisted.name = tdto.name
        return persisted
    }    
}

class TopicGroupNotFoundException extends Exception{
    new(Long id) {
        super("Topic id " + id + " not found.")
    }
    new(String id){
        super("Topic identified as " + id + " not found.")
    }
}