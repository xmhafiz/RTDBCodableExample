//
//  Task.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import Foundation

struct Task: Identifiable, Codable {
    var id: String = ""
    var title: String
    var completed = false
}

struct TaskObject: Codable {
    var task: Task
}
