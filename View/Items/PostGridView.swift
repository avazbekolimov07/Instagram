//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI
import Kingfisher

// Re usable View shoud have its own view model and initialized to it 

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let widthImage = UIScreen.main.bounds.width / 3
    
    let config: PostGridConfiguration
    @ObservedObject var viewmodel : PostGridViewModel
    
    init(confic: PostGridConfiguration) {
        self.config = confic
        self.viewmodel = PostGridViewModel(config: config)
    }

    var body: some View {
        LazyVGrid(columns: items, spacing: 3) {
            ForEach(viewmodel.posts) { post in
                NavigationLink {
                    FeedCell(viewModel: FeedCellViewModel(post: post)) // destination
                } label: {
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: widthImage, height: widthImage)
                        .clipped()
                }  //: NAV LINK

            } //: LOOP
        } //: LAZY VGRID
    }
}
