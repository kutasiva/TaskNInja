package com.example.taskninja.di

import com.example.taskninja.TodoViewModel
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.context.startKoin

fun initKoin() {
    val modules = sharedKoinModules

    startKoin {
        modules(modules)
    }
}

class TodosInjector: KoinComponent {
    val todoViewModel: TodoViewModel by inject()
}