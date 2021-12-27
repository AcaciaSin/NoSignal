//
//  ContentView.swift
//  NoSignalAR
//
//  Created by student9 on 2021/12/26.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    //    @ObservedObject var viewModel: SongListViewModel    // viewModel 维护 Itunes API 的搜索
    @State var selection = 0                            // TabView 选择器
    @ObservedObject var model = Model.shared            // Model 维护 Apple Music 的 MediaPlayer
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var player: Player
    private var album: AppState.Album { store.appState.album }
    private var artist: AppState.Artist { store.appState.artist }
    private var playlist: AppState.Playlist { store.appState.playlist }
    private var user: User? { store.appState.settings.loginUser }

    var body: some View {
        ZStack {
            InvisibleRefreshView()
                .environmentObject(model)
                .opacity(0.00001)

            
            TabView(selection: $selection) {
                if model.SearchToggle {
                    NavigationView {
                        VStack {
                            HStack(spacing: 20.0) {
                                NeteaseSearchBarView()
                                Spacer(minLength: 4)
                            }
                            Spacer()
                            EmptyStateView(theme: $model.themeColor)
                            Spacer()
                        }
                        .navigationBarTitle("Search", displayMode: .automatic)
                    }
//                    SearchView(viewModel: SongListViewModel())
//                        .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(0)
                }
                
                if model.PlaylistToggle {
                    if user != nil {
                        NavigationView {
                            VStack(spacing: 0) {
                                HStack(spacing: 20.0) {
                                    NeteaseSearchBarView()
                                }
                                .padding([.leading, .bottom, .trailing])
                                Divider()
                                if store.appState.initRequestingCount == 0 {
                                    ScrollView {
                                        VStack {
                                            RecommendPlaylistView(playlist: playlist.recommendPlaylist)
                                                .padding(.top, 10)
                                            Divider()
                                            CreatedPlaylistView(playlist: playlist.userPlaylist.filter({ $0.userId == user?.userId }))
                                                .padding(.top, 10)
                                            Divider()
                                            SubedPlaylistView(playlist: playlist.userPlaylist.filter({ $0.userId != user?.userId }))
                                                .padding(.top, 10)
                                            Divider()
                                            SubedAlbumsView(albums: album.albumSublist)
                                                .padding(.top, 10)
//                                            Divider()
    //                                        ArtistSublistView(artists: artist.artistSublist)
//                                                .padding(.top, 10)
                                        }
                                    }
                                    PlayerControlBarView()
                                } else {
                                    Spacer()
                                }
                            }
                            .navigationBarHidden(true)
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            VStack {
                                Image(systemName: "music.note.list")
                                Text("Playlist")
                            }
                        }
                        .tag(1)
                    } else {
                        PlaylistView()
                            .environmentObject(model)
                            .tabItem {
                                VStack {
                                    Image(systemName: "music.note.list")
                                    Text("Playlist")
                                }
                            }
                            .tag(1)
                    }


                }
                
                if model.LibraryToggle {
                    LibraryView()
                        .environmentObject(model)
                        .tabItem {
                            VStack {
                                Image(systemName: "music.note")
                                Text("Library")
                            }
                        }
                        .tag(2)
                }
                
                UserView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("User")
                        }
                    }
                    .tag(3)
                
                if model.ARToggle {
                    ARMusicView()
                        .tabItem {
                            VStack {
                                Image(systemName: "person.fill")
                                Text("AR")
                            }
                        }
                        .tag(4)
                }


            }
            .zIndex(1.0)
            
            if user == nil {
                NowPlayingView()
                    .environmentObject(model)
                    .zIndex(2.0)
                    .opacity(selection == 3 || selection == 0 ? 0 : 1)
            } else {
                NowPlayingView()
                    .environmentObject(model)
                    .zIndex(2.0)
                    .opacity(selection == 2 ? 1 : 0)
            }


        }
        .alert(item: $store.appState.error) { error in
            Alert(title: Text(error.localizedDescription))
        }
        .accentColor(model.themeColor)
    }
}



