package com.jam.models

import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.MappedSuperclass
import javax.persistence.Version
import org.springframework.data.annotation.CreatedDate
import java.time.LocalDateTime
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.annotation.CreatedBy
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.security.core.userdetails.User

@MappedSuperclass
@Accessors
public class Timestamp {

  @Id
  @GeneratedValue var Long id;
  @CreatedBy var User createdBy
  @CreatedDate var LocalDateTime createdAt
  @LastModifiedDate var LocalDateTime updatedAt

  @Version
  public int version;
}