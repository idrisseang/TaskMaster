//
//  TaskCell.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct TaskCell: View {
    let task : Task
    @State private var isFinishedTask = false
    @State private var isDetailedMode = false
    @Binding var isShowingHour : Bool
    let onDelete : () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    isFinishedTask.toggle()
                } label: {
                    Image(systemName: isFinishedTask ? "circle.circle.fill" : "circle.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(isFinishedTask ? Color("lightBlue") : Color(white:0.4))
                }
                Spacer()
                VStack(spacing: 12) {
                    if !isFinishedTask {
                        Text(task.name)
                            .font(.headline)
                            .foregroundColor(.black)
                    } else {
                        Text(task.name)
                            .font(.system(size: 18,weight: .light))
                            .foregroundColor(Color(white:0.4))
                            .strikethrough(true,pattern: .solid,color:.black)
                    }
                    Text("\(formatDate(date: task.date ?? Date(), isIncludingHour: isShowingHour))")
                        .font(.system(size: 16,weight: .light))
                        .foregroundColor(Color(white:0.4))
                }
                .padding()
                Spacer()
                Circle()
                    .frame(width: 65,height: 65)
                    .foregroundColor(Color("lightBlue"))
                    .opacity(0.7)
                    .overlay{
                        Button {
                            //
                        } label: {
                            Image(task.category)
                                .resizable()
                                .frame(width: 40,height: 40)
                        }
                    }
            }
            Image(task.category)
                .resizable()
                .frame(width: 40,height: 40)
            
        }
        if isDetailedMode && isFinishedTask {
            HStack{
                Button {
                    onDelete()
                } label: {
                    Text("Supprimer")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .padding(.horizontal,12)
            .background(.white)
            .cornerRadius(32)
            .onTapGesture {
                withAnimation {
                    isDetailedMode.toggle()
                }
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: previewTasks[1], isShowingHour: .constant(true),onDelete: {})
            .padding(24)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
