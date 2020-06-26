//
//  ContentView.swift
//  ToDoFirebase
//
//  Created by Will Saults on 6/22/20.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListViewModel.taskCellViewModels) { taskCellViewModel in
                        TaskCell(taskCellViewModel: taskCellViewModel)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListViewModel.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add new task")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm) {
                SignInView()
            }
            .navigationBarItems(trailing:
                Button(action: { self.showSignInForm.toggle() } ) {
                    Image(systemName: "person.circle")
                }
            )
            .navigationBarTitle("Tasks")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellViewModel.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellViewModel.task.completed.toggle()
                }
            TextField("Enter the task title", text: $taskCellViewModel.task.title, onCommit: {
                self.onCommit(self.taskCellViewModel.task)
            })
        }
    }
}
