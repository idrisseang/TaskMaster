//
//  SubtaskCreationView.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import SwiftUI

struct SubtaskCreationView: View {
    @State private var subtaskName: String = ""
    @State private var subtaskDate: Date?
    @State private var currentDate = Date()
    @State private var isInSelectionMode: Bool = true
    @State private var hide: Bool = false
    @State private var isShowingDatePickerScreen: Bool = false
    @State private var isShowingHour = false
    @Environment (\.presentationMode) var presentationMode
    let task: Task
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Nom de la tâche", text: $subtaskName)
                .font(.system(size: 24))
                .padding()
                .focused($focusedField, equals: .subtaskName)
                .padding(.bottom)
            DateButtonsSection(isInSelectionMode: $isInSelectionMode,
                        hide: $hide,
                        date: $subtaskDate,
                        isShowingHour: $isShowingHour,
                        isShowingDatePickerScreen: $isShowingDatePickerScreen)
            .padding(.leading)
            Divider()
            HStack {
                TaskCategory(task: task, frame: 55, color: Color("AccentBlue"))
                Spacer()
                addSubtaskButton
            }
            .padding()
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            focusedField = .subtaskName
        }
        .sheet(isPresented: $isShowingDatePickerScreen) {
            DatePickerScreen(date: $subtaskDate, isShowingHour: $isShowingHour, hide: $hide)
        }
    }
    private enum Field: Int, Hashable {
        case subtaskName
    }

    @ViewBuilder private var addSubtaskButton: some View {
        Button {
            if !subtaskName.isEmpty {
                let newSubtask = Subtask(name: subtaskName, date: subtaskDate, showingHour: isShowingHour)
                task.subtasks.append(newSubtask)
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Image(systemName: "arrow.up.circle.fill")
                .foregroundColor(Color("AccentBlue"))
                .font(.system(size: 40))
                .opacity(subtaskName.isEmpty ? 0.5 : 1)
        }
    }
}
struct SubtaskCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SubtaskCreationView(task: previewTasks[0])
    }
}
