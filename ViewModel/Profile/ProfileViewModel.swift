//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 30/09/21.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject{
    @Published var user: User
    
    init(user: User) { // to initialize @published 
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func follow() {
        guard let uid = user.id else {return}
        UserService.follow(uid: uid) { error in
            self.user.isFollowed = true //completion part
            
            NotificationsViewModel.uploadNotifications(toUid: uid, type: .follow)
        }
    } //: FUNC
    
    func unfollow() {
        guard let uid = user.id else {return}
        UserService.unfollow(uid: uid) { error in
            self.user.isFollowed = false //  competion part
        }
    } //: FUNC
    
    func checkIfUserIsFollowed() {
        guard !user.isCurrentUser else {return} // current user can't follow yourself
        guard let uid = user.id else {return}
        
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    } //: FUNC
    
    func fetchUserStats() {
        guard let uid = user.id else {return}
        
        Firestore.firestore().collection("following").document(uid).collection("user-following")
            .getDocuments { snapshot, error in
                guard let following = snapshot?.documents.count else {return}
                
                Firestore.firestore().collection("followers").document(uid).collection("user-followers")
                    .getDocuments { snapshot, error in
                        guard let followers = snapshot?.documents.count else {return}
                        
                        Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: uid)
                            .getDocuments { snapshot, error in
                                guard let posts = snapshot?.documents.count else {return}
                                
                                self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                        } //: post count
                    } //: followers count
            } //: following count
    } //: FUNC
} //: class
