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
            VStack(alignment: .leading) {
                subtasksList
                addSubtaskButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .sheet(isPresented: $isShowingSubtaskCreationScreen, content: {
            SubtaskCreationView(task: task)
                .presentationDetents([.height(200)])
        })
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
                Text(formatDate(date: task.date ?? Date(), isIncludingHour: false))
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
    }

    @ViewBuilder private var subtasksList: some View {
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
                    Divider()
                }
            }
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
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: previewTasks[0])
    }
}
