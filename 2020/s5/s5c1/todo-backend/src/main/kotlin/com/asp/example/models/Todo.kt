package com.asp.example.models

import java.net.URL
import java.util.UUID
import javax.ws.rs.core.UriBuilder

data class Todo(
    var id: String? = UUID.randomUUID().toString(),
    val title: String,
    val order: Int = -1,
    val completed: Boolean = false,
    var url: URL?
) {
    fun getURL() { UriBuilder.fromUri(url?.toURI()).scheme(url?.protocol).path(this.id).build().toURL() }
}