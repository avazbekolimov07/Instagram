//
//  RegistrationView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 27/09/21.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                ZStack {
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                        
                    } else {
                        Button{
                            imagePickerPresented.toggle()
                        } label: {
                            Image("plus_photo")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .foregroundColor(Color.white)
                        } //: BUTTON
                        .sheet(isPresented: $imagePickerPresented) {
                            loadImage() // onDismiss
                        } content: {
                            ImagePicker(image: $selectedImage)
                        } //: sheet
                    }
                }  //: ZSTACK
                    
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomTextField(text: $username, placeholder: Text("User Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
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
                        
                        Button {
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 20)
                        } //: BUTTON
                    } //: HSTACK
                    
                    Button {
                        viewModel.register(withEmail: email, password: password, image: selectedImage, fullname: fullname, username: username)
                    } label: {
                        Text("Sign Up")
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
            } //: ZSTACK
        } //: Body
    } //: View


extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
