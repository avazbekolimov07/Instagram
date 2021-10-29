//
//  ResetPasswordView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 27/09/21.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var email: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Image("instagram")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white)
                    .frame(width: 220, height: 100)
                
                // email field
                
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                } //: VSTACK
                
                
                Button {
                    viewModel.resetPassword(withEmail: email)
                } label: {
                    Text("Send Reset Password Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .padding()
                }
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In.")
                            .font(.system(size: 14, weight: .semibold))
                    } //: HSTACK
                    .foregroundColor(.white)
                } //: BUTTON

            } //: VSTACK
            .padding(.top, -44)
        } //: ZSTACK
        .onReceive(viewModel.$didSendPasswordLink) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

