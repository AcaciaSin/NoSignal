//
//  InvisibleRefreshView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI

struct InvisibleRefreshView: View {
    
    @EnvironmentObject var model: Model
 
    // 接收器
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { _ in
                if model.currentSong != model.musicPlayer.nowPlayingItem {
                    model.currentSong = model.musicPlayer.nowPlayingItem
                }
            }
    }
}

struct InvisibleRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        InvisibleRefreshView()
    }
}
