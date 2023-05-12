//
//  TaskCell.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var task: Task
    @State private var isDetailedMode = false
    @State private var date: Date?
    @State private var isEditingMode = false
    @State private var isShowingDatePickerScreen = false
    @State private var hide = false
    @FocusState private var focusedField: Field?
    let onDelete: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button {
                    task.isFinished.toggle()
                } label: {
                    Image(systemName: task.isFinished ? "circle.circle.fill" : "circle.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(task.isFinished ? Color("lightBlue") : Color(white: 0.4))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
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
                    if task.date != nil {
                        Text("\(formatDate(date: (hide ? date : task.date)!, isIncludingHour: task.showingHour))")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(Color(white: 0.4))
                    }
                    HStack {
                        Image(systemName: "list.bullet.indent")
                            .font(.callout)
                            .foregroundColor(Color(white: 0.4))
                        Text("\(task.subtasks.count)")
                            .font(.callout)
                            .foregroundColor(Color(white: 0.4))
                        Spacer()
                        Text("priorité")
                            .foregroundColor(Color(white: 0.4))
                        Image(systemName:
                                task.priority?.rawValue == "Faible" ? "flag" : "flag.fill"
                        )
                            .foregroundColor(priorityColor(for: task.priority!.rawValue))
                    }
                }
                .padding()
                Spacer()
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundColor(Color("lightBlue"))
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
            if isDetailedMode && task.isFinished {
                HStack {
                    Button {
                        onDelete()
                    } label: {
                        Text("Supprimer")
                            .foregroundColor(.red)
                    }
                }
            }
            if isDetailedMode && !task.isFinished {
                HStack {
                    Button {
                        isEditingMode = true
                        focusedField = .taskName
                    } label: {
                        Text("Renommer")
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        isShowingDatePickerScreen = true
                    } label: {
                        Text("Changer date")
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(Color("AccentBlue"))
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

    private enum Field: Int, Hashable {
        case taskName
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: previewTasks[4], onDelete: {})
            .padding(24)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
