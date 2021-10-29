//
//  ProfileActionButton.swift
//  InstagramSwiftUI
//
//  Created by 1 on 27/09/21.
//

import SwiftUI

struct ProfileActionButton: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false}
    
    @State var showEditProfile: Bool = false
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button {
                showEditProfile.toggle()
            } label: {
                Text("Редактировать профиль")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: UIScreen.main.bounds.width - 50, height: 32)
                    .foregroundColor(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } //: BUTTON
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(user: $viewModel.user)
            }
        } else {
            HStack {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow() 
                } label: {
                    Text(isFollowed ? "Подписки" : "Подписаться")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 32)
                        .foregroundColor(isFollowed ? Color.black : Color.white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } //: BUTTON
                
                Button {
                    
                } label: {
                    Text("Написать")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 32)
                        .foregroundColor(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } //: BUTTON
            } //: HSTACK
            
        }
    }
}

