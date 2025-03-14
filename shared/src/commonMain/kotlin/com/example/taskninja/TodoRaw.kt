package com.example.taskninja

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
data class TodoRaw(
    @SerialName("id")
    val id: Int,
    @SerialName("userId")
    val userId: Int,
    @SerialName("title")
    val title: String,
    @SerialName("completed")
    val completed: Boolean,
)