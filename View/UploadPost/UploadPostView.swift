//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI

struct UploadPostView: View {
    
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @Binding var tabIndex: Int
    
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        VStack {
            if postImage == nil {
                Button {
                    self.imagePickerPresented.toggle()
                } label: {
                    Image("plus_photo")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .padding(.top, 56)
                        .foregroundColor(Color.black)
                }
                .sheet(isPresented: $imagePickerPresented) {
                    loadImage() // onDismiss
                } content: {
                    ImagePicker(image: $selectedImage)
                } //: sheet

            } else if let image = postImage {
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipped()

                    TextArea(text: $captionText, placeholder: "Введите подпись...")
                        .frame(height: 200)
                } //: HSTACK
                .padding()
                
                HStack {
                Button {
                            captionText = ""
                            postImage = nil // to go plus button
                } label: {
                    Image(systemName: "multiply")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.gray)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                }
                
                Button {
                    if let image = selectedImage {
                        viewModel.uploadPost(caption: captionText, image: image) { _ in
                            captionText = ""
                            postImage = nil // to go plus button
                            tabIndex = 0
                        }
                    }
                } label: {
                    Text("Поделиться")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 270, height: 50)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .foregroundColor(Color.white)
                }
                } //: HSTACK
                .padding()

                Spacer()
            }  // else
            
        } //: VSTACK
    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
