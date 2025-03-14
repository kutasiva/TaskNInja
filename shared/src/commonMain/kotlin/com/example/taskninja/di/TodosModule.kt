package com.example.taskninja.di

import com.example.taskninja.TodoService
import com.example.taskninja.TodoUseCase
import com.example.taskninja.TodoViewModel
import org.koin.dsl.module

val todosModule = module {
    single<TodoService> { TodoService(get()) }
    single<TodoUseCase> { TodoUseCase(get()) }
    single<TodoViewModel> { TodoViewModel(get()) }
}
