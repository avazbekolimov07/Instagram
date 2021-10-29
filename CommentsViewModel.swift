//
//  CommentsViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    private let post: Post
    @Published var comments = [Comment]()
    
    
    init(post: Post){
        self.post = post
        fetchComment()
    }
    
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        
        let data: [String : Any] = ["username": user.username,
                    "profileImageURL": user.profileImageURL,
                    "uid": user.id ?? "",
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerUid": post.ownerUid,
                    "commentText": commentText]
        
        Firestore.firestore().collection("posts").document(postId)
            .collection("post-comments").addDocument(data: data) { error in
                if let error = error {
                    print("Error DEBUG \(error.localizedDescription)")
                }
                
                NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid,
                                                           type: .comment, post: self.post)
            }
    }
    
    func fetchComment() {
        guard let postId = post.id else { return }
        
        // Real time databse
        let query = Firestore.firestore().collection("posts").document(postId).collection("post-comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else {return}
            
            self.comments.append(contentsOf: addedDocs.compactMap({try? $0.document.data(as: Comment.self)}))
            
//            snapshot?.documentChanges.forEach({ change in
//                if change.type == .added {
//                    guard let comment = try? change.document.data(as: Comment.self) else {return}
//                    self.comments.append(comment)
//                }
//            })
        }
    } //: Func Fetching
}
