//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by 1 on 03/10/21.
//

import FirebaseFirestoreSwift
import Firebase // Timestamp

struct Post: Identifiable, Decodable {
    @DocumentID var id: String? //  var type have to optional because of Decodable
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageURL: String
    let timestamp: Timestamp
    let ownerImageURL: String
    
//    var user: User?
    
    var didLike: Bool? = false //  var type have to optional because of Decodable
}
