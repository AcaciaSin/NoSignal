//
//  PlayerControlBarView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI

struct PlayerControlBarView: View, NEUStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var player: Player
    
    private var playing: AppState.Playing { store.appState.playing }

    var body: some View {
        HStack {
            ZStack {
                ProgressView(value: player.loadPercent)
                    .progressViewStyle(NEURingProgressViewStyle())
                    .padding()
                    .frame(width: 90, height: 90)
                Button(action: {
                    if let song = store.appState.playing.song {
                        Store.shared.dispatch(.playerTogglePlay(song: song))
                    }
                }) {
                    Image(systemName: player.isPlaying ? "pause" : "play.fill")
                        .font(.title)
                }
            }
            
            NavigationLink(destination: PlayingNowView()) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(playing.song?.name ?? "")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .lineLimit(1)
    
                        HStack {
                            HStack {
                                ForEach(playing.song?.artists ?? []) { item in
                                    Text(item.name ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            Button(action: {
                Store.shared.dispatch(.playerPlayForward)
                Store.shared.dispatch(.songLyricRequest(id: playing.song!.id))
            }) {
                Image(systemName: "forward.fill")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.trailing)
            }
        }
        .padding(.trailing)
        .background(BlurView(style: .systemChromeMaterial))
    }
}


