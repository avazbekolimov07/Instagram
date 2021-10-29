//
//  User.swift
//  InstagramSwiftUI
//
//  Created by 1 on 30/09/21.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String? // decodable var should be with optional
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String    
    var isFollowed: Bool? = false // decodable var should be with optional
    
//    let uid: String
    var bio: String?
    var stats: UserStats?
    var isCurrentUser: Bool {return AuthViewModel.shared.userSession?.uid == id}
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}
