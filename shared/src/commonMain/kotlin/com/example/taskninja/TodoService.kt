package com.example.taskninja
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.client.request.put
import io.ktor.client.request.setBody
import io.ktor.client.utils.EmptyContent.contentType
import io.ktor.http.ContentType
import io.ktor.http.contentType

class TodoService(private val httpClient: HttpClient) {
    private val baseUrl = "https://jsonplaceholder.typicode.com/todos"

    suspend fun fetchTodos(): List<TodoRaw> {
        return httpClient.get(baseUrl).body()
    }

    suspend fun updateTodo(todo: TodoItemDTO): TodoItemDTO {
        return httpClient.put("$baseUrl/${todo.id}") {
            contentType(ContentType.Application.Json)
            setBody(todo)
        }.body()
    }

}