//
//  TaskCreationScreen.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 09/04/2023.
//

import SwiftUI

struct TaskCreationScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var taskName = ""
    @State private var taskDate: Date?
    @State private var currentDate = Date()
    @State private var selectedCategories: [String] = []
    @State private var selectedCategory: String = ""
    @State private var isInSelectionMode: Bool = true
    @State private var hide: Bool = false
    @State private var isShowingAlert = false
    @State private var selectedPriority: String = ""
    @Binding  var isShowingHour: Bool
    @State private var isShowingDatePickerScreen: Bool = false
    var onTaskCreated: (Task) -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                Text(taskName == "" ? "Nouvelle Tâche" : taskName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 32)
                    .foregroundColor(Color.black)
                Text("Catégorie : \(selectedCategory)")
                    .font(.headline)
                    .foregroundColor(Color(white: 0.4))
                HStack {
                    Text("priorité : ")
                        .foregroundColor(Color(white: 0.4))
                        .font(.headline)
                    if !selectedPriority.isEmpty {
                        Image(systemName: selectedPriority == "Faible" ? "flag" : "flag.fill")
                            .foregroundColor(priorityColor(for: selectedPriority))
                    }
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Nom de la tâche")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                TextField("", text: $taskName)
                    .foregroundColor(.black)
                    .submitLabel(.done)
                    .padding(12)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(.infinity)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Categorie")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                    .padding(-7)
                CategorySelector(
                    selectedCategories: $selectedCategories,
                    selectedCategory: $selectedCategory,
                    isTaskCreationScreen: .constant(true) )
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Date d'échéance")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                HStack {
                    if isInSelectionMode && !hide {
                        DatePickerButton(
                            title: "Aujourd'hui",
                            timeVariation: .day,
                            value: 0,
                            iconName: "sun.max",
                            currentDate: $taskDate, hide: $hide) {
                                withAnimation {
                                    hide = true
                                    isShowingHour = false
                                }
                            }
                        DatePickerButton(
                            title: "Demain",
                            timeVariation: .day,
                            value: 1,
                            iconName: "sunrise",
                            currentDate: $taskDate, hide: $hide) {
                                withAnimation {
                                    hide = true
                                    isShowingHour = false
                                }
                            }
                        DatePickerButton(
                            title: "Dans 1h",
                            timeVariation: .hour,
                            value: 1,
                            iconName: "hourglass",
                            currentDate: $taskDate, hide: $hide) {
                                withAnimation {
                                    hide = true
                                    isShowingHour = true
                                }
                            }
                        DatePickerButton(
                            title: "Date et Heure",
                            timeVariation: .day,
                            value: 0,
                            iconName: "calendar.badge.clock",
                            currentDate: $taskDate, hide: $hide) {
                                isShowingDatePickerScreen = true
                            }
                    } else {
                        DateChoosen(date: taskDate ?? Date(), isShowingHour: $isShowingHour) {
                            withAnimation {
                                hide = false
                            }
                            taskDate = Date()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Priorité")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.black)
                    PrioritySelector(selectedPriority: $selectedPriority)
                }
                Spacer()
                AccentButton(name: "Ajouter", color: .black, action: {
                    if selectedCategory.isEmpty {
                        isShowingAlert = true
                        selectedCategory = "all"
                    } else {
                        let newTask = Task(
                            name: taskName,
                            date: taskDate,
                            category: selectedCategory.isEmpty ? "all" : selectedCategory,
                            showingHour: isShowingHour,
                            subtasks: [],
                            priority: Priority(rawValue: selectedPriority))
                        onTaskCreated(newTask)
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Hé attends... ⚠️ "),
                    message: Text("Tu n'as choisi aucune catégorie pour ta tâche. La catégorie par défaut sera All."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
        .background(Color("lightBlue"))
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isShowingDatePickerScreen) {
            DatePickerScreen(date: $taskDate, isShowingHour: $isShowingHour, hide: $hide)
        }
    }
}

struct TaskCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationScreen(isShowingHour: .constant(false)) {_ in
            return
        }
    }
}
