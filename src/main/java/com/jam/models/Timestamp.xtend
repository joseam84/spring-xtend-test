package com.jam.models

import java.util.Date
import javax.persistence.EntityListeners
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.MappedSuperclass
import javax.persistence.Version
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.data.annotation.CreatedBy
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.jpa.domain.support.AuditingEntityListener

@MappedSuperclass
@EntityListeners(AuditingEntityListener)
@Accessors
public class Timestamp {

  @Id
  @GeneratedValue var Long id;
  @CreatedBy var String createdBy
  @CreatedDate var Date createdAt
  @LastModifiedDate var Date updatedAt

  @Version
  public int version;
}