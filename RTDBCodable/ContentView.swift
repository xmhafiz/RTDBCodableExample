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
            List(viewModel.tasks.reversed(), id: \.id) { task in
                TaskRowView(task: task)
            }
            .navigationBarTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addTodo){
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func addTodo() {
        viewModel.addTask()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
