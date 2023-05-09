//
//  SubtaskCreationView.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 09/05/2023.
//

import SwiftUI

struct SubtaskCreationView: View {
    @State private var subtaskName: String = ""
    @Environment (\.presentationMode) var presentationMode
    let task: Task
    @FocusState private var focusedField: Field?
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Nom de la tâche", text: $subtaskName)
                .font(.system(size: 24))
                .padding()
                .focused($focusedField, equals: .subtaskName)
            Divider()
            HStack {
                Text("Catégorie")
                    .font(.headline)
                    .foregroundColor(Color("AccentBlue"))
                Spacer()
                Button {
                    if !subtaskName.isEmpty {
                        let newSubtask = Subtask(name: subtaskName)
                        task.subtasks.append(newSubtask)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(Color("AccentBlue"))
                        .font(.system(size: 28))
                        .opacity(subtaskName.isEmpty ? 0.5 : 1)
                }
            }
            .padding()
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            focusedField = .subtaskName
        }
    }
    private enum Field: Int, Hashable {
        case subtaskName
    }
}
struct SubtaskCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SubtaskCreationView(task: previewTasks[0])
    }
}
