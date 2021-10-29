//
//  NotificationsViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        let query = Firestore.firestore().collection("notifications").document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            self.notifications = documents.compactMap{ try? $0.data(as: Notification.self)}
        }
    }
    
    static func uploadNotifications(toUid uid: String, type: NotificaitonType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard uid != user.id else {return} // owner of post cannot send notification to itself
        
        var data: [String : Any] = ["timestamp" : Timestamp(date: Date()),
                                    "username" : user.username,
                                    "uid" : user.id ?? "",
                                    "profileImageURL" : user.profileImageURL,
                                    "type" : type.rawValue]
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        Firestore.firestore().collection("notifications").document(uid).collection("user-notications")
            .addDocument(data: data)
        
        
    }
}
