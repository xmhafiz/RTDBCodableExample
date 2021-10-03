//
//  TaskViewModel.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import Combine
import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class TaskViewModel: ObservableObject {
    @Published var tasks = [Task]()
    let ref = Database.database().reference()
    
    init() {
        initListener()
    }
    
    func initListener() {
        ref.child("tasks").observe(.value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            self.tasks = children.compactMap { snapshot in
                return try? snapshot.data(as: Task.self)
            }
        }
    }
    
    func addTask() {
        let id = UUID().uuidString
        ref.child("tasks/\(id)")
            .setValue([
                "id": id,
                "title": "Task Example",
                "completed": false
            ])
    }
    
    func markComplete(id: String, completed: Bool) {
        ref.child("tasks/\(id)")
            .updateChildValues([
                "completed": completed
            ])
    }
}
