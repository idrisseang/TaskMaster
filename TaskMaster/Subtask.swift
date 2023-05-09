//
//  Subtask.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import Foundation

class Subtask: TaskProtocol {
    var id = UUID()
    var name: String
    var date: Date?
    var showingHour: Bool

    init(name: String, date: Date? = nil, showingHour: Bool = false) {
        self.name = name
        self.date = date
        self.showingHour = showingHour
    }
}
