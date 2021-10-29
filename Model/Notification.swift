//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String? //  var type have to optional because of Decodable
    var postId: String?
    let username: String
    let profileImageURL: String
    let timestamp: Timestamp
    let type: NotificaitonType
    let uid: String
    
    var isFollowed: Bool? = false //  var type have to optional because of Decodable
    var post: Post?
    var user: User?
}

enum NotificaitonType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return " понравилось ваше фото."
        case .comment: return " прокомментировал(а) ваш пост."
        case .follow: return " подписался на вас."
        }
    }
}
