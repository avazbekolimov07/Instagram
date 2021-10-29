//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 30/09/21.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        
        // Get documnets from Firestore
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap { snapshot -> User? in
                return try? snapshot.data(as: User.self)
                        
            /* Below code is equal =
             documents.forEach { snapshot in
                 guard let user = try? snapshot.data(as: User.self) else {return}
                 self.users.append(user)
             }
             
             OR
             
             self.user = documents.compactMap({ try? $0.data(as: User.self) })
             */
            } // to fill user from documents
        } // Firestore
    } //: FUNC
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery)})
    }
    
} //: class
