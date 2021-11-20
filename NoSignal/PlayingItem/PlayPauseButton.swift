//
//  PlayPauseButton.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI

struct PlayPauseButton: View {
    
    @EnvironmentObject var model: Model
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
//        if let currentSong = model.currentSong {
        Image(systemName: model.isPlaying ? "pause.fill" : "play.fill")
            .onReceive(timer, perform:  { _ in
                let isPlaying = model.musicPlayer.playbackState == .playing
                if model.isPlaying != isPlaying {
                    model.isPlaying = isPlaying
                }
                
            })
//                .matchedGeometryEffect(id: currentSong.title ?? "" + "play_button", in: animation)
//                .font(.largeTitle)
                .onTapGesture {
                    if model.musicPlayer.playbackState == .paused || model.musicPlayer.playbackState == .stopped {
                        model.musicPlayer.play()
                        withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.7)) {
                            model.isPlaying = true;
                        }
                    } else {
                        model.musicPlayer.pause()
                        withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.7)) {
                            model.isPlaying = false;
                        }
                    }
                }
//        }
        

    }
}

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton()
    }
}
