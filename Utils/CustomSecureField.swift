//
//  CustomSecureField.swift
//  InstagramSwiftUI
//
//  Created by 1 on 28/09/21.
//

import SwiftUI

struct CustomSecureField: View {
        
        @Binding var text: String
        let placeholder: Text
        let imageName: String
        
        var body: some View {
            ZStack(alignment: .leading) {
                
                if text.isEmpty {
                    placeholder
                        .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                        .padding(.leading, 40)
                }
                
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                    
                    SecureField("", text: $text)
                        .padding(.leading, 13)
                } //: HSTACK
                
            } //: ZSTACK
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(text: .constant(""), placeholder: Text("Password"), imageName: "lock")
    }
}
