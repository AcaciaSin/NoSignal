//
//  FetchedPlaylistDetailView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/23.
//

import SwiftUI
import NeumorphismSwiftUI
import Combine

struct FetchedPlaylistDetailView: View {
    @State private var show: Bool = false

    let id: Int
    
    var body: some View {
        ZStack {
            VStack {
                CommonNavigationBarView(id: id, title: "歌单详情", type: .playlist)
                    .padding(.horizontal)
                    .font(.title3)
                    .onAppear {
                        DispatchQueue.main.async {
                            show = true
                        }
                    }
                if show {
                    FetchedResultsView(entity: Playlist.entity(), predicate: NSPredicate(format: "%K == \(id)", "id")) { (results: FetchedResults<Playlist>) in
                        if let playlist = results.first {
                            PlaylistDetailView(playlist: playlist)
                        } else {
                            Text("正在加载")
                                .onAppear {
                                    print(results)
                                    Store.shared.dispatch(.playlistDetailRequest(id: id))
                                }
                            Spacer()
                        }
                    }
                } else {
                    Text("正在加载")
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PlaylistDetailView: View {
    @EnvironmentObject private var store: Store
    private var subedPlaylistIDs: [Int] { store.appState.playlist.subedPlaylistIds }
    @ObservedObject var playlist: Playlist
    @State private var showPlaylistSongsManage: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            DescriptionView(viewModel: playlist)
            HStack {
                Spacer()
                if !Store.shared.appState.playlist.createdPlaylistIds.contains(Int(playlist.id)) {
                    Button(action: {
                        let id = playlist.id
                        let sub = !subedPlaylistIDs.contains(Int(id))
                        Store.shared.dispatch(.playlistSubscibeRequest(id: Int(id), sub: sub))
                    }) {
                        if Store.shared.appState.playlist.userPlaylistIds.contains(Int(playlist.id)) {
                            Image(systemName: "bookmark.fill")
                                .font(.headline)
                            Text("取消收藏")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            Image(systemName: "bookmark")
                                .font(.headline)
                            Text("收藏")
                                .font(.subheadline)
                        }
                    }
                } else {
                    Button(action: {
                        showPlaylistSongsManage.toggle()
                    }) {
                        NeteaseSongCoverView(systemName: "lineweight",
                                  size: .small)
                            .sheet(isPresented: $showPlaylistSongsManage) {
                                PlaylistSongsManageView(showSheet: $showPlaylistSongsManage, playlist: playlist)
                            }
                    }
                }
            }
            .padding(.horizontal)
            if let songs = playlist.songs?.allObjects as? [Song] {
                if let songsId = playlist.songsId {
                    SongListView(songs: songs.sorted(by: { (left, right) -> Bool in
                        let lIndex = songsId.firstIndex(of: left.id)
                        let rIndex = songsId.firstIndex(of: right.id)
                        return lIndex ?? 0 > rIndex ?? 0 ? false : true
                    }))
                } else {
                    Spacer()
                }
            } else {
                Spacer()
            }
        }
    }
}

struct CommonNavigationBarView: View {
    enum CommonNavigationBarType {
        case album, artist, mv, playlist
    }
    let id: Int
    let title: String
    let type: CommonNavigationBarType
    
    var body: some View {
        HStack {
            BackWardButton()
            Spacer()
            Button(action: {
                switch type {
                case .album:
                    Store.shared.dispatch(.albumDetailRequest(id: id))
                case .artist:
                    Store.shared.dispatch(.artistDetailRequest(id: id))
                case .mv:
                    Store.shared.dispatch(.mvDetailRequest(id: id))
                case .playlist:
                    if id == 0 {
                        Store.shared.dispatch(.recommendSongsRequest)
                    } else {
                        Store.shared.dispatch(.playlistDetailRequest(id: id))
                    }
                }
            }){
                NeteaseSongCoverView(systemName: "arrow.triangle.2.circlepath", size: .big, inactiveColor: .accentColor)
            }
            PlayingNowButtonView()
        }
        .overlay(
            HStack {
                MyNavigationBarTitleView(title)
            }
        )
    }
}

