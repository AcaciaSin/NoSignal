//
//  PlaylistView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/19.
//

import SwiftUI

struct PlaylistView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            ScrollView {
                // smoother, while BlurView is not working
                ForEach(model.playlists.indices.filter{ $0 % 2 == 0 }, id: \.self) { index in
                    HStack(spacing: 0) {
                        if index < model.playlists.count {
                            PlaylistCardView(playlist: model.playlists[index])
                                .padding(7.5)
                                .drawingGroup()
                        }
                        
                        if index + 1 < model.playlists.count {
                            PlaylistCardView(playlist: model.playlists[index + 1])
                                .padding(7.5)
                                .drawingGroup()
                        }
                        
                    }
                }
                .padding(.horizontal, 7.5)
            }
            .navigationBarTitle(Text("Playlists"), displayMode: .automatic)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}

/*
 //                // Performance is not great, scrolling stutters because
 //                // LazyVgroup causes a lot of redraws ?
 //                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)],
 //                          spacing: 20) {
 //                    ForEach(model.playlists, id: \.self) { playlist in
 //                        PlaylistCardView(playlist: playlist)
 //                    }
 //                }
 //                          .padding(.horizontal, 20)
 //            }
 */
