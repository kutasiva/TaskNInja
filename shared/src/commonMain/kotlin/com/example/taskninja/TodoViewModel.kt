package com.example.taskninja

import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import io.ktor.client.HttpClient
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

class TodoViewModel(
    private val useCase: TodoUseCase
) : BaseViewModel(

) {
    private val _todoState: MutableStateFlow<TodoState> = MutableStateFlow(TodoState.Loading)
    val todoState: StateFlow<TodoState> get() = _todoState

    init {
        getTodos()
    }

    fun updateTodoItem(todo: TodoItemDTO) {
        scope.launch {
            try {
                val updatedTodo = useCase.updateTodo(todo)
                val currentTodos = (_todoState.value as? TodoState.Success)?.todos?.toMutableList() ?: mutableListOf()
                val index = currentTodos.indexOfFirst { it.id == todo.id }
                if (index != -1) {
                    currentTodos[index] = updatedTodo
                    _todoState.emit(TodoState.Success(todos = currentTodos))
                }
            } catch (e: Exception) {
                _todoState.emit(TodoState.Error(message = e.message ?: "Unknown error"))
            }
        }
    }

    private fun getTodos() {
        scope.launch {
            val fetchedTodos = useCase.getTodos()
            _todoState.emit(TodoState.Success(todos = fetchedTodos))
        }
    }

    private fun getMockTodos() {
        scope.launch {
            try {
                val fetched = fetchTodos()
                delay(5000) // Simulate network delay
                _todoState.value = TodoState.Success(todos = fetched)
            } catch (e: Exception) {
                _todoState.value = TodoState.Error(message = e.message ?: "Unknown error")
            }
        }
    }

    private suspend fun fetchTodos(): List<TodoItemDTO> = mocTodos

    private val mocTodos = listOf(
        TodoItemDTO(
            id = 1,
            userId = 1,
            title = "Buy groceries",
            completed = false


        ),
        TodoItemDTO(
            id = 2,
            userId = 2,
            title = "Clean the house",
            completed = false
        ),
        TodoItemDTO(
            id = 3,
            userId = 2,
            title = "Finish project report",
            completed = false
        )
    )

    fun getMockTodoState(): TodoState {
        return TodoState.Success(todos = mocTodos)
    }

    fun refreshTodos() {
        getTodos()
    }

}