//
//  SearchView.swift
//  NoSignal
//
//  Created by student9 on 2021/11/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var model: Model
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        NavigationView {
                VStack {
                    SearchBar(searchTerm: $viewModel.searchTerm)
                    if viewModel.songs.isEmpty {
                        VStack {
                            Spacer()
                            EmptyStateView()
                            Spacer()
                        }
                    } else {
                        VStack {
                            List(viewModel.songs) { song in
                                SearchSongCardView(song: song)
                            }
                            .listStyle(PlainListStyle())
                        }
                    }

                }
                .navigationBarTitle(Text("Search"), displayMode: .automatic)
            }

    }
}

struct ArtworkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}


// apple music 写法
//@State var searchText = ""
//@State var searchResult = [Song]()
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
//                    TextField("Artists, Songs, Lyrics, and More", text: $searchText, onCommit: {
//                        UIApplication.shared.resignFirstResponder()
//                        if searchText.isEmpty {
//                            searchResult = [Song]()
//                        } else {
//                            // API calling
//                            searchResult = AppleMusicAPI.shared.search(query: searchText)
//                        }
//                    })
                    // todo: 取消当前播放的 View
//                        .onTapGesture {
//                        }
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
