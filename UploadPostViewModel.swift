//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by 1 on 02/10/21.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost(caption: String, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else {return}
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            let data = ["caption" : caption,
                        "timestamp" : Timestamp(date : Date()),
                        "likes" : 0,
                        "imageURL" : imageURL,
                        "ownerUid" : user.id ?? "",
                        "ownerImageURL" : user.profileImageURL,
                        "ownerUsername" : user.username] as [String : Any]
            Firestore.firestore().collection("posts").addDocument(data: data, completion: completion) // firestore
    
        } // ImageUploader
    } //: FUNC
}
