//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 29/10/21.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete: Bool = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserBio(newBio bio: String) {
        guard let uid = user.id else {return}
        Firestore.firestore().collection("users").document(uid).updateData(["bio" : bio]) { error in
            self.user.bio = bio
            self.uploadComplete = true
        }
    }
}
