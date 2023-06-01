//
//  InteriorDesignerApp.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 14/05/2023.
//

import SwiftUI
import Firebase

@main
struct InteriorDesignerApp: App {
    init() {
            // NOTE: You need to add your own GoogleService-Info.plist to this Xcode project so that it points to your Firestore database instance
        FirebaseApp.configure()        }
    var body: some Scene {
        WindowGroup {
            SignInButton()
        }
    }
}
