//
//  Comment.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String? //  var type have to optional because of Decodable
    let username: String
    let postOwnerUid: String
    let profileImageURL: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
    
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        // from posted day to Date() -> current time
        return formatter.string(from:  timestamp.dateValue(), to: Date()) ?? ""
    }
}
