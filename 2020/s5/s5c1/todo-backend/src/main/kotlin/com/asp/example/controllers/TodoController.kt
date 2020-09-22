package com.asp.example.controllers

import com.asp.example.models.Todo
import com.asp.example.services.TodoService
import java.util.UUID
import javax.enterprise.inject.Default
import javax.inject.Inject
import javax.ws.rs.Consumes
import javax.ws.rs.DELETE
import javax.ws.rs.GET
import javax.ws.rs.PATCH
import javax.ws.rs.POST
import javax.ws.rs.Path
import javax.ws.rs.PathParam
import javax.ws.rs.Produces
import javax.ws.rs.QueryParam
import javax.ws.rs.core.Context
import javax.ws.rs.core.MediaType
import javax.ws.rs.core.Response
import javax.ws.rs.core.UriInfo

@Path("/todos")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
class TodoController {

    @Context
    lateinit var uriInfo: UriInfo

    @Inject
    @field: Default
    lateinit var service: TodoService

    @POST
    fun create(todo: Todo) {
        todo.id = UUID.randomUUID().toString()
        todo.url = uriInfo.absolutePathBuilder.scheme("https").build().toURL()
        service.create(todo)
    }

    @GET
    @Path("{id}")
    fun read(@PathParam("id") id: String): Response {
        val todo = service.read(id)
        if (todo != null) {
            return Response.ok(todo).build()
        }
        return Response.status(404).build()
    }

    @PATCH
    @Path("{id}")
    fun update(@PathParam("id") id: String, todo: Todo): Response {
        val updatedTodo = service.update(id, todo)
        return Response.ok(updatedTodo).build()
    }

    @DELETE
    @Path("{id}")
    fun delete(@PathParam("id") id: String): Response {
        service.delete(id)
        return Response.noContent().build()
    }

    @GET
    fun list(@QueryParam("time") time: Long): List<Todo> {
        if (time > 0) Thread.sleep(time)
        return service.list()
    }
}