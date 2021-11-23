//
//  PlaylistDetailView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/20.
//

import SwiftUI
import MediaPlayer

struct PlaylistDetailView: View {
    
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme
    let playlist: MPMediaItemCollection
    
    var body: some View {
        List {
            HStack {
//                Spacer(minLength: 0)
                VStack {
                    Image(uiImage: playlist.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "music_background") ?? UIImage())
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 30)
                    
                    VStack {
                        Text("\(playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "NA")")
                            .bold()
                            .font(.title2)
                        
                        HStack {
                            HStack {
                                Spacer(minLength: 0)
                                Image(systemName: "play.fill")
                                Text("Play")
                                Spacer(minLength: 0)
                            }
                            .foregroundColor(.accentColor)
                            .padding(10)
                            .background(BlurView(style: .systemUltraThinMaterialDark)
                                            .opacity(colorScheme == .light ? 0.3 : 0.8))
                            .cornerRadius(10)
                            .onTapGesture {
                                let desc = MPMusicPlayerMediaItemQueueDescriptor(
                                    itemCollection: MPMediaItemCollection(items: playlist.items))
                                
                                model.musicPlayer.setQueue(with: desc)
                                model.musicPlayer.play()
                            }
                            
                            HStack {
                                Spacer(minLength: 0)
                                Image(systemName: "shuffle")
                                Text("Shuffle")
                                Spacer(minLength: 0)
                            }
                            .foregroundColor(.accentColor)
                            .padding(10)
                            .background(BlurView(style: .systemUltraThinMaterialDark)
                                            .opacity(colorScheme == .light ? 0.3 : 0.8))
                            .cornerRadius(10)
                            .onTapGesture {
                                let desc = MPMusicPlayerMediaItemQueueDescriptor(
                                    itemCollection: MPMediaItemCollection(items: playlist.items))
                            
                                model.musicPlayer.setQueue(with: desc)
                                model.musicPlayer.play()
                            }
                        }
                        
                    }
                }
                Spacer(minLength: 0)
                
            }
            .padding()
            
            ForEach(playlist.items, id:\.self) { song in
                SongCardView(song: song)
                    .environmentObject(model)
            }
            
//            Rectangle()
//                .frame(height: 100)
//                .foregroundColor(.clear)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Text("\(playlist.items.count) Songs")
            })
        }
//        .navigationBarHidden(true)
    }
}
