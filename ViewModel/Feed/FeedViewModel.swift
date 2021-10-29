//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 03/10/21.
//

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() { // Fetching decumnets
        
        // Get documnets from firestore
        Firestore.firestore().collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documnets = snapshot?.documents else {return}
            
            self.posts = documnets.compactMap{ snapshot -> Post? in
                return try? snapshot.data(as: Post.self)
            }
        } //: Firestore
    } //: FUNC
    
    
    
} // class
