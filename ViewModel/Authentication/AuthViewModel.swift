//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 29/09/21.
//

import SwiftUI
import Firebase

class AuthViewModel : ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // backend current
    @Published var currentUser: User? // fontend current
    @Published var didSendPasswordLink: Bool = false
    
    static let shared = AuthViewModel()
    
    init() { // to initialize
        userSession = Auth.auth().currentUser // firebase current
        fetchUser()
    }
    
    //MARK: - Login function
    
    func login(withEmail email: String, password: String) {
        
        // SignIn
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // check error
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user // backend usering
            // to refresh change in current user data
            self.fetchUser()
            
        } //: Auth singIn
    } //: FUNC
    
    //MARK: - Registration function
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        
        // To Upload image ini STORAGE
        // Call ImageUploader struct and its static function
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
            
            // CreateUser()
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                // check error
                if let error = error  {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else { return } // se line 74
                
                let data = ["email": email,
                            "username": username,
                            "fullname" : fullname,
                            "profileImageURL": imageURL, // imageURL from uploaderImage
                            "uid": user.uid] // to fetch information from user documnet
    
                // Set Data ( document with user.uid) with Firestore
                // to get documnet id from user.uid
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                    self.userSession = user // making it firebase current user
                    // to refresh change in cuccrent user data
                    self.fetchUser()
                } // Firestore
            } // Auth createUser
        } //: STATIC Image Uploader FUNC
    } //: FUNC
    
    //MARK: - Signou function
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    } //: FUNC
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
                    return
            }
            
            self.didSendPasswordLink = true
            
        }
    }
    
    //MARK: - FetchUser function
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            // 1 - option
            // guard let dictionary = snapshot else { return }
            // guard let username = dictionary["username"] as? String else {return}
            // let user = User(username: user.username, email: , profileImageURL: , fullname: , id: )
            
            // 2 - option
            guard let user = try? snapshot?.data(as: User.self) else {return}
            self.currentUser = user // fontend current user
        } // get document
    } //: FUNC
}
