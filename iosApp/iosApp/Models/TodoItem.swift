//
//  ToDoItem.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//
import Foundation

struct TodoItem: Identifiable {
    var id: Int
    var userId: Int
    var title: String
    var description: String
    var dueDate: Date
    var priority: Priority
    var isCompleted: Bool
}
