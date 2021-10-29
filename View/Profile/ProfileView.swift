//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    // viewModel = ProfileViewModel(user: user) =>
    // it is head in assignment
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                
                PostGridView(confic: .profile(user.id ?? ""))
                    .padding(6)
            }
            .padding(.top)
        }
    }
}
