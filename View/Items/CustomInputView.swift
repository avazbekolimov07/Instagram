//
//  CustomInputView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 23/10/21.
//

import SwiftUI

struct CustomInputView: View {
    
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack {
                TextField("Message...", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action){
                    Text("Send")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }

            } //: HSTACK  
            .padding(.bottom, 8)
            .padding(.horizontal)
        } //: VSTACK
    }
}
