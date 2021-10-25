//
//  TaskViewModel.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks = [Task]()
    private let ref = Database.database().reference()
    private let dbPath = "tasks"
    
    init() {
        initListener()
    }
    
    func initListener() {
        ref.child(dbPath).observe(.value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            self.tasks = children.compactMap { snapshot in
                return try? snapshot.data(as: Task.self)
            }
            .sorted(by: { $0.updatedAt > $1.updatedAt })
            .sorted(by: { !$0.completed && $1.completed })
        }
    }
    
    func addTask(title: String) {
        guard let autoId = ref.child(dbPath).childByAutoId().key else {
            return
        }
        let task = Task(id: autoId, title: title)
        do {
            try ref.child("\(dbPath)/\(task.id)")
                .setValue(from: task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func markComplete(id: String, completed: Bool) {
        ref.child("\(dbPath)/\(id)")
            .updateChildValues([
                "completed": completed,
                "updatedAt": Date().timeIntervalSince1970
            ])
    }
    
    func remove(id: String) {
        ref.child("\(dbPath)/\(id)").setValue(nil)
    }
}
