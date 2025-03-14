package com.example.taskninja

class TodoUseCase (private val service: TodoService) {

    suspend fun getTodos(): List<TodoItemDTO> {
        val todoRaw = service.fetchTodos()
        return mapTodos(todoRaw)
    }

    suspend fun updateTodo(todo: TodoItemDTO): TodoItemDTO {
        return service.updateTodo(todo)
    }

    private fun mapTodos(todoRaw: List<TodoRaw>): List<TodoItemDTO> {
        return todoRaw.map { todo ->
            TodoItemDTO(
                id = todo.id,
                userId = todo.userId,
                title = todo.title,
                completed = todo.completed
            )
        }
    }
}