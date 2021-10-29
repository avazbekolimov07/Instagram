//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    @ObservedObject var viewModel: NotificationCellViewModel
    
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false}
    @State private var showPostImage = true
    
    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink {
                ProfileView(user: user)
                } label: {
                    KFImage(URL(string: viewModel.notification.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                
                    Text(viewModel.notification.username)
                        .font(.system(size: 14, weight: .semibold))
                    + Text(viewModel.notification.type.notificationMessage)
                        .font(.system(size: 15))
                    + Text(" \(viewModel.timestampString)")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }//: NAV
            }

            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink {
                        FeedCell(viewModel: FeedCellViewModel(post: post))
                    } label: {
                        KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                    }

                }
            } else {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Подписки" : "Подписаться")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? Color.black : Color.white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

            }
        } //: HSTACK
        .padding(.horizontal)
    }
}
