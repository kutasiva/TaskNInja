//
//  TodoViewModelWrapper.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import shared
import SwiftUI

@MainActor
class TodoViewModelWrapper: ObservableObject {
    @Published var todoState: TodoState
    @Published var filteredTodos: [TodoItem] = []
    @Published var selectedPriority: Priority? = nil {
        didSet {
            applyFilterAndSort()
        }
    }

    @Published var sortAscending: Bool = true {
        didSet {
            applyFilterAndSort()
        }
    }

    let todoViewModel: TodoViewModel
    private let todoMapper = TodoMapper()
    private let randomValuesStore = RandomValuesStore()

    init() {
        todoViewModel = TodosInjector().todoViewModel
        todoState = todoViewModel.todoState.value
        applyFilterAndSort()
    }

    func updateTodoItem(_ updatedItem: TodoItem) {
        guard let successState = todoState as? TodoState.Success else {
            return
        }
        if let index = successState.todos.firstIndex(where: { $0.id == updatedItem.id }) {
            
            let dto = todoMapper.mapToDTO(updatedItem)
            todoViewModel.updateTodoItem(todo: dto)
            successState.todos[index] = dto
            todoState = successState
            randomValuesStore.updateValues(for: updatedItem)
            applyFilterAndSort()
        }
    }

    func toggleTodoItemCompletion(_ item: TodoItem) {
        var updatedItem = item
        updatedItem.isCompleted.toggle()
        updateTodoItem(updatedItem)
    }

    func startObserving() async {
        for await state in todoViewModel.todoState {
            todoState = state
            applyFilterAndSort()
        }
    }

    func refreshTodos() {
        todoViewModel.refreshTodos()
    }

    func mapToSwiftUIModel(_ dto: TodoItemDTO) -> TodoItem {
        let randomValues = randomValuesStore.getValues(for: Int(dto.id))
        return todoMapper.mapToSwiftUIModel(dto, randomValues: randomValues)
    }

    private func applyFilterAndSort() {
        if let successState = todoState as? TodoState.Success {
            var todos = successState.todos.map { mapToSwiftUIModel($0) }
            if let priority = selectedPriority {
                todos = todos.filter { $0.priority == priority }
            }
            todos.sort {
                sortAscending ?
                    $0.dueDate < $1.dueDate :
                    $0.dueDate > $1.dueDate
            }
            filteredTodos = todos
        }
    }

    func setPriorityFilter(_ priority: Priority?) {
        selectedPriority = priority
    }

    func toggleSortOrder() {
        sortAscending.toggle()
    }
}
