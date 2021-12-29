//
//  NeteaseSearchView.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI
import NeumorphismSwiftUI
import Combine

struct NeteaseSearchView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var showCancell = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    BackWardButton()
                    TextField("搜索",
                              text: $searchViewModel.key,
                              onEditingChanged: { isEditing in
                        showCancell = isEditing
                    }, onCommit: { searchViewModel.search() })
                        .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "magnifyingglass")))
                    if showCancell {
                        Button(action: {
                            hideKeyboard()
                        }, label: {
                            Text("取消")
                        })
                    }
                }
                .padding(.horizontal)
                Picker(selection: $searchViewModel.searchType, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) /*@START_MENU_TOKEN@*/{
                    Text("单曲").tag(NCMSearchType.song)
                    Text("歌单").tag(NCMSearchType.playlist)
                }/*@END_MENU_TOKEN@*/
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if searchViewModel.requesting {
                    Text("Loading...")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    switch searchViewModel.searchType {
                    case .song:
                        // EmptyView()
                        SearchSongResultView(songs: searchViewModel.result.songs)
                    case .playlist:
                        VStack {
                            EmptyView()
                            Spacer()
                        }
//                        SearchPlaylistResultView(playlists: searchViewModel.result.playlists)
                    default:
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            searchViewModel.search()
        }
    }
}

//struct SearchPlaylistResultView: View {
//    let playlists: [SearchPlaylistResponse.Result.Playlist]
//
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(playlists) { item in
//                    NavigationLink(destination: FetchedPlaylistDetailView(id: Int(item.id))) {
//                        SearchPlaylistResultRowView(viewModel: item)
//                            .padding(.horizontal)
//                    }
//                }
//            }
//            .padding(.vertical)
//        }
//    }
//}

struct SearchPlaylistResultRowView: View {
    let viewModel: SearchPlaylistResponse.Result.Playlist
    
    var body: some View {
        HStack(alignment: .top) {
            RectangleCoverView(viewModel.coverImgUrl, style: CoverStyle(size: .little, shape: .rectangle))
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .foregroundColor(Color.mainText)
                Text("\(viewModel.trackCount) songs")
                    .foregroundColor(Color.secondTextColor)
            }
            Spacer()
        }
    }
}

struct SearchSongResultView: View {
    let songs: [NeteaseSong]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(songs) { item in
                    NeteaseSongRowView(searchViewModel: .init(item))
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

struct NeteaseSearchBarView: View {
    @State private var key: String = ""
    @State private var showSearch: Bool = false
    @State private var showCancel = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: NeteaseSearchView(searchViewModel: SearchViewModel(key: key)), isActive: $showSearch) {
                EmptyView()
            }
            HStack {
                TextField("搜索",
                          text: $key,
                          onEditingChanged: { isEditing in showCancel = isEditing },
                          onCommit: {
                    guard !key.isEmpty else { return }
                    showSearch = true
                })
                    .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "magnifyingglass")))
                if showCancel {
                    Button(action: {
                        key = ""
                        hideKeyboard()
                    }, label: {
//                        Text("取消")
                        Image(systemName: "xmark.square")
                            .foregroundColor(.secondary)
                    })
                }
            }
        }
    }
}
