//
//  PlaybackbarView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI

struct PlaybackbarView: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var model: Model
    
    var body: some View {
        if let currentSong = model.currentSong {
            VStack {
                Spacer(minLength: 0)
                
                HStack {
                    Image(uiImage: currentSong.artwork?.image(at: CGSize(width: 100, height: 100))
                          ?? UIImage(named: "music_background")
                          ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "art", in: animation)
                        .frame(width: 70, height: 70)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(currentSong.title ?? "")
                            .font(.headline)
                        Text(currentSong.artist ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .matchedGeometryEffect(id: (currentSong.title ?? "") + "details",
                                           in: animation,
                                           properties: .position)
                    
                    Spacer(minLength: 0)
                    
                    HStack {
                        PlayPauseButton()
                            .environmentObject(model)
                            .matchedGeometryEffect(id: (currentSong.title ?? "") + "play_button", in: animation)
                            .font(.title)
                        
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .onTapGesture(count: 2, perform: {
                                model.musicPlayer.skipToPreviousItem()
                            })
                            .onTapGesture {
                                model.musicPlayer.skipToNextItem()
                            }
                    
                    }
                    .padding(.trailing)
                }
                .background(BlurView(style: .systemChromeMaterial))
                .matchedGeometryEffect(id: (currentSong.title ?? "") + "frame", in: animation)
            }
//            .onTapGesture {
//                model.isPlayerViewPresented.toggle()
//            }
        }
        
    }
}
