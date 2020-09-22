package com.asp.example.repositories

import com.asp.example.models.Todo
import javax.enterprise.context.ApplicationScoped

@ApplicationScoped
class TodoRepositoryInMemory {

    fun create(todo: Todo) {
        todos.add(todo)
    }

    fun read(id: String): Todo? {
        return todos.firstOrNull { it.id == id }
    }

    fun update(todo: Todo): Todo {
        val idx = todos.indexOfFirst { it.id == todo.id }
        todos[idx] = todo
        return todo
    }

    fun delete(id: String) {
        val idx = todos.indexOfFirst { it.id == id }
        todos.removeAt(idx)
    }

    fun list(): List<Todo> {
        return todos
    }

    companion object {
       private val todos: MutableList<Todo> = mutableListOf()
    }
}