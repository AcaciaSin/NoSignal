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
    
    
    @State var views = [
        TabItem(tag: 1, title: Text("Playlist"), image: Image(systemName: "music.note.list"),view: AnyView(PlaylistView())),
        TabItem(tag: 2, title: Text("Library"), image: Image(systemName: "music.note"), view: AnyView(LibraryView())),
//        TabItem(tag: 2, title: Text("Search"), image: Image(systemName: "magnifyingglass"), view: AnyView(SearchView()))
        TabItem(tag: 3, title: Text("User"), image: Image(systemName: "person.fill"), view: AnyView(UserView())),
    ]
    
    var body: some View {
        ZStack {
            InvisibleRefreshView()
                .environmentObject(model)
                .opacity(0.00001)
            
            
            TabView(selection: $selection) {
                SearchView(viewModel: viewModel)
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(0)
                
                ForEach(views) { view in
                    view.view
                        .environmentObject(model)
                        .tabItem {
                            VStack {
                                view.image
                                view.title
                            }
                        }
                        .tag(view.tag)
                }
            }
            .zIndex(1.0)
//            .id(myArray.count + 2)
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            NowPlayingView()
                .environmentObject(model)
                .zIndex(2.0)
        }
        .accentColor(.indigo)
        .onAppear() {
            // 接口暂时无法访问
//            DispatchQueue.global(qos: .userInitiated).async {
//                _ = AppleMusicAPI.shared
//            }
            
        }
    }
}


struct TabItem: Identifiable {
    var id = UUID()
    var tag: Int
    var title: Text
    var image: Image
    var view: AnyView = AnyView(PlaylistView())
}

// You cannot declare a property of type View because View is a protocol with an associated type.
// Instead, you need to declare destinationView to be of a type that conforms to the View protocol.
