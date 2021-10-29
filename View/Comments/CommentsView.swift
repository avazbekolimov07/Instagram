//
//  CommentsView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import SwiftUI

struct CommentsView: View {
    
    @State var commentText = ""
    @ObservedObject var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    func uploadComment() {
        viewModel.uploadComment(commentText: commentText)
        commentText = ""
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                            
                    } //: LOOP
                } // LAZY VSTACK
            } //SCROLL
            .padding(.top)
            
            CustomInputView(inputText: $commentText, action: uploadComment)
        } // VSTACK
    } //: BODY
} //: STRUCT

