//
//  ImageUploader.swift
//  InstagramSwiftUI
//
//  Created by 1 on 29/09/21.
//

import UIKit
import Firebase

enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference { // StorageReference type because of line 19 and 21
        let filename = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_image/\(filename)")
        case .post:
            return Storage.storage().reference(withPath: "/post_image/\(filename)")
        }
    } // var filePath
}

struct ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = type.filePath

        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUD: Failed to upload image \(error.localizedDescription)")
                return
            }

            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else { return }
                completion(imageURL) //  completion is from static function arg
            }
        } //: PUT
    } //: static function
}


