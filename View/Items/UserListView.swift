//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    @Binding var searchText: String
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink {
                        LazyView(ProfileView(user: user)) // destination
                    } label: {
                        UserCellView(user: user)
                            .padding(.leading)
                    } //: NAV LINK
                    
                    } //: LOOP
                } //: LAZY VSTACK
            } //: SCROLL
        }
    }


