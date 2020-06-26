//
//  ToDoFirebaseApp.swift
//  ToDoFirebase
//
//  Created by Will Saults on 6/22/20.
//

import SwiftUI
import Firebase

@main
struct ToDoFirebaseApp: App {
    init() {
        FirebaseApp.configure()
        
        // Only sign in Anonymously if the user has not already signed in.
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
