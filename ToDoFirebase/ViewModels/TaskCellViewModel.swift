//
//  TaskCellViewModel.swift
//  ToDoFirebase
//
//  Created by Will Saults on 6/23/20.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository = TaskRepository()
    
    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
        .map { task in
            task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
        
        $task
        .compactMap { task in
            task.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        
        // Happens anytime there is a change
        // Includes typing updates which can be intensive
        $task
        .dropFirst()
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .sink { task in
            self.taskRepository.updateTask(task)
        }
        .store(in: &cancellables)
    }
}
