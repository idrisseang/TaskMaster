//
//  previewData.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import Foundation

let previewTasks = [
    Task(name: "Ranger ma chambre", date: Date(), category: Category.maison.rawValue,
         showingHour: true, subtasks: [Subtask(name: "Balayer")]),
    Task(name: "Appeler 3 clients", date: Date(), category: Category.business.rawValue,
         showingHour: false, subtasks: [Subtask(name: "Balayer")]),
    Task(name: "Finir de classer les dossiers", date: Date(), category: Category.travail.rawValue,
         showingHour: true, subtasks: [Subtask(name: "Balayer")]),
    Task(name: "Finir la formation", date: Date(), category: Category.learning.rawValue,
         showingHour: false, subtasks: [Subtask(name: "Balayer")]),
    Task(name: "Faire 10 min de running", date: Date(), category: Category.workout.rawValue,
         showingHour: true, subtasks: [Subtask(name: "Balayer")])
]
