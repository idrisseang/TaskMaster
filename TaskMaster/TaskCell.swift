//
//  TaskCell.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var task: Task
    @State private var date: Date?
    @State private var hide = false
    @State private var isShowingDatePickerScreen = false

    var body: some View {
        VStack {
            HStack {
                isFinishedTaskButton
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
                    TaskName(isFinished: task.isFinished, task: task)
                    if task.date != nil {
                        Text("\(formatDate(date: (hide ? date : task.date)!, isIncludingHour: task.showingHour))")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(Color(white: 0.4))
                    }
                    HStack {
                        Image(systemName: "list.bullet.indent")
                            .font(.callout)
                        Text("\(task.subtasks.count)")
                            .font(.callout)
                        Spacer()
                        Text("priorité")
                        Image(systemName:
                                task.priority?.rawValue == "Faible" ? "flag" : "flag.fill"
                        )
                        .foregroundColor(priorityColor(for: task.priority!.rawValue))
                    }
                    .foregroundColor(Color(white: 0.4))
                }
                .padding()
                Spacer()
                TaskCategory(task: task, frame: 65, color: Color("lightBlue"))
            }
        }
        .padding()
        .padding(.horizontal, 1)
        .background(.white)
        .cornerRadius(32)
        .sheet(isPresented: $isShowingDatePickerScreen) {
            DatePickerScreen(date: $date, isShowingHour: $task.showingHour, hide: $hide)
        }
    }

    @ViewBuilder private var isFinishedTaskButton: some View {
        Button {
            task.isFinished.toggle()
        } label: {
            Image(systemName: task.isFinished ? "circle.circle.fill" : "circle.circle")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(task.isFinished ? Color("lightBlue") : Color(white: 0.4))
        }
    }
}
struct TaskName: View {
    let isFinished: Bool
    let task: Task

    var body: some View {
        if !isFinished {
            Text(task.name)
                .font(.headline)
                .foregroundColor(.black)
        } else {
            Text(task.name)
                .font(.system(size: 18, weight: .light))
                .foregroundColor(Color(white: 0.4))
                .strikethrough(true, pattern: .solid, color: .black)
        }
    }
}

struct TaskCategory: View {
    let task: Task
    let frame: CGFloat
    let color: Color

    var body: some View {
        Circle()
            .frame(width: frame, height: frame)
            .foregroundColor(color)
            .opacity(0.7)
            .overlay {
                Button {
                } label: {
                    Image(task.category)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
    }
}
struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: previewTasks[4])
            .padding(24)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
