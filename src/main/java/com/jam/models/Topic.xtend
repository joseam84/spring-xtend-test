package com.jam.models

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Table(name="topic")
@Accessors
class Topic {
    @Id @GeneratedValue(strategy=AUTO)
    private long id;
    private String name
}

@Accessors
class TopicDTO{
    private String name
}

