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
                Text(task.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
            Divider()
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 20))
                    .foregroundColor(Color("AccentBlue"))
                Text(formatDate(date: task.date ?? Date(), isIncludingHour: task.showingHour))
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
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
                        Button {
                            //
                        } label: {
                            Image(systemName: "circle.circle")
                                .foregroundColor(Color("AccentBlue"))
                                .font(.system(size: 24))
                        }
                        Text(subtask.name)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding()
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
            addSubtaskButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder private var addSubtaskButton: some View {
        HStack {
            Button {
                isShowingSubtaskCreationScreen = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                Text("Ajouter une sous-tâche")
                    .font(.system(size: 20, weight: .semibold))
            }
            .foregroundColor(Color("AccentBlue"))
        }
        .padding(.top)
    }

    @ViewBuilder private func toolbar() -> some View {
        Menu {
            Button {
                //
            } label: {
                Label("Renommer", systemImage: "pencil")
            }
            Button(role: .destructive) {
                //
            } label: {
                Label("Supprimer", systemImage: "trash")
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.primary)
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: previewTasks[0])
    }
}
