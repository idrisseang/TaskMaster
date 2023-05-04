//
//  TaskCell.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var task: Task
    @State private var isFinishedTask = false
    @State private var isDetailedMode = false
    @State private var date: Date?
    @State private var isEditingMode = false
    @FocusState private var focusedField: Field?
    let onDelete: () -> Void
    var body: some View {
        VStack {
            HStack {
                Button {
                    isFinishedTask.toggle()
                } label: {
                    Image(systemName: isFinishedTask ? "circle.circle.fill" : "circle.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(isFinishedTask ? Color("lightBlue") : Color(white: 0.4))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
                    if !isFinishedTask {
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
                        Text("\(formatDate(date: task.date!, isIncludingHour: task.showingHour))")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(Color(white: 0.4))
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
            if isDetailedMode && isFinishedTask {
                HStack {
                    Button {
                        onDelete()
                    } label: {
                        Text("Supprimer")
                            .foregroundColor(.red)
                    }
                }
            }
            if isDetailedMode && !isFinishedTask {
                HStack {
                    Button {
                        isEditingMode = true
                        focusedField = .taskName
                    } label: {
                        Text("Renommer")
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        //
                    } label: {
                        Text("Changer date")
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(Color("AccentBlue"))
            }
        }
        .padding()
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(32)
        .onTapGesture {
            withAnimation {
                isDetailedMode.toggle()
            }
        }
    }
    
    private enum Field: Int, Hashable {
        case taskName
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: previewTasks[0], onDelete: {})
            .padding(24)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
