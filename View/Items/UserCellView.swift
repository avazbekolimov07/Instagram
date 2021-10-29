//
//  UserCellView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import SwiftUI
import Kingfisher

struct UserCellView: View {
    // Cell work with model
    let user: User
    
    var body: some View {
        HStack {
            
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                Text(user.fullname)
                    .font(.system(size: 14))
            } //: VSTACK
            .foregroundColor(Color.black)
            
            Spacer()
            
        } //: HSTACK
    }
}

