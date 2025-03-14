//
//  RandomValuesStore.swift
//  iosApp
//
//  Created by kutasov on 14.03.2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

class RandomValuesStore {
    private var store: [Int: (description: String, dueDate: Date, priority: Priority)] = [:]

    func getValues(for id: Int) -> (description: String, dueDate: Date, priority: Priority) {
        if let randomValues = store[id] {
            return randomValues
        } else {
            let description = randomDescription()
            let dueDate = randomFutureDate()!
            let priority = randomPriority()
            let randomValues = (description, dueDate, priority)
            store[id] = randomValues
            return randomValues
        }
    }

    func updateValues(for item: TodoItem) {
        store[item.id] = (item.description, item.dueDate, item.priority)
    }

    private func randomDescription() -> String {
        let descriptions = [
            "This is a sample task description.",
            "Remember to complete this task on time.",
            "This task is high priority.",
            "Don't forget about this task!",
            "This is a random task description.",
            "Ensure to follow up on this task."
        ]
        return descriptions.randomElement() ?? "Default task description"
    }

    private func randomFutureDate() -> Date? {
        let now = Date()
        let oneYearAhead = Calendar.current.date(byAdding: .year, value: 1, to: now)!
        let randomTimeInterval = TimeInterval(arc4random_uniform(UInt32(oneYearAhead.timeIntervalSince(now))))
        return now.addingTimeInterval(randomTimeInterval)
    }

    private func randomPriority() -> Priority {
        return Priority.allCases.randomElement() ?? .medium
    }
}
