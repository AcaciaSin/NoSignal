//
//  RemoteSongCardView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/22.
//

import SwiftUI
import MediaPlayer
import SDWebImageSwiftUI

struct RemoteSongCardView: View {
    
    @EnvironmentObject var model: Model
    @State var artwork: UIImage = UIImage(named: "music_background") ??  UIImage()
    @State var manager: ImageManager?
    @State var choosePlaylistOptionsPresented = false
    
    let song: Song

    
    
    var body: some View {
        HStack {
//            Image(uiImage: artwork)
            WebImage(url: URL(string: song.artworkUrl.replacingOccurrences(of: "{w}", with: "\(Int(70) * 2)".replacingOccurrences(of: "{h}", with: "\(Int(70) * 2)"))))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
      
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .font(.headline)
                Text(song.artist)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()

            Button(action: {
                DispatchQueue.main.async {
                    model.musicPlayer.setQueue(with: [song.id])
                    model.musicPlayer.play()
                }

            }, label: {
                Image(systemName: "play.fill")
                    .font(.title)
                    .opacity(0.0001)
            })
        }

        .contextMenu {
            Button(action: {
                choosePlaylistOptionsPresented.toggle()
            }, label: {
                Text("Add to Playlist")
            })
            
            Button(action: {
                model.musicPlayer.perform(queueTransaction: { queue in
                    let afterItem = queue.items.last
                    let desc = MPMusicPlayerStoreQueueDescriptor(storeIDs: [song.id])
                    return queue.insert(desc, after: afterItem)
                }) { (queue, error) in
                    if error != nil {
                        print(error!)
                    }
                }
            }, label: {
                Text("Add to queue")
            })
        }
//        .padding(10)
    }
}

