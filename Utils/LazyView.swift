//
//  LazyView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 28/10/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content){
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
