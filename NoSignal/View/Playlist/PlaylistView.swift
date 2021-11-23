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
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20)],
                          spacing: 20) {
                    ForEach(model.playlists, id:\.self) { playlist in
                        
                        NavigationLink (destination: PlaylistDetailView(playlist: playlist),
                                        label: {
                            PlaylistCardView(playlist: playlist).drawingGroup()
                        })

                    }
                }
                .padding(.horizontal, 20)
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
