//
//  UserView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI

struct UserView: View {
    @State var aboutUs: Bool = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        if self.aboutUs {
            AboutView(aboutUs: $aboutUs)
                .environmentObject(model)
        } else {
            ProfileHeader(aboutUs: $aboutUs)
                .environmentObject(model)
                .environmentObject(Store.shared)
                .environmentObject(Player.shared)
        }
    }
}
