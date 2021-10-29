//
//  NotificationCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 28/10/21.
//

import SwiftUI
import Firebase

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        // from posted day to Date() -> current time
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(notification: Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func follow() {
        UserService.follow(uid: notification.uid) { error in
            self.notification.isFollowed = true //completion part
            
            NotificationsViewModel.uploadNotifications(toUid: self.notification.uid, type: .follow)
        }
    } //: FUNC
    
    func unfollow() {
        UserService.unfollow(uid: notification.uid) { error in
            self.notification.isFollowed = false //  competion part
        }
    } //: FUNC
    
    func checkIfUserIsFollowed() {
        guard notification.type == .follow else {return}
        UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
            self.notification.isFollowed = isFollowed
        }
    } //: FUNC
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        
        Firestore.firestore().collection("posts").document(postId).getDocument { snapshot, error in
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
    } //: FUNC
    
    func fetchNotificationUser() {
        Firestore.firestore().collection("users").document(notification.uid).getDocument { snapshot, error in
            self.notification.user = try? snapshot?.data(as: User.self)
        }
    }
}

