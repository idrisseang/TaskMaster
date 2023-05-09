//
//  HomeView.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct HomeView: View {
    @Environment (\.scenePhase) private var scenePhase
    @StateObject private var tasksList = TaskList(tasks: [])
    @State private var isShowingNewTaskScreen = false
    @State private var selectedCategories: [String] = ["all"]
    @State private var selectedCategory: String = "maison"
    @State private var selectedTaskToDelete: Task?
    @State private var isShowingHour: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Categories")
                            .font(.system(size: 32, weight: .light))
                            .foregroundColor(.black)
                        Text("Cliquez sur une catégorie pour voir les tâches👇")
                            .foregroundColor(Color(white: 0.4))
                        CategorySelector(
                            selectedCategories: $selectedCategories,
                            selectedCategory: $selectedCategory,
                            isTaskCreationScreen: .constant(false) )
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Liste de tâches")
                                .font(.system(size: 32, weight: .light))
                                .foregroundColor(.black)
                            Spacer()
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .padding(.trailing)
                                .overlay {
                                    Button {
                                        isShowingNewTaskScreen = true
                                    } label: {
                                        Image(systemName: "plus")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color("AccentBlue"))
                                    }
                                    .padding(.trailing)
                                }
                        }
                        Text("Vous avez actuellement \(Text("\(tasksList.tasks.count)") .foregroundColor(.black)) tâches ")
                            .foregroundColor(Color(white: 0.4))
                        ForEach(tasksList.tasks) { task in
                            if selectedCategories.contains(task.category) || selectedCategories.contains("all") {
                                NavigationLink {
                                    TaskDetailView(task: task)
                                } label: {
                                    TaskCell(task: task) {
                                        selectedTaskToDelete = task
                                        withAnimation {
                                            tasksList.tasks.removeAll { taskToDelete in
                                                taskToDelete.id == selectedTaskToDelete!.id
                                            }
                                        }
                                        selectedTaskToDelete = nil
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color("lightBlue"))
        }
        .onChange(of: scenePhase, perform: { phase in
            if phase == .inactive {
                TaskList.save(tasks: tasksList.tasks) { result in
                    if case.failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        })
        .sheet(isPresented: $isShowingNewTaskScreen) {
            TaskCreationScreen(isShowingHour: $isShowingHour) { newTask in
                tasksList.tasks.append(newTask)
            }
        }
        .onAppear {
            TaskList.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let tasks):
                    tasksList.tasks = tasks
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
