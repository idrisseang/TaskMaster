//
//  TaskProtocol.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 12/05/2023.
//

import Foundation

protocol TaskProtocol: Identifiable, Codable {
    var id: UUID { get set }
    var name: String { get set }
    var date: Date? { get set }
    var showingHour: Bool { get set }
}
