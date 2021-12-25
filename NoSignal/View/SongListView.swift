//
//  SongListView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI

struct SongListView: View {
    @EnvironmentObject private var store: Store
    @State private var showPlayingNow: Bool = false
    @State private var showLike: Bool = false
    
    let songs: [Song]
    
    var body: some View {
        VStack {
            NavigationLink(destination: PlayingNowView(), isActive: $showPlayingNow, label: {EmptyView()})
                .navigationViewStyle(StackNavigationViewStyle())
            HStack {
                Button(action: {
                    if showLike {
                        let likeIds = Store.shared.appState.playlist.songlikedIds
                        Store.shared.dispatch(.PlayerPlaySongs(songs: songs.map(NeteaseSong.init)
                                                                .filter({ likeIds.contains($0.id) })))
                    } else {
                        Store.shared.dispatch(.PlayerPlaySongs(songs: songs.map(NeteaseSong.init)))
                    }
                    Store.shared.dispatch(.playerPlayBy(index: 0))
                }) {
                    Text(showLike ? "播放收藏" : "播放全部")
                        .fontWeight(.bold)
                        .padding(.leading)
                }
                Spacer()
                Text("只看收藏")
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                Toggle("", isOn: $showLike)
                    .toggleStyle(CheckboxStyle())
                    .fixedSize()
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack {
                    ForEach(songs) { item in
                        if !showLike || store.appState.playlist.songlikedIds.contains(Int(item.id)) {
                            QinSongRowView(searchViewModel: .init(item.asNeteaseSong()))
                                .padding(.horizontal)
                                .onTapGesture {
                                    if Int(item.id) == Store.shared.appState.playing.song?.id {
                                        showPlayingNow.toggle()
                                        Store.shared.dispatch(.songLyricRequest(id: Int(item.id)))
                                    }
                                    
                                }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
 
    }
}
