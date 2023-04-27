//
//  Task.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import Foundation

class Task : Identifiable, Codable{
    var id = UUID()
    let name : String
    var date : Date?
    let category : String
    
    init(name : String , date : Date?, category : String) {
        self.name = name
        self.date = nil
        self.category = category
    }
    
    enum CodingKeys : CodingKey {
        case id
        case name
        case date
        case category
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.date = try container.decode(Date.self, forKey: .date)
        self.category = try container.decode(String.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(category, forKey: .category)
    }
}
