//
//  RTDBCodableApp.swift
//  RTDBCodable
//
//  Created by Hafiz on 03/10/2021.
//

import Firebase
import SwiftUI

@main
struct RTDBCodableApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(TaskViewModel())
        }
    }
}
