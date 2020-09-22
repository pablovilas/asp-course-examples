package com.asp.example.services

import com.asp.example.models.Todo
import com.asp.example.repositories.TodoRepositoryInMemory
import javax.enterprise.context.ApplicationScoped
import javax.enterprise.inject.Default
import javax.inject.Inject

@ApplicationScoped
class TodoService {

    @Inject
    @field: Default
    lateinit var repository: TodoRepositoryInMemory

    fun create(todo: Todo) {
        repository.create(todo)
    }

    fun read(uid: String): Todo? {
        return repository.read(uid)
    }

    fun update(id: String, data: Todo): Todo {
        data.id = id
        return repository.update(data)
    }

    fun delete(id: String) {
        return repository.delete(id)
    }

    fun list(): List<Todo> {
        return repository.list()
    }
}