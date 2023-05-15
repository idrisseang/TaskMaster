//
//  TaskDetailView.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var task: Task
    @State private var isShowingSubtaskCreationScreen = false
    @EnvironmentObject var tasksList: TaskList
    @FocusState private var focusedField: Field?
    @State private var isEditingMode = false
    @State private var isShowingDatePickerScreen = false
    @State private var hide = false

    var body: some View {
        VStack(alignment: .leading) {
            taskHeader
            subtasksSection
                .toolbar {
                    toolbar()
                }
                .sheet(isPresented: $isShowingSubtaskCreationScreen, content: {
                    SubtaskCreationView(task: task)
                        .presentationDetents([.height(200)])
                })
                .sheet(isPresented: $isShowingDatePickerScreen) {
                    DatePickerScreen(date: $task.date, isShowingHour: $task.showingHour, hide: $hide)
                }
        }
        .padding(.top)
        .padding()
        .background(Color("lightBlue"))
    }

    @ViewBuilder private var taskHeader: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "circle.circle")
                    .font(.system(size: 20))
                    .foregroundColor(Color("AccentBlue"))
                if !task.isFinished {
                    if isEditingMode {
                        TextField("", text: $task.name)
                            .focused($focusedField, equals: .taskName)
                            .font(.headline)
                            .foregroundColor(.black)
                            .submitLabel(.done)
                    } else {
                        Text(task.name)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                } else {
                    Text(task.name)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color(white: 0.4))
                        .strikethrough(true, pattern: .solid, color: .black)
                }
            }
            Divider()
            HStack {
                if task.date != nil {
                Image(systemName: "calendar")
                    .font(.system(size: 20))
                    .foregroundColor(Color("AccentBlue"))
                    Text(formatDate(date: task.date!, isIncludingHour: task.showingHour))
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .onTapGesture {
                                isShowingDatePickerScreen = true
                        }
                } else {
                    addButton(text: "Ajouter une date", isShowingVar: $isShowingDatePickerScreen)
                }
            }
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
    }
    struct SubtaskCell: View {

        @ObservedObject var subtask: Subtask

        var body: some View {
            HStack {
                Button {
                    withAnimation {
                        subtask.isFinished.toggle()
                    }
                } label: {
                    Image(systemName: subtask.isFinished ? "circle.circle.fill" : "circle.circle")
                        .foregroundColor(Color("AccentBlue"))
                        .font(.system(size: 24))
                }
                if subtask.isFinished {
                    Text(subtask.name)
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color(white: 0.4))
                        .strikethrough(true, pattern: .solid, color: .black)
                } else {
                    Text(subtask.name)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                }
            }
        }
    }
    @ViewBuilder private var subtasksSection: some View {
        VStack(alignment: .leading) {
            Text("Sous-tâches")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            if !task.subtasks.isEmpty {
                ForEach(task.subtasks) {subtask in
                    HStack {
                        SubtaskCell(subtask: subtask)
                    }
                    if subtask.date != nil {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color("AccentBlue"))
                            Text(formatDate(date: subtask.date!, isIncludingHour: subtask.showingHour))
                                .foregroundColor(.black)
                        }
                        .frame(width: 250, height: 10, alignment: .trailing)
                    }
                    Divider()
                }
            }
            addButton(text: "Ajouter une sous-tâche", isShowingVar: $isShowingSubtaskCreationScreen)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder private func addButton(text: String, isShowingVar: Binding<Bool>) -> some View {
        HStack {
            Button {
                isShowingVar.wrappedValue = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                Text(text)
                    .font(.system(size: 20, weight: .semibold))
            }
            .foregroundColor(Color("AccentBlue"))
        }
        .padding(.top)
    }

    @ViewBuilder private func toolbar() -> some View {
        Menu {
            Button {
                isEditingMode = true
                focusedField = .taskName
            } label: {
                Label("Renommer", systemImage: "pencil")
            }
            Button(role: .destructive) {
                tasksList.tasks.removeAll { element in
                    element.id == task.id
                }
            } label: {
                Label("Supprimer", systemImage: "trash")
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.black)
        }
    }

    private enum Field: Int, Hashable {
        case taskName
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: previewTasks[0])
    }
}
