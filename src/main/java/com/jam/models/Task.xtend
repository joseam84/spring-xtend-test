package com.jam.models

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Table
import org.springframework.data.repository.CrudRepository
import static extension com.jam.models.EmployeeExtension.*
import javax.persistence.ManyToOne
import javax.persistence.JoinColumn
import java.util.List
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Table(name ="task")
@Accessors
class Task {
    @Id @GeneratedValue(strategy=AUTO)
    private long id;
    @ManyToOne(cascade=ALL)
    @JoinColumn(name="CUST_ID", nullable=false)
    var Employee employee
    @ManyToOne(cascade=ALL)
    var Topic topic
    var String content
    new(){}
}

@Accessors
class TaskDTO{
    var EmployeeDTO employee
    var String content
    new(){}
}

interface TaskRepository extends CrudRepository<Task, Long>{
    def List<Task> findByEmployee(Employee e)
    def List<Task> findByTopic(Topic topic)
}

class TaskExtensions{
    def static Task toEntity(TaskDTO dto) {
        new Task() => [
            employee = dto.employee.toEntity
            content = dto.content    
        ]
    }
    def static TaskDTO toDTO(Task entity) {
        new TaskDTO => [
            employee = entity.employee.toDTO
            content = entity.content
        ]
    }
}


class TaskNotFoundException extends Exception{
    new(Long id) {
        super("Task id " + id + " not found.")
    }
}