//
//  Priority.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 12/05/2023.
//

import Foundation

enum Priority: String, Codable, CaseIterable {
    case urgent = "Urgent"
    case important = "Important"
    case moyenne = "Moyenne"
    case faible = "Faible"
}
