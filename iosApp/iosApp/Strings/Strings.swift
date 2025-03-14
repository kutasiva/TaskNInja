//
//  Strings.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

enum Strings {
    enum TodoListView {
        static let newItemTitlePlaceholder = "New Item Title"
        static let newItemDescriptionPlaceholder = "New Item Description"
        static let dueDateLabel = "Due Date: "
        static let priorityLabel = "Priority: "
        static let addNewItemButton = "plus"
        static let navigationTitle = "ToDo List"
        static let filterByPriority = "Filter by Priority"
        static let sortByDateAsc = "Sort by Date (Asc)"
        static let sortByDateDesc = "Sort by Date (Desc)"
    }

    enum AddTodoItemView {
        static let titleSectionHeader = "Title"
        static let descriptionSectionHeader = "Description"
        static let dueDateSectionHeader = "Due Date"
        static let prioritySectionHeader = "Priority"
        static let navigationTitle = "Add New ToDo"
        static let cancelButton = "Cancel"
        static let saveButton = "Save"
    }

    enum TodoDetailView {
        static let navigationTitle = "ToDo Details"
        static let titleSectionHeader = "Title"
        static let descriptionSectionHeader = "Description"
        static let dueDateSectionHeader = "Due Date"
        static let prioritySectionHeader = "Priority"
        static let dueDateLabel = "Due Date: "
        static let priorityLabel = "Priority: "
        static let completedLabel = "Completed"
        static let notCompletedLabel = "Not Completed"
        static let markAsIncompleteButton = "Mark as Incomplete"
        static let markAsCompleteButton = "Mark as Complete"
        static let editButton = "Edit"
        static let cancelButton = "Cancel"
        static let saveButton = "Save"
    }

    enum Priority {
        static let low = "Low"
        static let medium = "Medium"
        static let high = "High"
        static let all = "All"
    }
}
