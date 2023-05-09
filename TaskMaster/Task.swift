//
//  Task.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import Foundation

class Task: TaskProtocol, ObservableObject {
    var id: UUID = UUID()
    var name: String
    var date: Date?
    var category: String
    var showingHour: Bool

    init(name: String, date: Date? = nil, category: String, showingHour: Bool) {
        self.name = name
        self.date = date
        self.category = category
        self.showingHour = showingHour
    }

    enum CodingKeys: CodingKey {
        case id
        case name
        case date
        case category
        case showingHour
    }

    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.date = try container.decode(Date.self, forKey: .date)
        self.category = try container.decode(String.self, forKey: .category)
        self.showingHour = try container.decode(Bool.self, forKey: .showingHour)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(category, forKey: .category)
        try container.encode(showingHour, forKey: .showingHour)
    }
}
