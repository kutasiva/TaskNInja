package com.example.taskninja

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class TodoItemDTO(
    val id: Int,
    val userId: Int,
    val title: String,
    var completed: Boolean
)