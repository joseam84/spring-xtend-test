package com.jam.models

import java.util.List
import java.util.Optional

interface  BaseService<T,Out> {
    def Out create(T person)
    def Out delete(Long id)
    def List<Out> findAll()
    def Optional<Out> findById(Long id)
    def Out update(T todo)
}