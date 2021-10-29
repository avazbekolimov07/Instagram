//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 03/10/21.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    
    @Published var post : Post
    
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        // from posted day to Date() -> current time
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
//        fetchFeedUser()
    }
    
    
    func like() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        // new doc(in post coll) with sub-collection post-liked with post Id
        Firestore.firestore().collection("posts").document(postId).collection("post-liked")
            .document(currentUid).setData([:]) { _ in // post-liked by current Uid
        // new doc(in user coll) with sub-collection user-likes with user Uid
                Firestore.firestore().collection("users").document(currentUid).collection("user-likes")
                    .document(postId).setData([:]) { _ in // liked post id
                        
                        DispatchQueue.main.async {
                            Firestore.firestore().collection("posts").document(postId).updateData(["likes" : self.post.likes + 1])
                            
                        }
                            self.post.didLike = true
                            self.post.likes += 1
                            
                        
                        
                        NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid,
                                                                   type: .like, post: self.post)
                    }
            }
        
    } //: FUNC
    func unLike() {
        guard post.likes > 0 else {return}
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        Firestore.firestore().collection("posts").document(postId).collection("post-liked")
            .document(currentUid).delete { _ in
                Firestore.firestore().collection("users").document(currentUid).collection("user-likes")
                    .document(postId).delete { _ in
                        
                        DispatchQueue.main.async {
                            Firestore.firestore().collection("posts").document(postId).updateData(["likes" : self.post.likes - 1])
                        } // asyn
                            self.post.didLike = false
                            self.post.likes -= 1
                        
                        
                    }
            }
        
    } //: FUNC
    func checkIfUserLikedPost() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        Firestore.firestore().collection("users").document(currentUid).collection("user-likes")
            .document(postId).getDocument { snapshot, error in
                guard let didLike = snapshot?.exists else {return} // exist means true
                self.post.didLike = didLike
            }
    } //: FUNC
    
//    func fetchFeedUser() {
//        Firestore.firestore().collection("users").document(post.ownerUid).getDocument { snapshot, error in
//            self.post.user = try? snapshot?.data(as: User.self)
//        }
//    }
}
