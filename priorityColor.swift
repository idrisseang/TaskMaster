//
//  priorityColor.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 12/05/2023.
//

import Foundation
import SwiftUI
func priorityColor(for selectedPriority: String) -> Color {
    var color: Color
    switch selectedPriority {
    case "Urgent":
        color = .red
    case "Important":
        color = .orange
    case "Moyenne":
        color = .green
    case "Faible":
        color = Color(white: 0.4)
    default:
        color = .black
    }
    return color
}
