//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 03/10/21.
//

import SwiftUI
import Firebase

enum PostGridConfiguration {
    case search
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    let config: PostGridConfiguration
    
    init(config: PostGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridConfiguration) {
        
        
        switch config {
        case .search:
            fetchSearchPagePost()
        case .profile(let uid):
            fetchUserPost(forUid: uid)
        }
    } //: FUNC
    
    func fetchSearchPagePost() {
        // Get documnets from firestore
        // likes goes first
        Firestore.firestore().collection("posts").order(by: "likes", descending: true).getDocuments { snapshot, error in
            guard let documnets = snapshot?.documents else {return}
            
            self.posts = documnets.compactMap{ snapshot -> Post? in
                return try? snapshot.data(as: Post.self)
            }
        } //: Firestore
    } //: FUNC
    
    func  fetchUserPost(forUid uid: String) {
        Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            
            let postS = documents.compactMap{ snapshot -> Post? in
                return try? snapshot.data(as: Post.self)
            }
            self.posts = postS.sorted{ $0.timestamp.dateValue() > $1.timestamp.dateValue() }
        }
    }
    
} //: CLASS
