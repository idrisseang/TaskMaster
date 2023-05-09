//
//  TaskDetailView.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var task: Task

    var body: some View {
        VStack(alignment: .leading) {
            taskHeader
            subtasksList
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
            }
            Divider()
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 20))
                    .foregroundColor(Color("AccentBlue"))
                Text(formatDate(date: task.date ?? Date(), isIncludingHour: false))
                    .font(.system(size: 18))
            }
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
    }

    @ViewBuilder private var subtasksList: some View {
        VStack(alignment: .leading) {
            Text("Sous-tâches")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 10)
            HStack {
                Button {
                    //
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .semibold))
                    Text("Ajouter une sous-tâche")
                        .font(.system(size: 20, weight: .semibold))
                }
                .foregroundColor(Color("AccentBlue"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: previewTasks[0])
    }
}
