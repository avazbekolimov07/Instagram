//
//  SearchBar.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isEditing : Bool
    
    var body: some View {
        HStack {
            if isEditing {
                Button {
                    isEditing = false
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.system(size: 25, weight: .regular))
                }
                .padding(.trailing, 8)
                .transition(.move(edge: .leading))
                .animation(.default)
            } //: IF
            
            
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }  //: HSTACK
                ) //: OVERLAY
                .onTapGesture {
                    isEditing = true
                    text = ""
                    UIApplication.shared.endEditing()
                }
            
            } //: HSTACK
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"), isEditing: .constant(true))
    }
}
