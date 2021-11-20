//
//  SongCardView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI
import MediaPlayer

struct SongCardView: View {
    
    @EnvironmentObject var model: Model
    
    let song: MPMediaItem
    
    var body: some View {
        HStack {
            Image(uiImage: song.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "music_background") ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))
      
            
            VStack(alignment: .leading) {
                Text(song.title ?? "NA")
                Text(song.artist ?? "NA")
                    .font(.caption)
            }
            
            Spacer()
            
//            PlayPauseButton()
//                .environmentObject(model)
            Image(systemName: "play.fill")
                .font(.title)
                .onTapGesture {
                    model.musicPlayer.setQueue(with: MPMediaItemCollection(items: [song]))
                    model.musicPlayer.play()
                }
            

        }
        .padding(10)
    }
}

