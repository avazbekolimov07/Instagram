//
//  Extensions.swift
//  InstagramSwiftUI
//
//  Created by 1 on 26/09/21.
//

import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

