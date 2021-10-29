//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by 1 on 25/09/21.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView {
        
            TabView(selection: $selectedIndex) {
           FeedView()
                .onTapGesture {
                        selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            
           SearchView()
                .onTapGesture {
                        selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            UploadPostView(tabIndex: $selectedIndex)
                .onTapGesture {
                        selectedIndex = 2
                 }
                 .tabItem {
                     Image(systemName: "plus.square")
                 }.tag(2)
            
           NotificationsView()
                .onTapGesture {
                        selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "heart")
                }.tag(3)
            
           ProfileView(user: user)
                .onTapGesture {
                        selectedIndex = 4
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(4)
            
        } //: TAB View
        .accentColor(Color.black) // tint color inside of image( bosganda toldirib turadigan rang).
            
        .navigationBarItems(
            leading:
                logoutButton
            ,trailing:
                Image(systemName: "bolt.horizontal.circle")
        ) // BAR ITEM

        } //: NAV View
        
    } //: BODY
    
    var logoutButton: some View {
        HStack {
            
            Button {
                AuthViewModel.shared.signout()
            } label: {
                Text("Выйти.")
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
            } //: BUTTON
            
            Text("Instagram").font(Font.custom("Billabong", size: 40))
                .padding(.leading, 50)
        }
    } // logoutButton Body
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New Post"
        case 3: return "Notification"
        case 4: return "Profile"
        default: return ""
        } // switch
    }
} // struct ends
