package com.example.taskninja

sealed class TodoState {
    data object Loading : TodoState()
    data class Success(var todos: List<TodoItemDTO>) : TodoState()
    data class Error(val message: String) : TodoState()
}