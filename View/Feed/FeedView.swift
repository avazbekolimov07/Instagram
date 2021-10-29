//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI

struct FeedView: View {
    // because FeedViewModel has no parametrs
    //, it just equalized to @ObservedObject 
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post))
                }
            } //: VSTACK
//            .padding(.top)
        } //: SCROLL
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
