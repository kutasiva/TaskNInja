//
//  TodoListView.swift
//  iosApp
//
//  Created by kutasov on 13.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import shared
import SwiftUI

struct TodoListView: View {
    @ObservedObject private(set) var viewModel: TodoViewModelWrapper

    var body: some View {
        NavigationView {
            VStack {
                Picker(Strings.TodoListView.filterByPriority, selection: Binding(
                    get: { viewModel.selectedPriority },
                    set: { newValue in
                        viewModel.setPriorityFilter(newValue)
                    }
                )) {
                    Text(Strings.Priority.all).tag(Priority?.none)
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.displayName).tag(Priority?.some(priority))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button(action: {
                    viewModel.toggleSortOrder()
                }) {
                    HStack {
                        Text(viewModel.sortAscending ? Strings.TodoListView.sortByDateAsc : Strings.TodoListView.sortByDateDesc)
                        Image(systemName: viewModel.sortAscending ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                    }
                }
                .padding()

                switch viewModel.todoState {
                case is TodoState.Loading:
                    ProgressView()
                case is TodoState.Error:
                    if let errorState = viewModel.todoState as? TodoState.Error {
                        Text(errorState.message)
                            .foregroundColor(.red)
                    }
                case is TodoState.Success:
                    List {
                        ForEach(viewModel.filteredTodos) { item in
                            HStack {
                                Button(action: {
                                    viewModel.toggleTodoItemCompletion(item)
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(item.isCompleted ? .green : .gray)
                                        .padding()
                                }
                                .buttonStyle(BorderlessButtonStyle())

                                NavigationLink(destination: TodoDetailView(todoItem: Binding(
                                    get: { item },
                                    set: { newValue in
                                        viewModel.updateTodoItem(newValue)
                                    }
                                ))) {
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .font(.headline)
                                            .strikethrough(item.isCompleted, color: .gray)
                                        Text(item.description)
                                            .font(.subheadline)
                                            .foregroundColor(item.isCompleted ? .gray : .primary)
                                        Text("\(Strings.TodoDetailView.dueDateLabel) \(item.dueDate, formatter: dateFormatter)")
                                            .font(.subheadline)
                                            .foregroundColor(item.isCompleted ? .gray : .primary)

                                        Text("\(Strings.TodoDetailView.priorityLabel) \(item.priority.displayName)")
                                            .font(.subheadline)
                                            .foregroundColor(item.isCompleted ? .gray : item.priority.color)
                                    }
                                }
                            }
                            .padding(.vertical, Padding.small)
                        }
                    }
                    .refreshable {
                        viewModel.refreshTodos()
                    }
                default:
                    EmptyView()
                }
            }
            .navigationTitle(Strings.TodoListView.navigationTitle)
        }
        .task {
            await viewModel.startObserving()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: .init())
    }
}
