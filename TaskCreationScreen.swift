//
//  TaskCreationScreen.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 09/04/2023.
//

import SwiftUI

struct TaskCreationScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var taskName = ""
    @State private var taskDate : Date?
    @State private var currentDate = Date()
    @State private var selectedCategories : [String] = []
    @State private var isInSelectionMode : Bool = true
    @State private var hide : Bool = false
    @State private var isShowingHour : Bool = true
    var onTaskCreated : (Task) -> Void
    var body: some View {
        VStack(spacing : 24){
            VStack(spacing: 16){
                Text(taskName == "" ? "Nouvelle Tâche" : taskName)
                    .font(.system(size: 32,weight:.bold))
                    .padding(.top,32)
                    .foregroundColor(Color.black)
                Text("Catégories : \(selectedCategories.joined(separator: ", "))")
                    .font(.system(size: 20,weight: .light))
                    .foregroundColor(Color(white:0.4))
                
            }
            Spacer()
            VStack(alignment: .leading){
                Text("Nom de la tâche")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                TextField("",text:$taskName)
                    .foregroundColor(.black)
                    .submitLabel(.done)
                    .padding(12)
                    .padding(.horizontal,12)
                    .background(Color.white)
                    .cornerRadius(.infinity)
                    
                    
            }
            Spacer()
           
            VStack(alignment: .leading){
                Text("Categorie")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                CategorySelector(selectedCategories: $selectedCategories)
                    .padding(-7)
                
            }
            Spacer()
            
            VStack(alignment : .leading){
                Text("Date d'échéance")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.black)
                HStack{
                    if isInSelectionMode && !hide{
                        DatePickerButton(title: "Aujourd'hui", timeVariation: .day, value: 0, iconName: "sun.max", currentDate: $currentDate) {
                            withAnimation {
                                hide = true
                                isShowingHour = false
                            }
                        }
                        DatePickerButton(title: "Demain", timeVariation: .day, value: 1, iconName: "sunrise", currentDate: $currentDate) {
                            withAnimation {
                                hide = true
                                isShowingHour = false
                            }
                        }
                        DatePickerButton(title: "Dans 1h", timeVariation: .hour, value: 1, iconName: "hourglass", currentDate: $currentDate) {
                            withAnimation {
                                hide = true
                                isShowingHour = true
                            }
                        }
                        
                        ChooseDateHourButton(date: $taskDate, hide: $hide)
                        
                    }else{
                        DateChoosen(date: $taskDate, isShowingHour: isShowingHour) {
                                withAnimation {
                                    hide = false
                                }
                            currentDate = Date()
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            Spacer()
            AccentButton(name: "Ajouter", color: .black, action: {
                let newTask = Task(name: taskName, date: taskDate, categories: selectedCategories)
                onTaskCreated(newTask)
                presentationMode.wrappedValue.dismiss()
            })
        }
        .padding()
        .background(Color("lightBlue"))
        .preferredColorScheme(.dark)
        
    }
}

struct TaskCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationScreen {_ in
            return
        }
        
    }
}
