//
//  HomeView.swift
//  RTDBCodable
//
//  Created by Hafiz on 04/10/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                AddTaskView()
                List {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        TaskRowView(task: task)
                    }
                    .onDelete(perform: deleteRow)
                }
                .animation(.default)
            }
            .navigationBarTitle("Todo")
        }
    }
    
    private func deleteRow(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let taskId = viewModel.tasks[index].id
        viewModel.remove(id: taskId)
    }
}
