//
//  ProgressView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI

struct PlayingProgressView: View {
    
    @EnvironmentObject var model:Model
    
    @State private var downloadAmount = 0.0
    
    // todo:
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if let currentSong = model.musicPlayer.nowPlayingItem {
            ProgressView("",
                         value:downloadAmount,
                         total: currentSong.playbackDuration)
                .onReceive(timer, perform: {_ in
                    downloadAmount = model.musicPlayer.currentPlaybackTime
                })
        }
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingProgressView()
    }
}
