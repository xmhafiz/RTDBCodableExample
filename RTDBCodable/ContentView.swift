//
//  ContentView.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
