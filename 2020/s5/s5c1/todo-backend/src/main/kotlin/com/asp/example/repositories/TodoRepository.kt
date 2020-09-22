package com.asp.example.repositories

import com.asp.example.models.Todo
import software.amazon.awssdk.services.dynamodb.DynamoDbClient
import software.amazon.awssdk.services.dynamodb.model.AttributeValue
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest
import software.amazon.awssdk.services.dynamodb.model.ScanRequest
import java.net.URL
import java.util.stream.Collectors
import javax.enterprise.context.ApplicationScoped
import javax.enterprise.inject.Default
import javax.inject.Inject

//@ApplicationScoped
class TodoRepository {

    @Inject
    @field: Default
    lateinit var dynamoDbClient: DynamoDbClient

    fun create(todo: Todo) {
        dynamoDbClient.putItem(putRequest(todo))
    }

    fun read(uid: String): Todo {
        val item = dynamoDbClient.getItem(getRequest(uid)).item()
        return Todo(
            id = requireNotNull(item[TODO_ID_COL]).s(),
            title = requireNotNull(item[TODO_TITLE_COL]).s(),
            order = requireNotNull(item[TODO_ORDER_COL]).n().toInt(),
            completed = requireNotNull(item[TODO_COMPLETED_COL]).bool(),
            url = URL(requireNotNull(item[TODO_URL_COL]).s())
        )
    }

    fun list(): List<Todo> {
        return dynamoDbClient.scanPaginator(scanRequest()).items().stream()
            .map { item ->
                Todo(
                    id = requireNotNull(item[TODO_ID_COL]).s(),
                    title = requireNotNull(item[TODO_TITLE_COL]).s(),
                    order = requireNotNull(item[TODO_ORDER_COL]).n().toInt(),
                    completed = requireNotNull(item[TODO_COMPLETED_COL]).bool(),
                    url = URL(requireNotNull(item[TODO_URL_COL]).s())
                )
            }.collect(Collectors.toList())
    }

    private fun getTableName(): String {
        return "todoTable"
    }

    private fun putRequest(todo: Todo): PutItemRequest {
        val item: MutableMap<String, AttributeValue> = HashMap()
        item[TODO_ID_COL] = AttributeValue.builder().n(todo.id).build()
        item[TODO_TITLE_COL] = AttributeValue.builder().s(todo.title).build()
        item[TODO_ORDER_COL] = AttributeValue.builder().s(todo.title).build()
        item[TODO_COMPLETED_COL] = AttributeValue.builder().s(todo.title).build()
        item[TODO_URL_COL] = AttributeValue.builder().s(todo.url.toString()).build()
        return PutItemRequest.builder()
                .tableName(getTableName())
                .item(item)
                .build()
    }

    private fun getRequest(uid: String): GetItemRequest? {
        val key: MutableMap<String, AttributeValue> = HashMap()
        key[TODO_ID_COL] = AttributeValue.builder().s(uid).build()
        return GetItemRequest.builder()
                .tableName(getTableName())
                .key(key)
                .attributesToGet(
                    TODO_ID_COL,
                    TODO_TITLE_COL,
                    TODO_ORDER_COL,
                    TODO_COMPLETED_COL,
                    TODO_URL_COL
                )
                .build()
    }

    private fun scanRequest(): ScanRequest {
        return ScanRequest.builder().tableName(getTableName())
                .attributesToGet(
                    TODO_ID_COL,
                    TODO_TITLE_COL,
                    TODO_ORDER_COL,
                    TODO_COMPLETED_COL,
                    TODO_URL_COL
                ).build()
    }

    companion object {
        private const val TODO_ID_COL = "PK"
        private const val TODO_TITLE_COL = "Title"
        private const val TODO_ORDER_COL = "Order"
        private const val TODO_COMPLETED_COL = "Completed"
        private const val TODO_URL_COL = "Url"
    }
}