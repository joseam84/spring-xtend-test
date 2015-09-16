package com.jam.models

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Table
import org.springframework.data.repository.CrudRepository
import static extension com.jam.models.EmployeeExtension.*
import static extension com.jam.models.TaskExtensions.*
import javax.persistence.ManyToOne
import javax.persistence.JoinColumn
import java.util.List
import javax.persistence.Id
import javax.persistence.GeneratedValue
import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Autowired
import java.util.Optional
import java.time.LocalDateTime

@Entity
@Table(name ="task")
@Accessors
class Task extends Timestamp{
    @ManyToOne(cascade=ALL)
    @JoinColumn(name="EMPLOYEE_ID", nullable=false)
    var Employee employee
    @ManyToOne(cascade=ALL)
    var Topic topic
    var String content
    new(){}
}

@Accessors
class TaskDTO{ 
    var Long id
    var Long topicId
    var Long employeeId
    var String content
    new(){}
}

interface TaskRepository extends CrudRepository<Task, Long>{
    def List<Task> findByEmployee(Employee e)
    def List<Task> findByTopic(Topic topic)
    def List<Task> findByEmployeeAndTopic(Employee employee , Topic topic)
}

class TaskExtensions{
    def static TaskDTO toDTO(Task entity) {
        new TaskDTO => [
            id = entity.id
            topicId = entity.topic.id
            employeeId = entity.employee.id
            content = entity.content
        ]
    }
}

@Service
class TaskService implements BaseService<TaskDTO,Task, Long>{
    @Autowired TaskRepository taskRepo
    @Autowired EmployeeService empRepo
    @Autowired TopicService topicRepo
    override create(TaskDTO tdto) {
        taskRepo.save(new Task() => [
            topic    = topicRepo.findById(tdto.topicId)
                        .orElseThrow[new TopicNotFoundException(id)]
            content  = tdto.content
            employee = empRepo.findById(tdto.employeeId)
                        .orElseThrow[new EmployeeNotFoundException(id)]])
    }
    override delete(Long id) {
        var toDelete = taskRepo.findOne(id)
        taskRepo.delete(id)
        toDelete
    }
    override findAll() {
        taskRepo.findAll().toList
    }
    override findById(Long id) {
       Optional.ofNullable(taskRepo.findOne(id))
    }
    override update(TaskDTO tdto) {
        var persisted = findById(tdto.id).orElseThrow
            [new TaskNotFoundException(tdto.id.toString())]
        persisted.content = tdto.content
        return persisted   
    }
    
    def findEmployeeTasks(Employee employee){
        Optional.ofNullable(taskRepo.findByEmployee(employee))
            .orElseThrow[new TaskNotFoundException(employee.username)]
    }
}
class TaskNotFoundException extends Exception{
     new(String id) {
        super("Task id " + id + " not found.")
    }
}