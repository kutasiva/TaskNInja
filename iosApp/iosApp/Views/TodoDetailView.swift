//
//  Untitled.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct TodoDetailView: View {
    @Binding var todoItem: TodoItem
    @State private var editMode: EditMode = .inactive
    @State private var draftTodoItem: TodoItem

    init(todoItem: Binding<TodoItem>) {
        self._todoItem = todoItem
        self._draftTodoItem = State(initialValue: todoItem.wrappedValue)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Padding.medium) {
            if editMode == .active {
                TextField(Strings.TodoDetailView.titleSectionHeader, text: $draftTodoItem.title)
                    .font(.largeTitle)
                    .padding(.bottom, Padding.small)
                TextField(Strings.TodoDetailView.descriptionSectionHeader, text: $draftTodoItem.description)
                    .font(.body)
                DatePicker(Strings.TodoDetailView.dueDateSectionHeader, selection: Binding(
                    get: { draftTodoItem.dueDate },
                    set: { draftTodoItem.dueDate = $0 }
                ), displayedComponents: .date)
                    .font(.body)
                Picker(Strings.TodoDetailView.prioritySectionHeader, selection: $draftTodoItem.priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.displayName).tag(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                // Checkbox to mark as complete or incomplete
                Toggle(isOn: $draftTodoItem.isCompleted) {
                    Text(draftTodoItem.isCompleted ? Strings.TodoDetailView.markAsIncompleteButton : Strings.TodoDetailView.markAsCompleteButton)
                        .foregroundColor(draftTodoItem.isCompleted ? .green : .red)
                }
            } else {
                Text(todoItem.title)
                    .font(.largeTitle)
                    .strikethrough(todoItem.isCompleted, color: .gray)
                    .padding(.bottom, Padding.small)
                Text(todoItem.description)
                    .font(.body)
                    .foregroundColor(todoItem.isCompleted ? .gray : .primary)

                Text("\(Strings.TodoDetailView.dueDateLabel) \(todoItem.dueDate, formatter: dateFormatter)")
                    .font(.body)
                    .foregroundColor(todoItem.isCompleted ? .gray : .primary)

                Text("\(Strings.TodoDetailView.priorityLabel) \(todoItem.priority.displayName)")
                    .font(.body)
                    .foregroundColor(todoItem.isCompleted ? .gray : todoItem.priority.color)
                HStack {
                    Text(todoItem.isCompleted ? Strings.TodoDetailView.completedLabel : Strings.TodoDetailView.notCompletedLabel)
                        .foregroundColor(todoItem.isCompleted ? .green : .red)
                    Spacer()
                    if todoItem.isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .shadow(color: .green.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                }
            }

            Spacer()

            if editMode == .active {
                HStack {
                    Button(action: {
                        // Cancel action
                        draftTodoItem = todoItem
                        editMode = .inactive
                    }) {
                        Text(Strings.TodoDetailView.cancelButton)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    Button(action: {
                        // Save action (implicit)
                        todoItem = draftTodoItem
                        editMode = .inactive
                    }) {
                        Text(Strings.TodoDetailView.saveButton)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            .padding(.leading, Padding.small)
                    }
                }
            }
        }
        .padding()
        .navigationBarItems(trailing: editMode == .inactive ? Button(action: {
            editMode = .active
        }) {
            Text(Strings.TodoDetailView.editButton)
        } : nil)
        .onAppear {
            // Initialize draft item with the current state of todoItem
            draftTodoItem = todoItem
        }
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    @State static var previewItem = TodoItem(
        id: 1,
        userId: 1,
        title: "Sample Title",
        description: "Sample Description",
        dueDate: Date(),
        priority: .high,
        isCompleted: true
    )

    static var previews: some View {
        TodoDetailView(todoItem: $previewItem)
    }
}
