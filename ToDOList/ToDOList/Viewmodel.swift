//
//  Viewmodel.swift
//  ToDOList
//
//  Created by Guest User on 11/02/25.
//

import Foundation
class TodoListViewModel: ObservableObject {
    @Published var todoItems: [ToDo] {
        didSet {
            saveTodoItems()
        }
    }
    private let userDefaults = UserDefaults.standard
    private let todoItemsKey = "TodoItems"
    init() {
        if let data = userDefaults.data(forKey: todoItemsKey),
           let savedTodoItems = try? JSONDecoder().decode([ToDo].self, from: data) {
            todoItems = savedTodoItems
        } else {
            todoItems = []
        }
    }
    func addTodoItem(title: String) {
        let trimmedItem = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedItem.isEmpty else { return }
        let newTodo = ToDo(title: trimmedItem)
        todoItems.append(newTodo)
    }
    func deleteTodoItem(atOffsets offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    func toggleTodoItemCompletion(_ item: ToDo) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isComplete.toggle()
        }
    }
    private func saveTodoItems() {
        if let encoded = try? JSONEncoder().encode(todoItems) {
            userDefaults.set(encoded, forKey: todoItemsKey)
        }
    }
}
