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
    @State private var taskDate: Date? = Date()
    @State private var currentDate = Date()
    @State private var selectedCategories: [String] = []
    @State private var selectedCategory: String = ""
    @State private var isInSelectionMode: Bool = true
    @State private var hide: Bool = false
    @Binding  var isShowingHour: Bool
    var onTaskCreated: (Task) -> Void
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text(taskName == "" ? "Nouvelle Tâche" : taskName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 32)
                    .foregroundColor(Color.black)
                Text("Catégorie : \(selectedCategory)")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color(white: 0.4))
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
                            currentDate: $taskDate) {
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
                            currentDate: $taskDate) {
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
                            currentDate: $taskDate) {
                            withAnimation {
                                hide = true
                                isShowingHour = true
                            }
                        }
                        ChooseDateHourButton(date: $taskDate, hide: $hide)
                    } else {
                        DateChoosen(date: currentDate, isShowingHour: isShowingHour) {
                            withAnimation {
                                hide = false
                                taskDate = Date()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    AccentButton(name: "Ajouter", color: .black, action: {
                        let newTask = Task(name: taskName, date: taskDate, category: selectedCategory)
                        onTaskCreated(newTask)
                        presentationMode.wrappedValue.dismiss()
                    })
            }
        }
        .padding()
        .background(Color("lightBlue"))
        .preferredColorScheme(.dark)
    }
}

struct TaskCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationScreen(isShowingHour: .constant(false)) {_ in
            return
        }
    }
}
