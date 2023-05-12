//
//  Subtask.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import Foundation

class Subtask: TaskProtocol, ObservableObject {
    var id = UUID()
    var name: String
    var date: Date?
    var showingHour: Bool
    @Published var isFinished: Bool

    init(name: String, date: Date? = nil, showingHour: Bool = false, isFinished: Bool = false) {
        self.name = name
        self.date = date
        self.showingHour = showingHour
        self.isFinished = isFinished
    }
        enum CodingKeys: CodingKey {
            case id
            case name
            case date
            case showingHour
            case isFinished
        }

        required init (from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(UUID.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.date = try container.decode(Date.self, forKey: .date)
            self.showingHour = try container.decode(Bool.self, forKey: .showingHour)
            self.isFinished = try container.decode(Bool.self, forKey: .isFinished)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(date, forKey: .date)
            try container.encode(showingHour, forKey: .showingHour)
            try container.encode(isFinished, forKey: .isFinished)
        }
}
