//
//  TaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation

enum TaskType {
    case BodyMovement
    case DailyTask
}

enum BodyMovementType {
    case turningHead
    case twistingBody
    case pullingBody
}

struct TaskItem {
    public var name: String
    public var coin: Int
    public var amount: Int  // How much the user has to move
    public var description: String
    public var image: String
    public var taskType: TaskType
    public var movementType: BodyMovementType?
}

class TaskModel {
    @Published var tasks: [TaskItem]?
    
    init(tasks: [TaskItem]? = nil) {
        self.tasks = tasks
    }
}
