//
//  NeteaseSongRowView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI
import Combine

class NeteaseSongViewModel: ObservableObject {
    var song: NeteaseSong

    @Published var like: Bool = false
    @Published var playing: Bool = false
    @Published var isPlaying: Bool = false

    init<Song>(_ song: Song) where Song: NeteaseSongable {
        self.song = song.asNeteaseSong()
        config()
    }
    
    private func config() {
        let songId = song.id
        Store.shared.appState.playlist.$songlikedIds.map { $0.contains(songId) }.assign(to: &$like)
        Store.shared.appState.playing.$song.map { $0?.id == songId }.assign(to: &$playing)
        Publishers.CombineLatest(Player.shared.$isPlaying, Store.shared.appState.playing.$song).map { playing, song in
            playing && song?.id == songId
        }.assign(to: &$isPlaying)
    }
    
    func toogleLike() {
        like = !like
    }
    
    func togglePlay() {
        Store.shared.dispatch(.playerTogglePlay(song: song))
    }
}

struct NeteaseSongRowView: View {
    @ObservedObject var searchViewModel: NeteaseSongViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                searchViewModel.toogleLike()
            }, label: {
                Image(systemName: searchViewModel.like ? "heart.fill" : "heart")
                    .padding(.horizontal)
                    .font(.title2)
            })
                .padding(.trailing, 1)
                .padding(.leading, 1)
            
            VStack(alignment: .leading) {
                Text(searchViewModel.song.name ?? "Unknown")
                    .fontWeight(.bold)
                    .lineLimit(1)
                HStack {
                    ForEach(searchViewModel.song.artists.compactMap(\.name), id: \.self) { item in
                        Text(item)
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()

            Button(action: {
                searchViewModel.togglePlay()
            }) {
                Image(systemName: searchViewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.title2)
            }
        }
        .padding(10)
        .background(
            NEUListRowBackgroundView(isHighlighted: searchViewModel.playing)
        )
    }
}

