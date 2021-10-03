//
//  AddTaskView.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import SwiftUI

struct AddTaskView: View {
    @State private var taskTitle: String = ""
    @EnvironmentObject private var viewModel: TaskViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Enter New Task..", text: $taskTitle, onCommit: handleSubmit)
            Button(action: handleSubmit) {
                Image(systemName: "plus")
            }
        }
        .padding(20)
    }
    
    private func handleSubmit() {
        viewModel.addTask(title: taskTitle)
        taskTitle = ""
    }
}
