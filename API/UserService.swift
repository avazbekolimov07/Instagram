//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by 1 on 30/09/21.
//

import Firebase

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService {
    
    static func follow(uid: String, completion: ((Error?) -> Void)?) { // func inside of func
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        // 1 step create collection "following"
        Firestore.firestore().collection("following").document(currentUid) // current user id following
         .collection("user-following").document(uid).setData([:]) { error in // whom id user is following
        // 2 step create collection "follower"
                Firestore.firestore().collection("followers").document(uid) // whom id is followed by user
                 .collection("user-followers").document(currentUid).setData([:], completion: completion) // user id who follows
            }
    } //: FUNC
    
    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        // 1 step delete from "following" collection
        Firestore.firestore().collection("following").document(currentUid) // current user id unfollowing
         .collection("user-following").document(uid).delete { error in // whom id user is un following
        // 2 step delete from "followers" collection
                Firestore.firestore().collection("followers").document(uid) // whom id is unfollowed by user
                 .collection("user-followers").document(currentUid).delete(completion: completion) // user id who unfollows
            }
        
    } //: FUNC
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        
        Firestore.firestore().collection("following").document(currentUid)
            .collection("user-following").document(uid).getDocument { snapshot, error in
                guard let isFollowed = snapshot?.exists else {return}
                completion(isFollowed)
            }
    } //: FUNC
    
}
