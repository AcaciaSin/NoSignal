//
//  SongCardView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI
import MediaPlayer
//import SDWebImageSwiftUI

struct SongCardView: View {
    
    @EnvironmentObject var model: Model
    @State var artwork: UIImage = UIImage(named: "music_background") ??  UIImage()
//    @State var manager: ImageManager?
    @State var choosePlaylistOptionsPresented = false
    
    let song: MPMediaItem

    
    
    var body: some View {
        HStack {
            Image(uiImage: artwork)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
      
            
            VStack(alignment: .leading) {
                Text(song.title ?? "NA")
                    .font(.headline)
                Text(song.artist ?? "NA")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()

//            PlayPauseButton()
//                .environmentObject(model)
            Button(action: {
                let desc = MPMusicPlayerMediaItemQueueDescriptor(
                    itemCollection: MPMediaItemCollection(items: [song]))
                model.musicPlayer.setQueue(with: desc)
                model.musicPlayer.play()
            }, label: {
                Image(systemName: "play.fill")
                    .font(.title)
                    .opacity(0.0001)
            })
        }
        .onAppear() {
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = (song.artwork?.image(at: CGSize(width: 100, height: 100))) {
                    artwork = image
                }
            }
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
                    let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items:[song]))
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

