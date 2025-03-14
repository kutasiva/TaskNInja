//
//  TodoMapper.swift
//  iosApp
//
//  Created by kutasov on 14.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import shared

class TodoMapper {
    func mapToSwiftUIModel(_ dto: TodoItemDTO, randomValues: (description: String, dueDate: Date, priority: Priority)) -> TodoItem {
        return TodoItem(
            id: Int(dto.id),
            userId: Int(dto.userId),
            title: dto.title,
            description: randomValues.description,
            dueDate: randomValues.dueDate,
            priority: randomValues.priority,
            isCompleted: dto.completed
        )
    }

    func mapToDTO(_ item: TodoItem) -> TodoItemDTO {
        return TodoItemDTO(
            id: Int32(item.id),
            userId: Int32(item.userId),
            title: item.title,
            completed: item.isCompleted
        )
    }
}
