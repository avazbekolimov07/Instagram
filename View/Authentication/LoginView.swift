//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 27/09/21.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
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
                        
                        CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    } //: VSTACK
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            ResetPasswordView(email: $email)
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 20)
                        }

                    } //: HSTACK
                    
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color.purple)
                            .clipShape(Capsule())
                            .padding()
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up.")
                                .font(.system(size: 14, weight: .semibold))
                        } //: HSTACK
                        .foregroundColor(.white)
                    } //: NAV LINK
                    .padding(.bottom, 16)

                    
   
                } //: VSTACK
                .padding(.top, -44)
            } //: ZSTACK
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
