//
//   EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 29/10/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var bioText: String
    // since inside of EditProfileViewModel we have an object of user
    // so we need to initialize it
    @ObservedObject var viewModel: EditProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var user: User
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button {
                    viewModel.saveUserBio(newBio: bioText)
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                }
            } //: HStack
            .padding()
            .overlay(
            Text("Edit Profile")
            )
            
            TextArea(text: $bioText, placeholder: "Add you bio")
                .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                .padding(.vertical)
            Spacer()
        } //: VSTACK
        .onReceive(viewModel.$uploadComplete) { completed in
            if completed {
                self.presentationMode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        }
    }
}
