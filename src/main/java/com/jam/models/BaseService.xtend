package com.jam.models

import java.util.List
import java.util.Optional

interface  BaseService<T,Out,IdType> {
    def Out create(T person)
    def Out delete(Long id)
    def List<Out> findAll()
    def Optional<Out> findById(IdType id)
    def Out update(T todo)
}

interface DTOExtensions<Entity, DTO>{
    def Entity toEntity(DTO dto)
    def DTO toDTO(Entity entity)
}