package com.example.taskninja

import kotlinx.serialization.SerialName

data class TodoItemDTO(
    val id: Int,
    val userId: Int,
    val title: String,
    var completed: Boolean
)