//
//  ContentView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = Model.shared
    @State var selection = 0
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        
        ZStack {
            InvisibleRefreshView()
                .environmentObject(model)
                .opacity(0.00001)
            
            TabView(selection: $selection) {
                PlaylistView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note.list")
                            Text("Playlists")
                        }
                    }
                    .tag(0)
                
                LibraryView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note")
                            Text("Library")
                        }
                    }
                    .tag(1)
                
                SearchView(viewModel: viewModel)
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)


                UserView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("User")
                        }
                    }
                    .tag(3)
            }
            .zIndex(1.0)
            
            NowPlayingView()
                .environmentObject(model)
                .zIndex(2.0)
        }
        .accentColor(.pink)
        .onAppear() {
            // 接口暂时无法访问
//            DispatchQueue.global(qos: .userInitiated).async {
//                _ = AppleMusicAPI.shared
//            }
            
        }
    }
}


