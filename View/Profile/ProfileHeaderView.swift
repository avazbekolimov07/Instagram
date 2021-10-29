//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI
import Kingfisher //to work with images from internet

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16) {
//                    if let stats = viewModel.user.stats {
//                        UserStatView(topPart: "\(stats.posts)", bottomPart: "Публикация")
//                        UserStatView(topPart: "\(stats.followers)", bottomPart: "Подписчики")
//                        UserStatView(topPart: "\(stats.following)", bottomPart: "Подписки")
//                    }
                    UserStatView(topPart: "\(viewModel.user.stats?.posts ?? 0)", bottomPart: "Публикация")
                    UserStatView(topPart: "\(viewModel.user.stats?.followers ?? 0)", bottomPart: "Подписчики")
                    UserStatView(topPart: "\(viewModel.user.stats?.following ?? 0)", bottomPart: "Подписки")
                    
                } //: HSTACK
                .padding(.trailing, 12)
            } //: HSTACK
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding(.leading)
                .padding(.top, 4)
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 1)
            }
            
            HStack {
                Spacer()
                
                ProfileActionButton(viewModel: viewModel)
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 30, height: 32)
                        .foregroundColor(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Spacer()
            } //: HSTACK
            .padding(.top, 8)

            
        } //: VSTACK
    }
}
