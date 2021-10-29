//
//  FeedCellView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool {return viewModel.post.didLike ?? false}
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            // user info
            HStack {
                KFImage(URL(string: viewModel.post.ownerImageURL) )
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                    .background(
                    Circle()
                        .stroke(LinearGradient(colors:
                                                [Color.red,
                                                 Color.pink,
                                                 Color.orange,
                                                 Color.yellow],
                                               startPoint: .topTrailing,
                                               endPoint: .bottomLeading),
                                style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                               ) //: stroke
                    ) //: BACK
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.post.ownerUsername)
                            .font(.system(size: 14, weight: .semibold))
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 11))
                            .foregroundColor(Color.blue)
                    }
                    Text("Inha University in Tashkent")
                        .font(.system(size: 14, weight: .light))
                } //: VStack
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .font(.system(size: 20))
                        .padding(.trailing, 8)
                }
                .accentColor(Color.black)
                
            } //: HSTACK
            .padding(.leading, 8)
            
            // post image
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 440)
                .clipped()
            
            // action buttons
            HStack(spacing: 14) {
                Button {
                    withAnimation{
                        
                            didLike ? viewModel.unLike() : viewModel.like()
                        
                    }
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? Color.red : Color.black)
                        .frame(width: 22, height: 22)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                NavigationLink(destination: CommentsView(post: viewModel.post)) {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .font(.system(size: 20))
                        .padding(4)
                } // Commenting part link
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .font(.system(size: 20))
                }
            } //: HSTACK
            .padding(.horizontal, 10)
            .foregroundColor(Color.black)
            
            // caption
            Text("Нравиться: \(viewModel.post.likes)")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.vertical, 4)
            
            HStack {
                Text("\(viewModel.post.ownerUsername) ")
                    .font(.system(size: 14, weight: .semibold)) +
                Text("\(viewModel.post.caption)")
                    .font(.system(size: 14))
            } //: HSTACK
            .padding(.horizontal, 8)
            
            Text("\(viewModel.timestampString) дня назад")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
                .padding(.top, -3)

        } //: VSTACK
    }
}

