//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageURL))
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(comment.username).font(.system(size: 14, weight: .semibold)) +
            Text(" \(comment.commentText)").font(.system(size: 14))
            
            Spacer()
            
            Text(" \(comment.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        } //: HSTACK
        .padding(.horizontal)
    }
}
