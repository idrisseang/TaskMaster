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
            header
            Spacer()
            taskSection
            Spacer()
            categorySection
            Spacer()
            VStack(alignment: .leading) {
                dateSection
                Spacer()
                prioritySection
                Spacer()
                addTaskButton
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

    @ViewBuilder private var header: some View {
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
    }

    @ViewBuilder private var taskSection: some View {
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
    }

    @ViewBuilder private var categorySection: some View {
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
    }

    @ViewBuilder private var dateSection: some View {
        Text("Date d'échéance")
            .font(.title2)
            .bold()
            .foregroundColor(Color.black)
        DateButtonsSection(isInSelectionMode: $isInSelectionMode,
                    hide: $hide,
                    date: $taskDate,
                    isShowingHour: $isShowingHour,
                    isShowingDatePickerScreen: $isShowingDatePickerScreen)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder private var prioritySection: some View {
        VStack(alignment: .leading) {
            Text("Priorité")
                .font(.title2)
                .bold()
                .foregroundColor(Color.black)
            PrioritySelector(selectedPriority: $selectedPriority)
        }
    }

    @ViewBuilder private var addTaskButton: some View {
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
                    priority: selectedPriority.isEmpty ?
                    Priority(rawValue: "Faible") : Priority(rawValue: selectedPriority))
                onTaskCreated(newTask)
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}

struct TaskCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationScreen(isShowingHour: .constant(false)) {_ in
            return
        }
    }
}
