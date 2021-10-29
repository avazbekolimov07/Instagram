//
//  UserStatView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 27/09/21.
//

import SwiftUI

struct UserStatView : View {
    
    var topPart: String
    var bottomPart: String
    
    var body: some View {
        VStack {
            Text(topPart)
                .font(.system(size: 15, weight: .semibold))
            
            Text(bottomPart)
                .font(.system(size: 15))
                .lineLimit(1)
        } //: VSTACK
        .frame(width: 80, alignment: .center)
        
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(topPart: "8", bottomPart: "Публикация")
    }
}
