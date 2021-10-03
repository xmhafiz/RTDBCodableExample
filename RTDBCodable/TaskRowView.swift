//
//  TaskRowView.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    let task: Task
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                viewModel.markComplete(id: task.id, completed: !task.completed)
            }) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(task.completed ? Color.green : Color.gray)
            }
            .buttonStyle(PlainButtonStyle())
            Text(task.title)
            Spacer()
        }
        .padding()
    }
}
