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
            .sorted(by: { $0.updatedAt > $1.updatedAt })
            .sorted(by: { !$0.completed && $1.completed })
        }
    }
    
    func addTask(title: String) {
        let id = UUID().uuidString
        ref.child("tasks/\(id)")
            .setValue([
                "id": id,
                "title": title,
                "completed": false,
                "updatedAt": Date().timeIntervalSince1970
            ])
    }
    
    func markComplete(id: String, completed: Bool) {
        ref.child("tasks/\(id)")
            .updateChildValues([
                "completed": completed,
                "updatedAt": Date().timeIntervalSince1970
            ])
    }
    
    func remove(id: String) {
        ref.child("tasks/\(id)").setValue(nil)
    }
}
