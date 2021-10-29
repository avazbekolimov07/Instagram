//
//  InstagramSwiftUIApp.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI
import Firebase

@main
struct InstagramSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure() 
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
